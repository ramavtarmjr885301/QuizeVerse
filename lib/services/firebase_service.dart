import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/question_model.dart';
import '../models/user_model.dart';
import 'dart:math';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on PlatformException catch (e) {
      if (e.code == 'network_error') {
        throw Exception(
          'No internet connection. Please check your network and try again.',
        );
      }
      throw Exception('Google sign in failed: ${e.message}');
    } on FirebaseAuthException catch (e) {
      throw Exception('Google sign in failed: ${e.message}');
    } catch (e) {
      throw Exception('Google sign in failed: $e');
    }
  }

  static Future<UserCredential> linkGuestToGoogle() async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      throw Exception('No user is currently signed in.');
    }
    if (!currentUser.isAnonymous) {
      throw Exception('This account is already a registered account.');
    }

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign-in was cancelled.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final linkedCredential = await currentUser.linkWithCredential(credential);
      return linkedCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'credential-already-in-use') {
        throw Exception(
          'This Google account is already linked to another profile. '
          'Please use a different Google account.',
        );
      } else if (e.code == 'provider-already-linked') {
        throw Exception('This account is already linked to Google.');
      } else if (e.code == 'network-request-failed') {
        throw Exception('No internet connection. Please try again.');
      }
      throw Exception('Failed to link account: ${e.message}');
    } catch (e) {
      throw Exception('Failed to link account: $e');
    }
  }

  static Future<UserCredential> signInAnonymously() async {
    try {
      if (_auth.currentUser != null) {}
      final result = await _auth.signInAnonymously();
      return result;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'admin-restricted-operation') {
        throw Exception(
          'Anonymous authentication is not enabled. '
          'Please enable it in Firebase Console > Authentication > Sign-in methods.',
        );
      }
      throw Exception('Failed to sign in: ${e.message}');
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  static Future<void> createUser(String uid, {String? name}) async {
    try {
      final user = UserModel(
        uid: uid,
        name: name ?? 'Player',
        email: '',
        coins: 50,
      );
      await _firestore.collection('users').doc(uid).set(user.toFirestore());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  static Future<void> deleteAccount(String uid) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user is currently signed in.');

      await _firestore.collection('users').doc(uid).delete();

      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception(
          'For security, please sign in again before deleting your account.',
        );
      }
      throw Exception('Failed to delete account: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  static Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) return null;
      return UserModel.fromFirestore(doc.data()!, uid);
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  static Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  static Future<List<QuestionModel>> getQuestions({int limit = 1000}) async {
    // int limit =1000 is just a safety cap — actual fetch happens once per 24h via cache layer
    try {
      final snapshot = await _firestore
          .collection('questions')
          .limit(limit)
          .get();

      if (snapshot.docs.isEmpty) {
        return QuestionModel.getSampleQuestions();
      }

      return snapshot.docs.map((doc) {
        return QuestionModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      return QuestionModel.getSampleQuestions();
    }
  }

  static Future<List<QuestionModel>> getQuestionsByCategory(
    String category, {
    int limit =
        1000, // Safety cap only — actual fetch happens once per 24h via cache layer
  }) async {
    try {
      final snapshot = await _firestore
          .collection('questions')
          .where('category', isEqualTo: category)
          .limit(limit)
          .get();

      if (snapshot.docs.isEmpty) {
        return _fallbackForCategory(category);
      }

      return snapshot.docs
          .map((doc) => QuestionModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      return _fallbackForCategory(category);
    }
  }

  static List<QuestionModel> _fallbackForCategory(String category) {
    final filtered = QuestionModel.getSampleQuestions()
        .where((q) => q.category == category)
        .toList();
    return filtered.isNotEmpty ? filtered : QuestionModel.getSampleQuestions();
  }

  static Future<void> addQuestion(QuestionModel question) async {
    try {
      await _firestore.collection('questions').add(question.toFirestore());
    } catch (e) {
      throw Exception('Failed to add question: $e');
    }
  }

  static Stream<QuerySnapshot> getLeaderboard() {
    return _firestore
        .collection('users')
        .where(
          'highScore',
          isGreaterThan: 0,
        ) // only users who've actually played
        .orderBy('highScore', descending: true)
        .limit(100)
        .snapshots();
  }
  /* also for hiding geust accounts
  static Stream<QuerySnapshot> getLeaderboard() {
    return _firestore
        .collection('users')
        .where('highScore', isGreaterThan: 0)
        .orderBy('highScore', descending: true)
        .limit(100)
        .snapshots();
  }
  */

  static String _todayDateString() {
    final now = DateTime.now();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    return '${now.year}-$month-$day';
  }

  static Future<List<QuestionModel>> getDailyQuestions() async {
    final dateStr = _todayDateString();
    final dailyDocRef = _firestore.collection('dailyQuestions').doc(dateStr);

    try {
      final questions = await _firestore.runTransaction<List<QuestionModel>>((
        transaction,
      ) async {
        final snapshot = await transaction.get(dailyDocRef);

        if (snapshot.exists && snapshot.data()?['questions'] != null) {
          final rawList = List<Map<String, dynamic>>.from(
            snapshot.data()!['questions'],
          );
          return rawList
              .map((q) => QuestionModel.fromFirestore(q, q['id'] ?? ''))
              .toList();
        }

        final allQuestionsSnapshot = await _firestore
            .collection('questions')
            .get();

        if (allQuestionsSnapshot.docs.isEmpty) {
          return QuestionModel.getSampleQuestions();
        }

        final pool = allQuestionsSnapshot.docs
            .map((doc) => QuestionModel.fromFirestore(doc.data(), doc.id))
            .toList();
        pool.shuffle(Random());
        final selected = pool.take(10).toList();

        final toStore = selected
            .map((q) => {...q.toFirestore(), 'id': q.id})
            .toList();

        transaction.set(dailyDocRef, {
          'questions': toStore,
          'generatedAt': FieldValue.serverTimestamp(),
        });

        return selected;
      });

      return questions;
    } catch (e) {
      return QuestionModel.getSampleQuestions();
    }
  }

  static Future<void> markDailyChallengeCompleted(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'lastDailyChallengeDate': _todayDateString(),
      });
    } catch (e) {
      debugPrint('Mark daily challenge completed error: $e');
    }
  }

  static Future<bool> updateStreak(String uid) async {
    try {
      final user = await getUser(uid);
      if (user == null) return false;

      final today = DateTime.now();
      final lastPlayed = user.lastPlayedDate;

      int newStreak = user.streakDays;

      if (lastPlayed == null) {
        newStreak = 1;
      } else {
        final difference = today.difference(lastPlayed).inDays;
        if (difference == 0) {
          return true;
        } else if (difference == 1) {
          newStreak += 1;
        } else {
          newStreak = 1;
        }
      }

      await updateUser(uid, {'lastPlayedDate': today, 'streakDays': newStreak});

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> spendCoins(String uid, int amount) async {
    final docRef = _firestore.collection('users').doc(uid);

    try {
      return await _firestore.runTransaction<bool>((transaction) async {
        final snapshot = await transaction.get(docRef);
        final currentCoins = (snapshot.data()?['coins'] ?? 0) as int;

        if (currentCoins < amount) {
          return false;
        }

        transaction.update(docRef, {'coins': currentCoins - amount});
        return true;
      });
    } catch (e) {
      debugPrint('Spend coins error: $e');
      return false;
    }
  }

  static Future<void> addCoins(String uid, int amount) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'coins': FieldValue.increment(amount),
        'totalCoinsEarned': FieldValue.increment(amount),
      });
    } catch (e) {
      throw Exception('Failed to add coins: $e');
    }
  }

  static bool isAnonymousAuthEnabled() {
    return true;
  }
}

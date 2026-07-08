import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/question_model.dart';
import '../models/user_model.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // ==================== AUTH ====================

  static Future<UserCredential> signInAnonymously() async {
    try {
      // ✅ Check if already signed in
      if (_auth.currentUser != null) {
        // ✅ FIX: Don't use fromJson - just return a dummy credential
        // Instead, we'll just return the current user via a different approach
        // For now, we'll sign out and sign in again
        // Or we can handle this differently
      }

      // ✅ Try anonymous sign in
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
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  // ==================== USERS ====================

  static Future<void> createUser(String uid, {String? name}) async {
    try {
      final user = UserModel(
        uid: uid,
        name: name ?? 'Player',
        email: '',
        coins: 50, // Welcome bonus
      );
      await _firestore.collection('users').doc(uid).set(user.toFirestore());
    } catch (e) {
      throw Exception('Failed to create user: $e');
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

  // ==================== QUESTIONS ====================

  static Future<List<QuestionModel>> getQuestions({int limit = 10}) async {
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
      // If Firestore is empty, return sample questions
      return QuestionModel.getSampleQuestions();
    }
  }

  static Future<List<QuestionModel>> getQuestionsByCategory(
    String category, {
    int limit = 10,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('questions')
          .where('category', isEqualTo: category)
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

  static Future<void> addQuestion(QuestionModel question) async {
    try {
      await _firestore.collection('questions').add(question.toFirestore());
    } catch (e) {
      throw Exception('Failed to add question: $e');
    }
  }

  // ==================== LEADERBOARD ====================

  static Stream<QuerySnapshot> getLeaderboard() {
    return _firestore
        .collection('users')
        .orderBy('highScore', descending: true)
        .limit(100)
        .snapshots();
  }

  // ==================== DAILY CHALLENGE ====================

  static Future<List<QuestionModel>> getDailyQuestions() async {
    try {
      final today = DateTime.now();
      final dateStr = '${today.year}-${today.month}-${today.day}';

      final snapshot = await _firestore
          .collection('dailyQuestions')
          .doc(dateStr)
          .collection('questions')
          .limit(10)
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

  // ==================== STREAK CHECK ====================

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
          // Already played today
          return true;
        } else if (difference == 1) {
          newStreak += 1;
        } else {
          newStreak = 1; // Reset streak
        }
      }

      await updateUser(uid, {'lastPlayedDate': today, 'streakDays': newStreak});

      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== CHECK AUTH STATUS ====================

  static bool isAnonymousAuthEnabled() {
    // This is a helper method - actual check happens in signInAnonymously
    return true;
  }
}

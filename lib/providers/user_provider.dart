import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class UserProvider extends ChangeNotifier {
  final SharedPreferences prefs;

  UserProvider({required this.prefs});

  UserModel? _user;
  bool _isLoading = false;
  bool _isGuest = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isGuest => _isGuest;
  bool get isLoggedIn => _user != null;

  // Initialize - Check if user exists in SharedPreferences
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      final uid = prefs.getString('user_uid');
      if (uid != null) {
        final userData = await FirebaseService.getUser(uid);
        if (userData != null) {
          _user = userData;
          _isGuest = false;
        } else {
          await prefs.remove('user_uid');
        }
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      final credential = await FirebaseService.signInWithGoogle();

      if (credential == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final firebaseUser = credential.user;
      final uid = firebaseUser?.uid;

      if (uid != null) {
        var userData = await FirebaseService.getUser(uid);

        if (userData == null) {
          await FirebaseService.createUser(
            uid,
            name: firebaseUser?.displayName ?? 'Player',
          );
          userData = await FirebaseService.getUser(uid);
        }

        if (userData != null) {
          _user = userData;
          _isGuest = false;
          await prefs.setString('user_uid', uid);
          _isLoading = false;
          notifyListeners();
          return true;
        }
      }
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint('Google sign in error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Upgrade guest account to permanent Google account (preserves all data)
  Future<bool> linkGuestToGoogle() async {
    if (_user == null || !_isGuest) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final credential = await FirebaseService.linkGuestToGoogle();
      final firebaseUser = credential.user;

      if (firebaseUser != null) {
        // Update Firestore doc with the real name/email now available
        await FirebaseService.updateUser(_user!.uid, {
          'name': firebaseUser.displayName ?? _user!.name,
          'email': firebaseUser.email ?? '',
        });

        final updatedUser = await FirebaseService.getUser(_user!.uid);
        if (updatedUser != null) {
          _user = updatedUser;
          _isGuest = false; // no longer a guest — now a registered account
          notifyListeners();
        }
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow; // let UI show the specific error message
    }
  }

  // Sign in as Guest (Anonymous)
  Future<bool> signInAsGuest() async {
    _isLoading = true;
    notifyListeners();

    try {
      final credential = await FirebaseService.signInAnonymously();
      final uid = credential.user?.uid;

      if (uid != null) {
        var userData = await FirebaseService.getUser(uid);

        if (userData == null) {
          await FirebaseService.createUser(
            uid,
            name: 'Guest${uid.substring(0, 4)}',
          );
          userData = await FirebaseService.getUser(uid);
        }

        if (userData != null) {
          _user = userData;
          _isGuest = true;
          await prefs.setString('user_uid', uid);
          _isLoading = false;
          notifyListeners();
          return true;
        }
      }
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint('Guest sign in error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await FirebaseService.signOut();
    await prefs.remove('user_uid');
    _user = null;
    _isGuest = false;
    notifyListeners();
  }

  // Delete account permanently
  Future<bool> deleteAccount() async {
    if (_user == null) return false;

    try {
      await FirebaseService.deleteAccount(_user!.uid);
      await prefs.remove('user_uid');
      _user = null;
      _isGuest = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Delete account error: $e');
      rethrow; // let UI show the specific error message
    }
  }

  // Called after each answered question (coins + correct/wrong count)
  Future<void> recordQuizResult({
    required bool isCorrect,
    required int coinsEarned,
  }) async {
    if (_user == null) return;

    final data = <String, dynamic>{
      'coins': _user!.coins + coinsEarned,
      if (isCorrect)
        'correctAnswers': _user!.correctAnswers + 1
      else
        'wrongAnswers': _user!.wrongAnswers + 1,
    };

    try {
      await FirebaseService.updateUser(_user!.uid, data);
      final updatedUser = await FirebaseService.getUser(_user!.uid);
      if (updatedUser != null) {
        _user = updatedUser;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Record quiz result error: $e');
    }
  }

  // NEW: Called ONCE when a full quiz session ends (on ResultScreen).
  // Updates gamesPlayed, highScore (if beaten), and streak — in one flow.
  Future<void> finishQuiz(int finalScore) async {
    if (_user == null) return;

    final data = <String, dynamic>{
      'gamesPlayed': _user!.gamesPlayed + 1,
      if (finalScore > _user!.highScore) 'highScore': finalScore,
    };

    try {
      await FirebaseService.updateUser(_user!.uid, data);
      await FirebaseService.updateStreak(_user!.uid);

      final updatedUser = await FirebaseService.getUser(_user!.uid);
      if (updatedUser != null) {
        _user = updatedUser;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Finish quiz error: $e');
    }
  }

  // Generic update (kept for any other future use)
  Future<void> updateUser(Map<String, dynamic> data) async {
    if (_user == null) return;

    try {
      await FirebaseService.updateUser(_user!.uid, data);
      final updatedUser = await FirebaseService.getUser(_user!.uid);
      if (updatedUser != null) {
        _user = updatedUser;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Update user error: $e');
    }
  }

  // Refresh user data
  Future<void> refreshUser() async {
    if (_user == null) return;

    try {
      final userData = await FirebaseService.getUser(_user!.uid);
      if (userData != null) {
        _user = userData;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Refresh user error: $e');
    }
  }
}

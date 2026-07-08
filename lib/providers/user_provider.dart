import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class UserProvider extends ChangeNotifier {
  final SharedPreferences prefs;

  UserProvider({required this.prefs});

  UserModel? _user;
  bool _isLoading = false;
  bool _isGuest = true;

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
          // User deleted from Firebase, clear local
          await prefs.remove('user_uid');
        }
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Sign in as Guest (Anonymous)
  Future<bool> signInAsGuest() async {
    _isLoading = true;
    notifyListeners();

    try {
      final credential = await FirebaseService.signInAnonymously();
      final uid = credential.user?.uid;

      if (uid != null) {
        // Check if user exists in Firestore
        var userData = await FirebaseService.getUser(uid);

        if (userData == null) {
          // Create new user with welcome bonus
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

  // Update user data
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

  // Add coins
  Future<void> addCoins(int amount) async {
    if (_user == null) return;

    final newCoins = (_user!.coins + amount);
    await updateUser({'coins': newCoins});
  }

  // Update high score
  Future<void> updateHighScore(int score) async {
    if (_user == null) return;
    if (score > _user!.highScore) {
      await updateUser({'highScore': score});
    }
    // Always increment games played
    await updateUser({'gamesPlayed': (_user!.gamesPlayed + 1)});
  }

  // Update correct/wrong answers
  Future<void> updateAnswers({required bool correct}) async {
    if (_user == null) return;

    if (correct) {
      await updateUser({'correctAnswers': (_user!.correctAnswers + 1)});
    } else {
      await updateUser({'wrongAnswers': (_user!.wrongAnswers + 1)});
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

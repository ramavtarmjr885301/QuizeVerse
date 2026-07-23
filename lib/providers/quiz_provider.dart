// import 'package:flutter/material.dart';
// import '../models/question_model.dart';
// import '../services/firebase_service.dart';

// class QuizProvider extends ChangeNotifier {
//   List<QuestionModel> _questions = [];
//   List<QuestionModel> _currentQuestions = [];
//   int _currentIndex = 0;
//   int _score = 0;
//   int _coinsEarned = 0;
//   bool _isLoading = false;
//   bool _isDailyChallenge = false;
//   String? _selectedCategory;

//   List<QuestionModel> get questions => _questions;
//   List<QuestionModel> get currentQuestions => _currentQuestions;
//   int get currentIndex => _currentIndex;
//   int get score => _score;
//   int get coinsEarned => _coinsEarned;
//   bool get isLoading => _isLoading;
//   bool get isDailyChallenge => _isDailyChallenge;
//   String? get selectedCategory => _selectedCategory;

//   QuestionModel? get currentQuestion {
//     if (_currentQuestions.isEmpty ||
//         _currentIndex >= _currentQuestions.length) {
//       return null;
//     }
//     return _currentQuestions[_currentIndex];
//   }

//   int get totalQuestions => _currentQuestions.length;
//   bool get isLastQuestion => _currentIndex >= _currentQuestions.length - 1;
//   bool get isQuizComplete => _currentIndex >= _currentQuestions.length;

//   // Load questions from Firebase
//   Future<void> loadQuestions({String? category, bool daily = false}) async {
//     _isLoading = true;
//     _isDailyChallenge = daily;
//     _selectedCategory = category;
//     notifyListeners();

//     try {
//       List<QuestionModel> loadedQuestions;

//       if (daily) {
//         loadedQuestions = await FirebaseService.getDailyQuestions();
//       } else if (category != null && category.isNotEmpty) {
//         loadedQuestions = await FirebaseService.getQuestionsByCategory(
//           category,
//         );
//       } else {
//         loadedQuestions = await FirebaseService.getQuestions();
//       }

//       _questions = loadedQuestions;
//       _currentQuestions = List.from(loadedQuestions)..shuffle();
//       _currentQuestions = _currentQuestions
//           .take(10)
//           .toList(); // Max 10 questions per quiz
//       _currentIndex = 0;
//       _score = 0;
//       _coinsEarned = 0;
//     } catch (e) {
//       debugPrint('Load questions error: $e');
//       // Fallback to sample questions
//       _currentQuestions = QuestionModel.getSampleQuestions()..shuffle();
//       _currentQuestions = _currentQuestions.take(5).toList();
//       _currentIndex = 0;
//       _score = 0;
//       _coinsEarned = 0;
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   // Answer current question — computes correctness, does NOT advance index
//   bool answerQuestion(int selectedIndex) {
//     if (currentQuestion == null) return false;

//     final isCorrect = selectedIndex == currentQuestion!.correctAnswerIndex;

//     if (isCorrect) {
//       _score += 1;
//       _coinsEarned += currentQuestion!.coins;
//     }

//     notifyListeners();
//     return isCorrect;
//   }

//   // NEW: advances to next question — call this AFTER showing the result
//   void moveToNextQuestion() {
//     _currentIndex += 1;
//     notifyListeners();
//   }

//   // Skip question (no score)
//   void skipQuestion() {
//     if (_currentIndex < _currentQuestions.length) {
//       _currentIndex += 1;
//       notifyListeners();
//     }
//   }

//   // Reset quiz
//   void resetQuiz() {
//     _currentIndex = 0;
//     _score = 0;
//     _coinsEarned = 0;
//     _currentQuestions = List.from(_questions)..shuffle();
//     _currentQuestions = _currentQuestions.take(10).toList();
//     notifyListeners();
//   }

//   // Get category list (for home screen)
//   List<String> getCategories() {
//     final categories = _questions.map((q) => q.category).toSet().toList();
//     if (categories.isEmpty) {
//       return ['General', 'Science', 'History', 'Geography'];
//     }
//     return categories;
//   }
// }

import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/firebase_service.dart';

class QuizProvider extends ChangeNotifier {
  List<QuestionModel> _questions = [];
  List<QuestionModel> _currentQuestions = [];
  int _currentIndex = 0;
  int _score = 0;
  int _coinsEarned = 0;
  bool _isLoading = false;
  bool _isDailyChallenge = false;
  String? _selectedCategory;

  // NEW — hint state
  List<int> _hiddenOptionIndices = [];
  bool _hintUsedForCurrentQuestion = false;

  List<QuestionModel> get questions => _questions;
  List<QuestionModel> get currentQuestions => _currentQuestions;
  int get currentIndex => _currentIndex;
  int get score => _score;
  int get coinsEarned => _coinsEarned;
  bool get isLoading => _isLoading;
  bool get isDailyChallenge => _isDailyChallenge;
  String? get selectedCategory => _selectedCategory;

  // NEW — hint getters
  List<int> get hiddenOptionIndices => _hiddenOptionIndices;
  bool get hintUsedForCurrentQuestion => _hintUsedForCurrentQuestion;

  QuestionModel? get currentQuestion {
    if (_currentQuestions.isEmpty ||
        _currentIndex >= _currentQuestions.length) {
      return null;
    }
    return _currentQuestions[_currentIndex];
  }

  int get totalQuestions => _currentQuestions.length;
  bool get isLastQuestion => _currentIndex >= _currentQuestions.length - 1;
  bool get isQuizComplete => _currentIndex >= _currentQuestions.length;

  // NEW — apply 50-50 hint: hides 2 random WRONG options for current question
  void applyHint() {
    if (currentQuestion == null || _hintUsedForCurrentQuestion) return;

    final correctIndex = currentQuestion!.correctAnswerIndex;
    final wrongIndices = List.generate(
      currentQuestion!.options.length,
      (i) => i,
    ).where((i) => i != correctIndex).toList()..shuffle();

    // Hide up to 2 wrong options (handles edge case of <3 options safely)
    _hiddenOptionIndices = wrongIndices.take(2).toList();
    _hintUsedForCurrentQuestion = true;
    notifyListeners();
  }

  // NEW — reset hint state, call this whenever question changes
  void _resetHintState() {
    _hiddenOptionIndices = [];
    _hintUsedForCurrentQuestion = false;
  }

  Future<void> loadQuestions({String? category, bool daily = false}) async {
    _isLoading = true;
    _isDailyChallenge = daily;
    _selectedCategory = category;
    notifyListeners();

    try {
      List<QuestionModel> loadedQuestions;

      if (daily) {
        loadedQuestions = await FirebaseService.getDailyQuestions();
      } else if (category != null && category.isNotEmpty) {
        loadedQuestions = await FirebaseService.getQuestionsByCategory(
          category,
        );
      } else {
        loadedQuestions = await FirebaseService.getQuestions();
      }

      _questions = loadedQuestions;
      _currentQuestions = List.from(loadedQuestions)..shuffle();
      _currentQuestions = _currentQuestions.take(10).toList();
      _currentIndex = 0;
      _score = 0;
      _coinsEarned = 0;
      _resetHintState(); // NEW
    } catch (e) {
      debugPrint('Load questions error: $e');
      _currentQuestions = QuestionModel.getSampleQuestions()..shuffle();
      _currentQuestions = _currentQuestions.take(5).toList();
      _currentIndex = 0;
      _score = 0;
      _coinsEarned = 0;
      _resetHintState(); // NEW
    }

    _isLoading = false;
    notifyListeners();
  }

  bool answerQuestion(int selectedIndex) {
    if (currentQuestion == null) return false;

    final isCorrect = selectedIndex == currentQuestion!.correctAnswerIndex;

    if (isCorrect) {
      _score += 1;
      _coinsEarned += currentQuestion!.coins;
    }

    notifyListeners();
    return isCorrect;
  }

  void moveToNextQuestion() {
    _currentIndex += 1;
    _resetHintState(); // NEW
    notifyListeners();
  }

  void skipQuestion() {
    if (_currentIndex < _currentQuestions.length) {
      _currentIndex += 1;
      _resetHintState(); // NEW
      notifyListeners();
    }
  }

  void resetQuiz() {
    _currentIndex = 0;
    _score = 0;
    _coinsEarned = 0;
    _currentQuestions = List.from(_questions)..shuffle();
    _currentQuestions = _currentQuestions.take(10).toList();
    _resetHintState(); // NEW
    notifyListeners();
  }

  List<String> getCategories() {
    final categories = _questions.map((q) => q.category).toSet().toList();
    if (categories.isEmpty) {
      return ['General', 'Science', 'History', 'Geography'];
    }
    return categories;
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizverse/services/ad_service.dart';
import '../providers/quiz_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/question_card.dart';
import '../widgets/timer_widget.dart';
import '../widgets/ad_banner.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _isAnswered = false;
  int? _selectedOptionIndex;
  bool _isTimerFinished = false;
  bool _hasNavigatedToResult = false;
  int kHintCost = 8;

  Future<void> _handleHintTap(
    QuizProvider quizProvider,
    UserProvider userProvider,
  ) async {
    final currentCoins = userProvider.user?.coins ?? 0;

    if (currentCoins < kHintCost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough coins for a hint!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final success = await userProvider.spendCoins(kHintCost);

    if (success) {
      quizProvider.applyHint();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough coins for a hint!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    AdService.loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    if (quizProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Loading...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (quizProvider.isQuizComplete) {
      if (!_hasNavigatedToResult) {
        _hasNavigatedToResult = true;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;

          final shouldShowAd = await AdService.shouldShowInterstitial();

          if (!mounted) return;

          if (shouldShowAd) {
            AdService.showInterstitialAd(
              onAdClosed: () {
                if (mounted) {
                  Navigator.pushReplacementNamed(context, '/result');
                }
              },
            );
          } else {
            Navigator.pushReplacementNamed(context, '/result');
          }
        });
      }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = quizProvider.currentQuestion;
    if (question == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No questions available')),
      );
    }

    Future<void> handleTimeout(QuizProvider quizProvider) async {
      await Future.delayed(const Duration(milliseconds: 800));

      if (!mounted) return;

      quizProvider.skipQuestion();

      setState(() {
        _isAnswered = false;
        _selectedOptionIndex = null;
        _isTimerFinished = false;
      });
    }

    void showTopTimeUpBanner() {
      final overlay = Overlay.of(context);
      late OverlayEntry entry;

      entry = OverlayEntry(
        builder: (context) => Positioned(
          top: MediaQuery.of(context).padding.top + 10, // status bar ke neeche
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timer_off, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "⏰ Time's Up!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      overlay.insert(entry);

      Future.delayed(const Duration(milliseconds: 1000), () {
        entry.remove();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              '${quizProvider.currentIndex + 1}/${quizProvider.totalQuestions}',
            ),
            const Spacer(),
            if (quizProvider.isDailyChallenge) ...[
              const Icon(Icons.today, size: 16),
              const SizedBox(width: 4),
              const Text('Daily'),
            ],
            const Spacer(),
            Row(
              children: [
                const Icon(
                  Icons.monetization_on,
                  color: Colors.amber,
                  size: 18,
                ),
                Text('${quizProvider.coinsEarned}'),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withValues(alpha: 0.15),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Progress bar
                  LinearProgressIndicator(
                    value:
                        (quizProvider.currentIndex + 1) /
                        quizProvider.totalQuestions,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _isTimerFinished
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Timer — keyed by currentIndex so it resets fresh per question
                  TimerWidget(
                    key: ValueKey(quizProvider.currentIndex),
                    duration: 15,
                    onTimerFinished: () {
                      // FIX: guard against double-trigger race condition
                      // (e.g. user answers right as timer hits 0)
                      if (!mounted || _isAnswered || _isTimerFinished) return;
                      setState(() {
                        _isTimerFinished = true;
                      });
                      showTopTimeUpBanner();
                      handleTimeout(quizProvider);
                    },
                    onTick: (remaining) {
                      // Optional: Do something on each tick
                    },
                  ),
                  const SizedBox(height: 16),

                  // Category and difficulty
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).primaryColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          question.category,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '+${question.coins} coins',
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        question.difficulty == 1
                            ? 'Easy'
                            : question.difficulty == 2
                            ? 'Medium'
                            : 'Hard',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Question
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  // const SizedBox(height: 24),
                  const SizedBox(height: 12),

                  // NEW — Hint button (only if not answered, timer not finished, hint not used yet)
                  if (!_isAnswered &&
                      !_isTimerFinished &&
                      !quizProvider.hintUsedForCurrentQuestion)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _handleHintTap(quizProvider, userProvider),
                        icon: const Icon(
                          Icons.lightbulb_outline,
                          size: 16,
                          color: Colors.amber,
                        ),
                        label: Text(
                          '50-50 Hint ($kHintCost coins)',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.amber,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.amber, width: 1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          QuestionCard(
                            question: question,
                            onOptionSelected: (index) async {
                              if (_isAnswered || _isTimerFinished) return;

                              setState(() {
                                _isAnswered = true;
                                _selectedOptionIndex = index;
                              });

                              final isCorrect = quizProvider.answerQuestion(
                                index,
                              );
                              await userProvider.recordQuizResult(
                                isCorrect: isCorrect,
                                coinsEarned: isCorrect ? question.coins : 0,
                              );
                              await Future.delayed(
                                const Duration(milliseconds: 800),
                              );

                              if (mounted) {
                                quizProvider.moveToNextQuestion();
                                setState(() {
                                  _isAnswered = false;
                                  _selectedOptionIndex = null;
                                  _isTimerFinished = false;
                                });
                              }
                            },
                            selectedIndex: _selectedOptionIndex,
                            isAnswered: _isAnswered,
                            isTimerFinished: _isTimerFinished,
                            hiddenIndices: quizProvider.hiddenOptionIndices,
                          ),

                          // const SizedBox(height: 12),

                          // // Skip button (only if not answered)
                          // if (!_isAnswered && !_isTimerFinished)
                          //   Container(
                          //     width: double.infinity,
                          //     height: 60,
                          //     child: ElevatedButton.icon(
                          //       onPressed: () {
                          //         quizProvider.skipQuestion();
                          //         setState(() {
                          //           _isTimerFinished = false;
                          //         });
                          //       },
                          //       icon: const Icon(
                          //         Icons.skip_next_rounded,
                          //         size: 25,
                          //       ),
                          //       label: const Text('Skip Question'),
                          //       style: ElevatedButton.styleFrom(
                          //         foregroundColor: Colors.amber,
                          //         backgroundColor: Colors.transparent,
                          //         padding: const EdgeInsets.symmetric(
                          //           horizontal: 18,
                          //           vertical: 10,
                          //         ),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(20),
                          //           side: const BorderSide(color: Colors.amber),
                          //         ),
                          //         textStyle: const TextStyle(
                          //           fontSize: 13,
                          //           fontWeight: FontWeight.w600,
                          //         ),
                          //       ),
                          //     ),
                          // ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Ad banner at bottom — Expanded ke bahar, hamesha fixed
                  const AdBanner(
                    adUnitId:
                        'ca-app-pub-3940256099942544/6300978111', // Test ID
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

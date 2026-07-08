import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      // Navigate to result screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/result');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = quizProvider.currentQuestion;
    if (question == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No questions available')),
      );
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
                  Theme.of(context).primaryColor.withOpacity(0.15),
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
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _isTimerFinished
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Timer
                  TimerWidget(
                    duration: 15,
                    onTimerFinished: () {
                      setState(() {
                        _isTimerFinished = true;
                      });
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
                          ).primaryColor.withOpacity(0.2),
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
                          color: Colors.orange.withOpacity(0.2),
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
                        '${question.difficulty == 1
                            ? 'Easy'
                            : question.difficulty == 2
                            ? 'Medium'
                            : 'Hard'}',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
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

                  const SizedBox(height: 24),

                  // Options
                  Expanded(
                    child: QuestionCard(
                      question: question,
                      onOptionSelected: (index) {
                        if (_isAnswered || _isTimerFinished) return;

                        setState(() {
                          _isAnswered = true;
                          _selectedOptionIndex = index;
                        });

                        final isCorrect = quizProvider.answerQuestion(index);

                        // Update user stats
                        if (isCorrect) {
                          userProvider.addCoins(question.coins);
                          userProvider.updateAnswers(correct: true);
                        } else {
                          userProvider.updateAnswers(correct: false);
                        }

                        // Auto navigate to next question after delay
                        Future.delayed(const Duration(milliseconds: 800), () {
                          if (mounted) {
                            setState(() {
                              _isAnswered = false;
                              _selectedOptionIndex = null;
                              _isTimerFinished = false;
                            });
                            // Reset timer widget by rebuilding
                            // Will be handled by Provider rebuilding
                          }
                        });
                      },
                      selectedIndex: _selectedOptionIndex,
                      isAnswered: _isAnswered,
                      isTimerFinished: _isTimerFinished,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Skip button (only if not answered)
                  if (!_isAnswered && !_isTimerFinished)
                    TextButton(
                      onPressed: () {
                        quizProvider.skipQuestion();
                        setState(() {
                          _isTimerFinished = false;
                        });
                      },
                      child: const Text('Skip Question →'),
                    ),

                  // Ad banner at bottom
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

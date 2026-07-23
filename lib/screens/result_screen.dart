import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/ad_banner.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _hasFinishedQuiz = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFinishedQuiz) {
      _hasFinishedQuiz = true;
      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final score = quizProvider.score;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        userProvider.finishQuiz(score);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final totalQuestions = quizProvider.totalQuestions;
    final score = quizProvider.score;
    final coinsEarned = quizProvider.coinsEarned;

    final double percentage = totalQuestions > 0
        ? (score / totalQuestions * 100)
        : 0.0;

    String message;
    IconData icon;
    Color color;

    if (percentage >= 80) {
      message = '🌟 Outstanding! You\'re a Genius!';
      icon = Icons.emoji_events;
      color = Colors.amber;
    } else if (percentage >= 60) {
      message = '💪 Great Job! Keep it up!';
      icon = Icons.star;
      color = Colors.green;
    } else if (percentage >= 40) {
      message = '📚 Good Effort! Practice more!';
      icon = Icons.trending_up;
      color = Colors.orange;
    } else {
      message = '🤔 Don\'t give up! Try again!';
      icon = Icons.replay;
      color = Colors.red;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 60, color: color),
              ),

              const SizedBox(height: 24),

              Text(
                message,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              Row(
                children: [
                  _buildStatCard(
                    context,
                    label: 'Score',
                    value: '$score / $totalQuestions',
                    icon: Icons.quiz,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    context,
                    label: 'Accuracy',
                    value: '${percentage.toInt()}%',
                    icon: Icons.percent,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    context,
                    label: 'Coins Earned',
                    value: '+$coinsEarned',
                    icon: Icons.monetization_on,
                    color: Colors.amber,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              if (userProvider.user != null &&
                  score > (userProvider.user?.highScore ?? 0))
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.amber.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 8),
                      Text(
                        '🏆 New High Score!',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

              const Spacer(),

              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        quizProvider.resetQuiz();
                        Navigator.pushReplacementNamed(context, '/quiz');
                      },
                      icon: const Icon(Icons.replay),
                      label: const Text(
                        'Play Again',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      icon: const Icon(Icons.home),
                      label: const Text(
                        'Go Home',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const AdBanner(
                adUnitId: 'ca-app-pub-3940256099942544/6300978111',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white54, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

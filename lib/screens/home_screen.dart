import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/quiz_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final quizProvider = Provider.of<QuizProvider>(context);

    final categories = [
      'General',
      'Science',
      'History',
      'Geography',
      'Sports',
      'Entertainment',
    ];

    final user = userProvider.user;
    final hasName = user?.name != null && user!.name!.isNotEmpty;
    final avatarInitial = hasName
        ? user!.name!.substring(0, 1).toUpperCase()
        : 'G';
    final gamesPlayed = user?.gamesPlayed ?? 0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ========== HEADER ==========
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withValues(alpha: 0.6),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: Text(
                      avatarInitial,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // User info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasName ? user.name! : 'Guest',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Level ${user?.level ?? 1}: ${(user?.levelTitle ?? '').isNotEmpty ? user!.levelTitle : 'Beginner'}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Coins
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.amber.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${user?.coins ?? 0}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ========== STATS ROW ==========
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildStatCard(
                    context,
                    icon: Icons.star,
                    label: 'High Score',
                    value: '${user?.highScore ?? 0}',
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    context,
                    icon: Icons.check_circle,
                    label: 'Accuracy',
                    // FIX: avoid NaN.toInt() crash when gamesPlayed == 0
                    value: gamesPlayed > 0
                        ? '${((user?.accuracy ?? 0) * 100).toInt()}%'
                        : '—',
                    color: Colors.green,
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    context,
                    icon: Icons.local_fire_department,
                    label: 'Streak',
                    value: '${user?.streakDays ?? 0}🔥',
                    color: Colors.red,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ========== QUICK PLAY BUTTONS ==========
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Quick Play
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        quizProvider.loadQuestions();
                        Navigator.pushNamed(context, '/quiz');
                      },
                      icon: const Icon(Icons.play_arrow, size: 30),
                      label: const Text(
                        'Quick Play',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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

                  // Daily Challenge
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        quizProvider.loadQuestions(daily: true);
                        Navigator.pushNamed(context, '/quiz');
                      },
                      icon: const Icon(Icons.today, size: 30),
                      label: const Text(
                        'Daily Challenge',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Theme.of(context).primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ========== CATEGORIES ==========
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.1,
                            ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return _buildCategoryCard(
                            context,
                            categories[index],
                            index,
                            quizProvider,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ========== BOTTOM NAV ==========
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.home, color: Colors.white, size: 28),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/leaderboard');
                    },
                    icon: const Icon(
                      Icons.leaderboard,
                      color: Colors.white54,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white54,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white54, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String category,
    int index,
    QuizProvider quizProvider,
  ) {
    final colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.teal,
    ];
    final color = colors[index % colors.length];

    return GestureDetector(
      onTap: () {
        quizProvider.loadQuestions(category: category);
        Navigator.pushNamed(context, '/quiz');
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.8),
              color.withValues(alpha: 0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getCategoryIcon(category), color: Colors.white, size: 28),
            const SizedBox(height: 4),
            Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'General':
        return Icons.lightbulb;
      case 'Science':
        return Icons.science;
      case 'History':
        return Icons.history;
      case 'Geography':
        return Icons.public;
      case 'Sports':
        return Icons.sports_soccer;
      case 'Entertainment':
        return Icons.movie;
      default:
        return Icons.quiz;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Map<int, int> _levelXP = {
    1: 0,
    2: 100,
    3: 300,
    4: 600,
    5: 1000,
    6: 1500,
    7: 2100,
    8: 2800,
    9: 3600,
    10: 4500,
    11: 5500,
    12: 6600,
    13: 7800,
    14: 9100,
    15: 10500,
  };
  static const int _maxLevel = 15;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => userProvider.refreshUser(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    _buildAvatarCard(context, userProvider, user),
                    const SizedBox(height: 20),
                    _buildStatsGrid(context, user),
                    const SizedBox(height: 20),
                    _buildProgressCard(context, user),
                    const SizedBox(height: 20),
                    _buildLogoutButton(context, userProvider),
                    const SizedBox(height: 14),
                    TextButton(
                      onPressed: () =>
                          _showDeleteAccountDialog(context, userProvider),
                      child: Text(
                        'Delete Account',
                        style: TextStyle(
                          color: Colors.red.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildAvatarCard(
    BuildContext context,
    UserProvider userProvider,
    dynamic user,
  ) {
    final hasName = user.name != null && (user.name as String).isNotEmpty;
    final initial = hasName ? user.name.substring(0, 1).toUpperCase() : 'G';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.25),
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: 'profile_avatar',
                child: CircleAvatar(
                  radius: 52,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    initial,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 2.5,
                    ),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            hasName ? user.name : 'Guest',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Level ${user.level}: ${(user.levelTitle ?? '').isNotEmpty ? user.levelTitle : 'Rookie'}',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: userProvider.isGuest
                  ? Colors.orange.withOpacity(0.2)
                  : Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              userProvider.isGuest ? '👤 Guest Account' : '🔐 Registered',
              style: TextStyle(
                color: userProvider.isGuest ? Colors.orange : Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, dynamic user) {
    final stats = [
      (
        icon: Icons.monetization_on,
        label: 'Coins',
        value: '${user.coins}',
        color: Colors.amber,
      ),
      (
        icon: Icons.star,
        label: 'High Score',
        value: '${user.highScore}',
        color: Colors.blue,
      ),
      (
        icon: Icons.check_circle,
        label: 'Accuracy',
        value: user.gamesPlayed > 0 ? '${(user.accuracy * 100).toInt()}%' : '—',
        color: Colors.green,
      ),
      (
        icon: Icons.local_fire_department,
        label: 'Streak',
        value: '${user.streakDays}🔥',
        color: Colors.orange,
      ),
      (
        icon: Icons.quiz,
        label: 'Games Played',
        value: '${user.gamesPlayed}',
        color: Colors.purple,
      ),
      (
        icon: Icons.trending_up,
        label: 'Level',
        value: '${user.level}',
        color: Colors.teal,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📊 Statistics',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: stats
                .map(
                  (s) => _buildStatTile(
                    context,
                    icon: s.icon,
                    label: s.label,
                    value: s.value,
                    color: s.color,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context, dynamic user) {
    final isMaxLevel = user.level >= _maxLevel;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '🏆 XP Progress',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                isMaxLevel
                    ? 'Max Level'
                    : 'Level ${user.level} → ${user.level + 1}',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: _getProgressForLevel(user.level, user.coins),
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${user.coins} XP',
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
              Text(
                isMaxLevel
                    ? 'Max reached'
                    : 'Next: ${_getNextLevelXP(user.level)} XP',
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, UserProvider userProvider) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.withOpacity(0.2), Colors.red.withOpacity(0.05)],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.withOpacity(0.3)),
        ),
        child: TextButton.icon(
          onPressed: () => _showLogoutDialog(context, userProvider),
          icon: const Icon(Icons.logout, color: Colors.red, size: 24),
          label: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  double _getProgressForLevel(int level, int coins) {
    if (level >= _maxLevel) return 1.0;
    final currentLevelMin = _levelXP[level] ?? 0;
    final nextLevelMin = _levelXP[level + 1] ?? currentLevelMin;
    if (nextLevelMin == currentLevelMin) return 1.0;
    final progress =
        (coins - currentLevelMin) / (nextLevelMin - currentLevelMin);
    return progress.clamp(0.0, 1.0);
  }

  int _getNextLevelXP(int level) => _levelXP[level + 1] ?? _levelXP[_maxLevel]!;

  void _showLogoutDialog(BuildContext context, UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout?'),
        content: const Text('Are you sure you want to logout?'),
        backgroundColor: Theme.of(context).cardColor,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await userProvider.signOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(
    BuildContext context,
    UserProvider userProvider,
  ) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final isConfirmed = controller.text.trim() == 'DELETE';
          return AlertDialog(
            title: const Text('Delete Account?'),
            backgroundColor: Theme.of(context).cardColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This will permanently delete your account and all data. '
                  'This action cannot be undone!',
                ),
                const SizedBox(height: 16),
                Text(
                  'Type DELETE to confirm',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'DELETE',
                    isDense: true,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              TextButton(
                onPressed: isConfirmed
                    ? () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Account deletion coming soon!'),
                          ),
                        );
                      }
                    : null,
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: isConfirmed
                        ? Colors.red
                        : Colors.red.withOpacity(0.3),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

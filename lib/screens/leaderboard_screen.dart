import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/firebase_service.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    if (userProvider.user == null && !userProvider.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/login', (route) => false);
        }
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('🏆 Leaderboard'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseService.getLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading leaderboard',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No players yet. Be the first! 🎯'),
            );
          }

          final users = snapshot.data!.docs;

          // Find current user's rank
          String? currentUid = userProvider.user?.uid;
          int currentRank = -1;
          for (int i = 0; i < users.length; i++) {
            if (users[i].id == currentUid) {
              currentRank = i + 1;
              break;
            }
          }

          return Column(
            children: [
              // Top 3 Podium (Optional)
              if (users.length >= 3) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPodium(users[1], 2, '🥈', Colors.grey), // 2nd place
                      const SizedBox(width: 16),
                      _buildPodium(
                        users[0],
                        1,
                        '🥇',
                        Colors.amber,
                      ), // 1st place
                      const SizedBox(width: 16),
                      _buildPodium(
                        users[2],
                        3,
                        '🥉',
                        Colors.brown,
                      ), // 3rd place
                    ],
                  ),
                ),
                const Divider(),
              ],

              // Your Rank (if user is in top 100)
              if (currentRank != -1) ...[
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor.withValues(alpha: 0.3),
                        Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '#$currentRank',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          userProvider.user?.name ?? 'You',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        '${userProvider.user?.highScore ?? 0} pts',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],

              // Full Leaderboard
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final userData =
                        users[index].data() as Map<String, dynamic>;
                    final uid = users[index].id;
                    final isCurrentUser = uid == currentUid;

                    // FIX: safe name + initial extraction (no crash on empty string)
                    final rawName = userData['name'] as String?;
                    final displayName = (rawName != null && rawName.isNotEmpty)
                        ? rawName
                        : 'Player';
                    final avatarInitial = displayName
                        .substring(0, 1)
                        .toUpperCase();

                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isCurrentUser
                            ? Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 0.15)
                            : Colors.white.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: isCurrentUser
                            ? Border.all(color: Theme.of(context).primaryColor)
                            : null,
                      ),
                      child: Row(
                        children: [
                          // Rank
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _getRankColor(index + 1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: (index + 1) <= 3
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Avatar
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.1,
                            ),
                            child: Text(
                              avatarInitial,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Name
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayName,
                                  style: TextStyle(
                                    color: isCurrentUser
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    fontWeight: isCurrentUser
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                                if (isCurrentUser)
                                  Text(
                                    'You',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 10,
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          // Score
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${userData['highScore'] ?? 0}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPodium(
    QueryDocumentSnapshot user,
    int rank,
    String emoji,
    Color color,
  ) {
    final data = user.data() as Map<String, dynamic>;
    final rawName = data['name'] as String?;
    final name = (rawName != null && rawName.isNotEmpty) ? rawName : 'Player';
    final score = data['highScore'] ?? 0;

    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              rank == 1 ? '👑' : emoji,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name.length > 8 ? '${name.substring(0, 8)}...' : name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '$score pts',
          style: const TextStyle(color: Colors.white54, fontSize: 10),
        ),
      ],
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.brown;
      default:
        return Colors.white.withValues(alpha: 0.1);
    }
  }
}

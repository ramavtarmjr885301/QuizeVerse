import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/avatar_catalog.dart';
import '../providers/user_provider.dart';

class AvatarShopScreen extends StatelessWidget {
  const AvatarShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar Shop'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Row(
                children: [
                  const Icon(
                    Icons.monetization_on,
                    color: Colors.amber,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${user.coins}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: AvatarCatalog.all.length,
        itemBuilder: (context, index) {
          final avatar = AvatarCatalog.all[index];
          final isUnlocked =
              avatar.cost == 0 || user.unlockedAvatars.contains(avatar.id);
          final isSelected = user.selectedAvatar == avatar.id;

          return _AvatarTile(
            avatar: avatar,
            isUnlocked: isUnlocked,
            isSelected: isSelected,
            onTap: () => _handleTap(context, userProvider, avatar, isUnlocked),
          );
        },
      ),
    );
  }

  Future<void> _handleTap(
    BuildContext context,
    UserProvider userProvider,
    AvatarItem avatar,
    bool isUnlocked,
  ) async {
    if (isUnlocked) {
      await userProvider.selectAvatar(avatar.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${avatar.emoji} avatar selected!'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
      return;
    }

    final currentCoins = userProvider.user?.coins ?? 0;
    if (currentCoins < avatar.cost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough coins to unlock this avatar!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Unlock ${avatar.emoji}?',
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          'This will cost ${avatar.cost} coins.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Unlock',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final success = await userProvider.unlockAvatar(avatar.id, avatar.cost);

    if (!context.mounted) return;

    if (success) {
      await userProvider.selectAvatar(avatar.id); // auto-select after unlock
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${avatar.emoji} unlocked & selected!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unlock failed. Try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _AvatarTile extends StatelessWidget {
  final AvatarItem avatar;
  final bool isUnlocked;
  final bool isSelected;
  final VoidCallback onTap;

  const _AvatarTile({
    required this.avatar,
    required this.isUnlocked,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: 0.25)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: isUnlocked ? 1.0 : 0.3,
                  child: Text(
                    avatar.emoji,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
                const SizedBox(height: 4),
                if (!isUnlocked)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.amber,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${avatar.cost}',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            if (!isUnlocked)
              const Positioned(
                top: 4,
                right: 4,
                child: Icon(Icons.lock, color: Colors.white38, size: 14),
              ),
            if (isSelected)
              Positioned(
                top: 4,
                right: 4,
                child: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

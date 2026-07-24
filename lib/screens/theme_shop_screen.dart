import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/theme_catalog.dart';
import '../providers/user_provider.dart';

class ThemeShopScreen extends StatelessWidget {
  const ThemeShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Shop'),
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
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
        ),
        itemCount: ThemeCatalog.all.length,
        itemBuilder: (context, index) {
          final themeItem = ThemeCatalog.all[index];
          final isUnlocked =
              themeItem.cost == 0 || user.unlockedThemes.contains(themeItem.id);
          final isSelected =
              (user.selectedTheme ?? ThemeCatalog.defaultTheme.id) ==
              themeItem.id;

          return _ThemeTile(
            themeItem: themeItem,
            isUnlocked: isUnlocked,
            isSelected: isSelected,
            onTap: () =>
                _handleTap(context, userProvider, themeItem, isUnlocked),
          );
        },
      ),
    );
  }

  Future<void> _handleTap(
    BuildContext context,
    UserProvider userProvider,
    ThemeItem themeItem,
    bool isUnlocked,
  ) async {
    if (isUnlocked) {
      await userProvider.selectTheme(themeItem.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${themeItem.name} theme applied!'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
      return;
    }

    final currentCoins = userProvider.user?.coins ?? 0;
    if (currentCoins < themeItem.cost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough coins to unlock this theme!'),
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
          'Unlock ${themeItem.name}?',
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          'This will cost ${themeItem.cost} coins.',
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

    final success = await userProvider.unlockTheme(
      themeItem.id,
      themeItem.cost,
    );

    if (!context.mounted) return;

    if (success) {
      await userProvider.selectTheme(themeItem.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${themeItem.name} unlocked & applied!')),
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

class _ThemeTile extends StatelessWidget {
  final ThemeItem themeItem;
  final bool isUnlocked;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeTile({
    required this.themeItem,
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              themeItem.primaryColor.withValues(alpha: isUnlocked ? 0.8 : 0.25),
              themeItem.primaryColor.withValues(alpha: isUnlocked ? 0.3 : 0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? Colors.white
                : themeItem.primaryColor.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    themeItem.name,
                    style: TextStyle(
                      color: isUnlocked ? Colors.white : Colors.white38,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
                          '${themeItem.cost}',
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
            ),
            if (!isUnlocked)
              const Positioned(
                top: 6,
                right: 6,
                child: Icon(Icons.lock, color: Colors.white38, size: 14),
              ),
            if (isSelected)
              const Positioned(
                top: 6,
                right: 6,
                child: Icon(Icons.check_circle, color: Colors.white, size: 16),
              ),
          ],
        ),
      ),
    );
  }
}

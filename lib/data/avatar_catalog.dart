class AvatarItem {
  final String id;
  final String emoji;
  final int cost; // 0 = free, always unlocked
  final String tier;

  const AvatarItem({
    required this.id,
    required this.emoji,
    required this.cost,
    required this.tier,
  });
}

class AvatarCatalog {
  static const List<AvatarItem> all = [
    // ---- Starter (free) ----
    AvatarItem(id: 'a1', emoji: '😀', cost: 0, tier: 'Starter'),
    AvatarItem(id: 'a2', emoji: '🙂', cost: 0, tier: 'Starter'),
    AvatarItem(id: 'a3', emoji: '😎', cost: 0, tier: 'Starter'),
    AvatarItem(id: 'a4', emoji: '🤓', cost: 0, tier: 'Starter'),

    // ---- Bronze ----
    AvatarItem(id: 'b1', emoji: '🦊', cost: 49, tier: 'Bronze'),
    AvatarItem(id: 'b2', emoji: '🐱', cost: 49, tier: 'Bronze'),
    AvatarItem(id: 'b3', emoji: '🐶', cost: 49, tier: 'Bronze'),
    AvatarItem(id: 'b4', emoji: '🐼', cost: 49, tier: 'Bronze'),

    // ---- Silver ----
    AvatarItem(id: 's1', emoji: '🦁', cost: 99, tier: 'Silver'),
    AvatarItem(id: 's2', emoji: '🐯', cost: 99, tier: 'Silver'),
    AvatarItem(id: 's3', emoji: '🦅', cost: 99, tier: 'Silver'),
    AvatarItem(id: 's4', emoji: '🐺', cost: 99, tier: 'Silver'),

    // ---- Gold ----
    AvatarItem(id: 'g1', emoji: '👑', cost: 499, tier: 'Gold'),
    AvatarItem(id: 'g2', emoji: '🚀', cost: 499, tier: 'Gold'),
    AvatarItem(id: 'g3', emoji: '🔥', cost: 499, tier: 'Gold'),
    AvatarItem(id: 'g4', emoji: '⚡', cost: 499, tier: 'Gold'),

    // ---- Legendary ----
    AvatarItem(id: 'l1', emoji: '🧙', cost: 999, tier: 'Legendary'),
    AvatarItem(id: 'l2', emoji: '🐉', cost: 999, tier: 'Legendary'),
    AvatarItem(id: 'l3', emoji: '👽', cost: 999, tier: 'Legendary'),
    AvatarItem(id: 'l4', emoji: '🏆', cost: 999, tier: 'Legendary'),
  ];

  static AvatarItem? byId(String? id) {
    if (id == null) {
      return null; // guard clause — null aaya to seedha null return
    }
    try {
      return all.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  static AvatarItem? byEmoji(String emoji) {
    try {
      return all.firstWhere((a) => a.emoji == emoji);
    } catch (_) {
      return null;
    }
  }
}

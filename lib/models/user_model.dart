class UserModel {
  final String uid;
  final String? name;
  final String? email;
  final int coins;
  final int totalCoinsEarned;
  final int highScore;
  final int gamesPlayed;
  final int correctAnswers;
  final int wrongAnswers;
  final DateTime? lastPlayedDate;
  final int streakDays;
  final int streakFreezes;
  final DateTime? adsRemovedUntil;
  final List<String> categories;
  final String? lastDailyChallengeDate;
  final List<String> unlockedAvatars;
  final String? selectedAvatar;
  final List<String> unlockedThemes;
  final String? selectedTheme;

  UserModel({
    required this.uid,
    this.name,
    this.email,
    this.coins = 0,
    this.totalCoinsEarned = 0,
    this.highScore = 0,
    this.gamesPlayed = 0,
    this.correctAnswers = 0,
    this.wrongAnswers = 0,
    this.lastPlayedDate,
    this.streakDays = 0,
    this.streakFreezes = 0,
    this.adsRemovedUntil,
    this.categories = const [],
    this.lastDailyChallengeDate,
    this.unlockedAvatars = const [],
    this.selectedAvatar,
    this.unlockedThemes = const [],
    this.selectedTheme,
  });

  factory UserModel.empty() {
    return UserModel(uid: '');
  }

  factory UserModel.fromFirestore(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data['name'] ?? 'Player',
      email: data['email'] ?? '',
      coins: data['coins'] ?? 0,
      totalCoinsEarned: data['totalCoinsEarned'] ?? (data['coins'] ?? 0),
      highScore: data['highScore'] ?? 0,
      gamesPlayed: data['gamesPlayed'] ?? 0,
      correctAnswers: data['correctAnswers'] ?? 0,
      wrongAnswers: data['wrongAnswers'] ?? 0,
      lastPlayedDate: data['lastPlayedDate']?.toDate(),
      streakDays: data['streakDays'] ?? 0,
      streakFreezes: data['streakFreezes'] ?? 0,
      adsRemovedUntil: data['adsRemovedUntil']?.toDate(),
      categories: List<String>.from(data['categories'] ?? []),
      lastDailyChallengeDate: data['lastDailyChallengeDate'],
      unlockedAvatars: List<String>.from(data['unlockedAvatars'] ?? []),
      selectedAvatar: data['selectedAvatar'],
      unlockedThemes: List<String>.from(data['unlockedThemes'] ?? []),
      selectedTheme: data['selectedTheme'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name ?? 'Player',
      'email': email ?? '',
      'coins': coins,
      'totalCoinsEarned': totalCoinsEarned,
      'highScore': highScore,
      'gamesPlayed': gamesPlayed,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'lastPlayedDate': lastPlayedDate,
      'streakDays': streakDays,
      'streakFreezes': streakFreezes,
      'adsRemovedUntil': adsRemovedUntil,
      'categories': categories,
      'lastDailyChallengeDate': lastDailyChallengeDate,
      'unlockedAvatars': unlockedAvatars,
      'selectedAvatar': selectedAvatar,
      'unlockedThemes': unlockedThemes,
      'selectedTheme': selectedTheme,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    int? coins,
    int? totalCoinsEarned,
    int? highScore,
    int? gamesPlayed,
    int? correctAnswers,
    int? wrongAnswers,
    DateTime? lastPlayedDate,
    int? streakDays,
    int? streakFreezes,
    DateTime? adsRemovedUntil,
    List<String>? categories,
    String? lastDailyChallengeDate,
    List<String>? unlockedAvatars,
    String? selectedAvatar,
    List<String>? unlockedThemes,
    String? selectedTheme,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      coins: coins ?? this.coins,
      totalCoinsEarned: totalCoinsEarned ?? this.totalCoinsEarned,
      highScore: highScore ?? this.highScore,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
      streakDays: streakDays ?? this.streakDays,
      streakFreezes: streakFreezes ?? this.streakFreezes,
      adsRemovedUntil: adsRemovedUntil ?? this.adsRemovedUntil,
      categories: categories ?? this.categories,
      lastDailyChallengeDate:
          lastDailyChallengeDate ?? this.lastDailyChallengeDate,
      unlockedAvatars: unlockedAvatars ?? this.unlockedAvatars,
      selectedAvatar: selectedAvatar ?? this.selectedAvatar,
      unlockedThemes: unlockedThemes ?? this.unlockedThemes,
      selectedTheme: selectedTheme ?? this.selectedTheme,
    );
  }

  double get accuracy {
    final total = correctAnswers + wrongAnswers;
    if (total == 0) return 0.0;
    return correctAnswers / total;
  }

  int get level {
    if (totalCoinsEarned < 1000) return 1;
    if (totalCoinsEarned < 3000) return 2;
    if (totalCoinsEarned < 6000) return 3;
    if (totalCoinsEarned < 10000) return 4;
    if (totalCoinsEarned < 15000) return 5;
    return 6;
  }

  String get levelTitle {
    switch (level) {
      case 1:
        return '🌱 Beginner';
      case 2:
        return '📚 Learner';
      case 3:
        return '🧠 Scholar';
      case 4:
        return '⭐ Master';
      case 5:
        return '👑 Genius';
      case 6:
        return '🏆 Legend';
      default:
        return '🌱 Beginner';
    }
  }

  bool get hasCompletedDailyChallengeToday {
    if (lastDailyChallengeDate == null) return false;
    final now = DateTime.now();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final todayStr = '${now.year}-$month-$day';
    return lastDailyChallengeDate == todayStr;
  }

  bool get areAdsRemoved {
    if (adsRemovedUntil == null) return false;
    return DateTime.now().isBefore(adsRemovedUntil!);
  }
}

class UserModel {
  final String uid;
  final String? name;
  final String? email;
  final int coins;
  final int highScore;
  final int gamesPlayed;
  final int correctAnswers;
  final int wrongAnswers;
  final DateTime? lastPlayedDate;
  final int streakDays;
  final List<String> categories;
  final String? lastDailyChallengeDate;

  UserModel({
    required this.uid,
    this.name,
    this.email,
    this.coins = 0,
    this.highScore = 0,
    this.gamesPlayed = 0,
    this.correctAnswers = 0,
    this.wrongAnswers = 0,
    this.lastPlayedDate,
    this.streakDays = 0,
    this.categories = const [],
    this.lastDailyChallengeDate,
  });

  // Empty user (for initial state)
  factory UserModel.empty() {
    return UserModel(uid: '');
  }

  // From Firestore
  factory UserModel.fromFirestore(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data['name'] ?? 'Player',
      email: data['email'] ?? '',
      coins: data['coins'] ?? 0,
      highScore: data['highScore'] ?? 0,
      gamesPlayed: data['gamesPlayed'] ?? 0,
      correctAnswers: data['correctAnswers'] ?? 0,
      wrongAnswers: data['wrongAnswers'] ?? 0,
      lastPlayedDate: data['lastPlayedDate']?.toDate(),
      streakDays: data['streakDays'] ?? 0,
      categories: List<String>.from(data['categories'] ?? []),
      lastDailyChallengeDate: data['lastDailyChallengeDate'],
    );
  }

  // To Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name ?? 'Player',
      'email': email ?? '',
      'coins': coins,
      'highScore': highScore,
      'gamesPlayed': gamesPlayed,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'lastPlayedDate': lastPlayedDate,
      'streakDays': streakDays,
      'categories': categories,
      'lastDailyChallengeDate': lastDailyChallengeDate,
    };
  }

  // Copy with updates
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    int? coins,
    int? highScore,
    int? gamesPlayed,
    int? correctAnswers,
    int? wrongAnswers,
    DateTime? lastPlayedDate,
    int? streakDays,
    List<String>? categories,
    String? lastDailyChallengeDate,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      coins: coins ?? this.coins,
      highScore: highScore ?? this.highScore,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
      streakDays: streakDays ?? this.streakDays,
      categories: categories ?? this.categories,
      lastDailyChallengeDate:
          lastDailyChallengeDate ?? this.lastDailyChallengeDate,
    );
  }

  // Calculate accuracy
  double get accuracy {
    final total = correctAnswers + wrongAnswers;
    if (total == 0) return 0.0;
    return correctAnswers / total;
  }

  // Level based on coins
  int get level {
    if (coins < 100) return 1;
    if (coins < 300) return 2;
    if (coins < 600) return 3;
    if (coins < 1000) return 4;
    if (coins < 1500) return 5;
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
}

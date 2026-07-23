class QuestionModel {
  final String id;
  final String category;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final int difficulty;
  final int coins;

  QuestionModel({
    required this.id,
    required this.category,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.difficulty = 1,
    this.coins = 10,
  });

  factory QuestionModel.fromFirestore(Map<String, dynamic> data, String id) {
    return QuestionModel(
      id: id,
      category: data['category'] ?? 'General',
      question: data['question'] ?? 'No question',
      options: List<String>.from(data['options'] ?? ['A', 'B', 'C', 'D']),
      correctAnswerIndex: data['correctAnswerIndex'] ?? 0,
      difficulty: data['difficulty'] ?? 1,
      coins: data['coins'] ?? 10,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'category': category,
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'difficulty': difficulty,
      'coins': coins,
    };
  }

  static List<QuestionModel> getSampleQuestions() {
    return [
      QuestionModel(
        id: '1',
        category: 'General',
        question: 'What is the capital of India?',
        options: ['Mumbai', 'New Delhi', 'Kolkata', 'Chennai'],
        correctAnswerIndex: 1,
        difficulty: 1,
        coins: 10,
      ),
      QuestionModel(
        id: '2',
        category: 'Science',
        question: 'What is the chemical symbol for water?',
        options: ['H2O', 'CO2', 'NaCl', 'HCl'],
        correctAnswerIndex: 0,
        difficulty: 1,
        coins: 10,
      ),
      QuestionModel(
        id: '3',
        category: 'General',
        question: 'Which planet is known as the Red Planet?',
        options: ['Venus', 'Jupiter', 'Mars', 'Saturn'],
        correctAnswerIndex: 2,
        difficulty: 1,
        coins: 15,
      ),
      QuestionModel(
        id: '4',
        category: 'Science',
        question: 'What is the largest organ in the human body?',
        options: ['Liver', 'Brain', 'Skin', 'Heart'],
        correctAnswerIndex: 2,
        difficulty: 2,
        coins: 15,
      ),
      QuestionModel(
        id: '5',
        category: 'History',
        question: 'Who wrote the Indian national anthem "Jana Gana Mana"?',
        options: [
          'Mahatma Gandhi',
          'Rabindranath Tagore',
          'Subhash Chandra Bose',
          'Bankim Chandra Chatterjee',
        ],
        correctAnswerIndex: 1,
        difficulty: 2,
        coins: 20,
      ),
    ];
  }
}

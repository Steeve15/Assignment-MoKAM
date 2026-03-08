class MoodEntry {
  final String day;
  final String emoji;
  final int score;
  final DateTime date;

  MoodEntry({
    required this.day,
    required this.emoji,
    required this.score,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'emoji': emoji,
      'score': score,
      'date': date.toIso8601String(),
    };
  }

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      day: map['day'] ?? '',
      emoji: map['emoji'] ?? '',
      score: map['score'] ?? 3,
      date: DateTime.parse(map['date']),
    );
  }
}

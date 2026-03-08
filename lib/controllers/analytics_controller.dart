import '../models/analytics_model.dart';

class AnalyticsController {
  final List<MoodEntry> moodEntries = [
    MoodEntry(
      day: 'Sat',
      emoji: '😖',
      score: 1,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    MoodEntry(
      day: 'Sun',
      emoji: '🙁',
      score: 2,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    MoodEntry(
      day: 'Mon',
      emoji: '😐',
      score: 3,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    MoodEntry(
      day: 'Tues',
      emoji: '🙁',
      score: 2,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    MoodEntry(
      day: 'Weds',
      emoji: '🙁',
      score: 2,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    MoodEntry(
      day: 'Thurs',
      emoji: '🙁',
      score: 2,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    MoodEntry(day: 'Today', emoji: '😐', score: 3, date: DateTime.now()),
  ];

  List<MoodEntry> getWeeklyMoods() {
    return moodEntries;
  }

  MoodEntry getTodayMood() {
    return moodEntries.firstWhere(
      (entry) => entry.day == 'Today',
      orElse: () =>
          MoodEntry(day: 'Today', emoji: '😐', score: 3, date: DateTime.now()),
    );
  }

  double getAverageMood() {
    if (moodEntries.isEmpty) return 3.0;
    final total = moodEntries.fold(0, (sum, item) => sum + item.score);
    return total / moodEntries.length;
  }

  void updateTodayMood(String emoji, int score) {
    final index = moodEntries.indexWhere((entry) => entry.day == 'Today');

    if (index != -1) {
      moodEntries[index] = MoodEntry(
        day: 'Today',
        emoji: emoji,
        score: score,
        date: DateTime.now(),
      );
    } else {
      moodEntries.add(
        MoodEntry(
          day: 'Today',
          emoji: emoji,
          score: score,
          date: DateTime.now(),
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import '../controllers/analytics_controller.dart';
import '../models/analytics_model.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AnalyticsController controller = AnalyticsController();

  final List<Map<String, dynamic>> emojiOptions = [
    {'emoji': '😖', 'score': 1},
    {'emoji': '🙁', 'score': 2},
    {'emoji': '😐', 'score': 3},
    {'emoji': '🙂', 'score': 4},
    {'emoji': '😄', 'score': 5},
  ];

  String selectedEmoji = '😐';
  int selectedScore = 3;

  @override
  void initState() {
    super.initState();
    selectedEmoji = controller.getTodayMood().emoji;
    selectedScore = controller.getTodayMood().score;
  }

  Color getMoodColor(int score) {
    switch (score) {
      case 5:
        return const Color(0xFF47C96D);
      case 4:
        return const Color(0xFFA9BE74);
      case 3:
        return const Color(0xFFC9B2A1);
      case 2:
        return const Color(0xFFF39A27);
      case 1:
      default:
        return const Color(0xFFA990FF);
    }
  }

  void selectMood(String emoji, int score) {
    setState(() {
      selectedEmoji = emoji;
      selectedScore = score;
      controller.updateTodayMood(emoji, score);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<MoodEntry> moods = controller.getWeeklyMoods();
    final double averageMood = controller.getAverageMood();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 26),

              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF47C96D),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "(",
                        style: TextStyle(
                          color: Color(0xFF47C96D),
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Analytics",
                    style: TextStyle(
                      color: Color(0xFF47C96D),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9E7A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Low",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 38),

              const Center(
                child: Text(
                  "Checkout your recent\nperformance 🤩",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF47C96D),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                "Weekly Report",
                style: TextStyle(
                  color: Color(0xFF4A2E22),
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: moods.map((mood) {
                    return MoodDayWidget(
                      emoji: mood.emoji,
                      day: mood.day,
                      bgColor: getMoodColor(mood.score),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                "How are you feeling today?",
                style: TextStyle(
                  color: Color(0xFF4A2E22),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.78),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: emojiOptions.map((item) {
                    final bool isSelected = selectedEmoji == item['emoji'];

                    return GestureDetector(
                      onTap: () => selectMood(
                        item['emoji'] as String,
                        item['score'] as int,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: getMoodColor(item['score'] as int),
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: const Color(0xFF4A2E22),
                                  width: 3,
                                )
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            item['emoji'] as String,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                "Monthly Report",
                style: TextStyle(
                  color: Color(0xFF4A2E22),
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 16),

              MonthlyGraphCard(averageMood: averageMood),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodDayWidget extends StatelessWidget {
  final String emoji;
  final String day;
  final Color bgColor;

  const MoodDayWidget({
    super.key,
    required this.emoji,
    required this.day,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 18)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: const TextStyle(
            color: Color(0xFF4A2E22),
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class MonthlyGraphCard extends StatelessWidget {
  final double averageMood;

  const MonthlyGraphCard({super.key, required this.averageMood});

  String getMoodLabel(double value) {
    if (value >= 4) return "Happy";
    if (value >= 3) return "Neutral";
    if (value >= 2) return "Low";
    return "Depressed";
  }

  Color getMoodColor(double value) {
    if (value >= 4) return const Color(0xFFA9BE74);
    if (value >= 3) return const Color(0xFFA47A5A);
    if (value >= 2) return const Color(0xFFFF9E7A);
    return const Color(0xFFF09A35);
  }

  @override
  Widget build(BuildContext context) {
    final moodLabel = getMoodLabel(averageMood);
    final moodColor = getMoodColor(averageMood);

    return Container(
      width: double.infinity,
      height: 210,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EFEB),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE4DBD4)),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFFE7DED7),
              ),
            ),
          ),
          Positioned.fill(child: CustomPaint(painter: MoodGraphPainter())),
          const Positioned(
            left: 24,
            top: 10,
            child: _GraphTag(text: "Happy", color: Color(0xFFA9BE74)),
          ),
          const Positioned(left: 52, top: 50, child: _GraphPoint()),
          Positioned(
            right: 45,
            top: 52,
            child: _GraphTag(text: moodLabel, color: moodColor),
          ),
          const Positioned(right: 82, top: 84, child: _GraphPoint()),
          const Positioned(
            left: 110,
            bottom: 14,
            child: _GraphTag(text: "Depressed", color: Color(0xFFF09A35)),
          ),
        ],
      ),
    );
  }
}

class _GraphTag extends StatelessWidget {
  final String text;
  final Color color;

  const _GraphTag({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _GraphPoint extends StatelessWidget {
  const _GraphPoint();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFA08977), width: 3),
      ),
    );
  }
}

class MoodGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF5A4134)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    path.moveTo(0, size.height * 0.62);
    path.cubicTo(
      size.width * 0.07,
      size.height * 0.62,
      size.width * 0.10,
      size.height * 0.46,
      size.width * 0.18,
      size.height * 0.46,
    );
    path.cubicTo(
      size.width * 0.25,
      size.height * 0.46,
      size.width * 0.22,
      size.height * 0.18,
      size.width * 0.29,
      size.height * 0.18,
    );
    path.cubicTo(
      size.width * 0.37,
      size.height * 0.18,
      size.width * 0.29,
      size.height * 0.58,
      size.width * 0.43,
      size.height * 0.58,
    );
    path.cubicTo(
      size.width * 0.52,
      size.height * 0.58,
      size.width * 0.45,
      size.height * 0.92,
      size.width * 0.52,
      size.height * 0.92,
    );
    path.cubicTo(
      size.width * 0.60,
      size.height * 0.92,
      size.width * 0.60,
      size.height * 0.50,
      size.width * 0.74,
      size.height * 0.50,
    );
    path.cubicTo(
      size.width * 0.84,
      size.height * 0.50,
      size.width * 0.72,
      size.height * 0.10,
      size.width * 0.83,
      size.height * 0.10,
    );
    path.cubicTo(
      size.width * 0.92,
      size.height * 0.10,
      size.width * 0.88,
      size.height * 0.62,
      size.width,
      size.height * 0.62,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

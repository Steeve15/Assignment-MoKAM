import 'package:flutter/material.dart';
import 'sign_in_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> pages = [
    {
      "title": "Personalize Your Mental\nHealth With Us",
      "bg": const Color(0xFFEAF5E6),
      "icon": Icons.psychology_alt_outlined,
      "label": "Step One",
    },
    {
      "title": "Intelligent Mood Tracking\n& AI Insights",
      "bg": const Color(0xFFFBE7D6),
      "icon": Icons.mood_outlined,
      "label": "Step Two",
    },
    {
      "title": "Mindful Resources That\nMakes You Happy",
      "bg": const Color(0xFFF9E8BF),
      "icon": Icons.favorite_border,
      "label": "Step Three",
    },
  ];

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignInScreen()),
      );
    }
  }

  Widget buildDot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: active ? 28 : 12,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF43C266) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: pages.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final page = pages[index];

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.04),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF43C266)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        page["label"],
                        style: const TextStyle(
                          color: Color(0xFF43C266),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: page["bg"],
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Center(
                        child: Icon(
                          page["icon"],
                          size: size.width * 0.30,
                          color: const Color(0xFF7A8D53),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),

                  Text(
                    page["title"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF97A85D),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (dotIndex) => buildDot(dotIndex == currentIndex),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  SizedBox(
                    width: 62,
                    height: 62,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF43C266),
                        shape: const CircleBorder(),
                        elevation: 0,
                      ),
                      onPressed: nextPage,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
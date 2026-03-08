import 'package:flutter/material.dart';
import 'widgets/bottom_navbar.dart';
import 'setting_page.dart'; // ADD THIS IMPORT

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onSettingsPressed;

  const HomePage({
    super.key,
    required this.isDarkMode,
    required this.onSettingsPressed,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color primaryGreen = const Color(0xFF4CAF50);
  final Color lightBackground = const Color(0xFFF6F3EF);
  int _selectedIndex = 0;

  final List<Map<String, String>> schedules = [
    {"date": "19 Jan", "title": "Completed Mobile Assignment"},
    {"date": "14 Apr", "title": "Completed Final Year Project"},
    {"date": "16 Apr", "title": "Working on Exams Preparation"},
    {"date": "20 Apr", "title": "Prepare Dissertation"},
    {"date": "25 Apr", "title": "Submit Internship Report"},
  
  ];

  int visibleItems = 3;
  bool isExpanded = false;

  void toggleView() {
    setState(() {
      if (isExpanded) {
        visibleItems = 3;
      } else {
        visibleItems = schedules.length;
      }
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? null : lightBackground,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/avatar.png"),
            ),
            const SizedBox(width: 10),
            const Text(
              "Welcome, Admin",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Golden",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "MoKam Therapist is here\nwith you",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "What makes your week?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: toggleView,
                    child: Text(
                      isExpanded ? "View Less." : "View More.",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: List.generate(
                  visibleItems,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildItem(
                      schedules[index]["date"]!,
                      schedules[index]["title"]!,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Schedule for the week ...",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _scheduleCard("Today, 4:30 pm", "Meetings with Dr. Chan"),
                    _scheduleCard("Today, 6:00 pm", "Meditation Session"),
                    _scheduleCard("Tomorrow, 2:00 pm", "Therapy Consultation"),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          
          // UPDATED: Direct navigation to settings page when flag icon (index 4) is tapped
          if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingPage(
                  isDarkMode: widget.isDarkMode,
                  onThemeChanged: (bool value) {
                    // This will be handled by the parent widget
                    widget.onSettingsPressed();
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildItem(String date, String text) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            date,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _scheduleCard(String time, String title) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFFBFAF9E),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 8),
                const Text(
                  "UoM Counselling Center",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.psychology,
            size: 40,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
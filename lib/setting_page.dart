import 'package:flutter/material.dart';
import 'widgets/bottom_navbar.dart'; // ADD THIS IMPORT

class SettingPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double soundVolume = 0.6;
  bool isHighResOn = true;
  String selectedLanguage = "Eng";
  int selectedFontSize = 1; // 0 = small, 1 = medium, 2 = large
  final Color primaryGreen = const Color(0xFF4CAF50);
  int _selectedIndex = 0; // ADD THIS for bottom nav

  @override
  Widget build(BuildContext context) {
    bool isLightMode = !widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: primaryGreen,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Settings", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color Theme
            const Text("Color Theme", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            _segmentedControl(
              leftText: "Light Mode",
              rightText: "Dark Mode",
              isLeftSelected: isLightMode,
              onLeftTap: () => widget.onThemeChanged(false),
              onRightTap: () => widget.onThemeChanged(true),
            ),
            const SizedBox(height: 30),
            const Divider(),
            
            // Language
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Language",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    _languageButton("Eng"),
                    const SizedBox(width: 10),
                    const Text("/"),
                    const SizedBox(width: 10),
                    _languageButton("fr"),
                  ],
                )
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),

            // Font Size
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Font Size",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    _fontSizeButton("Aa", 0, 14),
                    const SizedBox(width: 10),
                    const Text("/"),
                    const SizedBox(width: 10),
                    _fontSizeButton("Aa", 1, 18),
                    const SizedBox(width: 10),
                    const Text("/"),
                    const SizedBox(width: 10),
                    _fontSizeButton("Aa", 2, 22),
                  ],
                )
              ],
            ),

            const SizedBox(height: 30),
            const Divider(),

            // AI Sound Volume
            const SizedBox(height: 20),
            const Text("AI Sound Volume",
                style: TextStyle(fontSize: 14, color: Colors.grey)),

            Slider(
              value: soundVolume,
              activeColor: primaryGreen,
              inactiveColor: Colors.grey.shade300,
              onChanged: (value) {
                setState(() {
                  soundVolume = value;
                });
              },
            ),

            const SizedBox(height: 30),
            const Divider(),

            // High Resolution
            const SizedBox(height: 20),
            const Text("High Resolution AI",
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 5),
            const Text(
              "# This may increase your battery consumption",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 15),

            _segmentedControl(
              leftText: "On",
              rightText: "Off",
              isLeftSelected: isHighResOn,
              onLeftTap: () => setState(() => isHighResOn = true),
              onRightTap: () => setState(() => isHighResOn = false),
            ),
            const SizedBox(height: 20), // ADD SOME SPACE AT THE BOTTOM
          ],
        ),
      ),
      
      // ADD THIS BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          
          // Handle navigation based on index
          if (index == 0) {
            // Navigate to Home or whatever
            Navigator.pop(context); // Example: go back
          } else if (index == 4) {
            // Already on settings page, maybe do nothing or refresh
            print("Already on settings page");
          }
          // Add more navigation logic as needed
        },
      ),
    );
  }

  Widget _segmentedControl({
    required String leftText,
    required String rightText,
    required bool isLeftSelected,
    required VoidCallback onLeftTap,
    required VoidCallback onRightTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          _segmentButton(leftText, isLeftSelected, onLeftTap),
          _segmentButton(rightText, !isLeftSelected, onRightTap),
        ],
      ),
    );
  }

  Widget _segmentButton(String text, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? primaryGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(color: selected ? Colors.white : Colors.black54)),
        ),
      ),
    );
  }

  Widget _languageButton(String lang) {
    bool selected = selectedLanguage == lang;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = lang;
        });
      },
      child: Text(
        lang,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? primaryGreen : Colors.grey,
        ),
      ),
    );
  }

  Widget _fontSizeButton(String text, int index, double size) {
    bool selected = selectedFontSize == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFontSize = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? primaryGreen : Colors.grey,
        ),
      ),
    );
  }
}
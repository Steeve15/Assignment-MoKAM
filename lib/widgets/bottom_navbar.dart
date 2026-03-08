import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {

  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(vertical: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),

        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
          )
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [

          _navItem(Icons.sentiment_satisfied_alt, 0),
          _navItem(Icons.favorite, 1),
          _navItem(Icons.face, 2),
          _navItem(Icons.local_cafe, 3),
          _navItem(Icons.flag, 4),

        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {

    final bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),

      child: Container(
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4CAF50) : Colors.transparent,
          shape: BoxShape.circle,
        ),

        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.brown,
        ),
      ),
    );
  }
}

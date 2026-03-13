import 'package:flutter/material.dart';
import 'onboarding_screen.dart';
import 'sign_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.06),

              Icon(
                Icons.self_improvement,
                size: size.width * 0.22,
                color: const Color(0xFF43C266),
              ),

              SizedBox(height: size.height * 0.03),

              Text(
                "Welcome to the MoKam\nAI Therapist",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.075,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF43C266),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              Text(
                "Your mindful mental health AI companion\nfor everyone, anywhere.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.037,
                  color: Colors.black54,
                ),
              ),

              const Spacer(),

              Container(
                height: size.height * 0.30,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF5E6),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Center(
                  child: Icon(
                    Icons.spa_outlined,
                    size: 120,
                    color: Color(0xFF7A8D53),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.05),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF43C266),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OnboardingScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignInScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color(0xFF43C266),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
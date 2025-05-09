import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Ảnh nền
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_onboarding.jpg', // Thay bằng đường dẫn ảnh của bạn
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Center(
                child: Text(
                  "data",
                  style: TextStyle(
                    color: Colors.white, // Đổi màu chữ để nổi bật trên nền
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // Nội dung chính

        ],
      ),
    );
  }

}
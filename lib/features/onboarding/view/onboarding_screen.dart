import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/design_systems/theme/app_colors.dart';
import '../../components/input.dart';

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
              'assets/images/background_onboarding.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Nội dung cuối màn hình
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo + text
                  Image.asset(
                    'assets/images/logo_text_white.png',
                    width: 150,
                    height: 150,
                  ),
                  const Text(
                    'Nghe hàng ngàn cuốn sách \nnói, thiền định, truyện ngủ\nvà các nội dung khác.',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Nút bắt đầu
                  CustomInput(
                    content: 'Bắt đầu',
                    backgroundColor: AppColors.peachCoral,
                    navigateText: '/onboarding_step_one',
                  ),
                  const SizedBox(height: 10),
                  // Nút đăng nhập
                  CustomInput(
                    content: 'Đăng nhập',
                    backgroundColor: Colors.white,
                    navigateText: '/sign_in',
                    textColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
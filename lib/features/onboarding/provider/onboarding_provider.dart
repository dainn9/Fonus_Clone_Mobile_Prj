import 'package:flutter/material.dart';

class OnboardingProvider with ChangeNotifier {
  // Dữ liệu slide (có thể lấy từ API trong tương lai)
  final List<Map<String, String>> _slides = [
    {
      'title': 'Khám phá sách nói',
      'body': 'Nghe sách nói mọi lúc, mọi nơi với hàng nghìn tựa sách bản quyền.',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': 'Podcast đa dạng',
      'body': 'Thưởng thức các kênh podcast từ Vietcetera, Spiderum và hơn thế nữa.',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'Thư giãn với thiền',
      'body': 'Hơn 300 nội dung thiền miễn phí giúp bạn thư giãn và tập trung.',
      'image': 'assets/images/onboarding3.png',
    },
  ];

  List<Map<String, String>> get slides => _slides;

  // Quản lý trang hiện tại
  int _currentPage = 0;
  int get currentPage => _currentPage;

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  // Hàm này có thể được dùng để tải dữ liệu từ API trong tương lai
  Future<void> fetchSlides() async {
    // Giả lập API call
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }
}
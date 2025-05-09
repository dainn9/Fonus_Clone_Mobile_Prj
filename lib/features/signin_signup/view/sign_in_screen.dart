import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isTermsAccepted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C3E50),
              Color(0xFF1E3A5F),
              Color(0xFF172B4D),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Nút đóng (X) ở góc trên bên phải
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: ()
                    {
                      Navigator.pushNamed(context, '/onboarding');

                    },
                  ),
                ),
              ),

              // Nội dung chính
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 100),

                    // Tiêu đề và mô tả
                    const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Nghe không giới hạn chương đầu của tất cả sách nói, và nhiều nội dung khác.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Nút đăng nhập với Facebook
                    _buildSocialButton(
                      icon: 'assets/icons/facebook.png',
                      text: 'Tiếp tục với Facebook',
                      color: Colors.white,
                      onPressed: () {
                        // Xử lý đăng nhập với Facebook
                      },
                    ),
                    const SizedBox(height: 16),

                    // Nút đăng nhập với Google
                    _buildSocialButton(
                      icon: 'assets/icons/google.png',
                      text: 'Tiếp tục với Google',
                      color: Colors.white,
                      onPressed: () {
                        // Xử lý đăng nhập với Google
                      },
                    ),

                    // Phần chia cách "HOẶC"
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Divider(color: Colors.white30, thickness: 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'HOẶC',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(color: Colors.white30, thickness: 1),
                          ),
                        ],
                      ),
                    ),

                    // Các nút đăng nhập khác (Email và Điện thoại)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCircleButton(
                          icon: Icons.email_outlined,
                          color: Colors.orange,
                          onPressed: () {
                            // Xử lý đăng nhập với Email
                          },
                        ),
                        const SizedBox(width: 24),
                        _buildCircleButton(
                          icon: Icons.phone,
                          color: Colors.red,
                          onPressed: () {
                            // Xử lý đăng nhập với Điện thoại
                          },
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Phần đăng ký và điều khoản
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Chưa có tài khoản? ',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Chuyển đến trang đăng ký
                            },
                            child: const Text(
                              'Đăng ký',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Checkbox điều khoản sử dụng
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            value: _isTermsAccepted,
                            onChanged: (value) {
                              setState(() {
                                _isTermsAccepted = value ?? false;
                              });
                            },
                            activeColor: Colors.orange,
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                                children: const [
                                  TextSpan(text: 'Tôi đã đọc và đồng ý với '),
                                  TextSpan(
                                    text: 'Điều khoản sử dụng',
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: ' và '),
                                  TextSpan(
                                    text: 'Chính sách bảo mật',
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: ' của Fonos.'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget nút đăng nhập mạng xã hội
  Widget _buildSocialButton({
    required String icon,
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          // Thay thế bằng Image.asset khi có file icon
          icon == 'assets/icons/facebook.png'
              ? Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFF3b5998),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'f',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
              : Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'G',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget nút tròn (Email và Điện thoại)
  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: color,
            size: 30,
          ),
        ),
      ),
    );
  }
}

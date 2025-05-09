import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData? icon;
  final String content;
  final Color? backgroundColor;
  final String navigateText; // Tên route để điều hướng (bắt buộc)

  const CustomInput({
    Key? key,
    this.icon,
    required this.content,
    this.backgroundColor,
    required this.navigateText, // Tên route để điều hướng
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color effectiveBackgroundColor = backgroundColor ?? Colors.white;
    final Color textColor = icon != null ? Colors.black : Colors.white;

    return GestureDetector(
      onTap: () {
        // Điều hướng đến route được truyền trong navigateText
        Navigator.pushNamed(context, navigateText);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: icon != null ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              content,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SectionHeaderWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onSeeAll;

  const SectionHeaderWithIcon({
    Key? key,
    required this.title,
    required this.icon,
    this.onSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
        if (onSeeAll != null)
          IconButton(
            icon: const Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
            onPressed: onSeeAll,
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iungo_application/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTheme.h4.copyWith(
            fontSize: 16,
            color: const Color(0xFF333333),
            fontWeight: FontWeight.w400,
            height: 19 / 16,
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
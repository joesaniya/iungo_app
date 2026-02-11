import 'package:flutter/material.dart';
import 'package:iungo_application/theme/app_theme.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;
  final bool isFullWidth;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.valueColor,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppTheme.elevation9,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTheme.h2.copyWith(
              fontSize: 34,
              color: valueColor,
              fontWeight: FontWeight.w500,
              height: 40 / 34,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.pLight.copyWith(
              fontSize: 12,
              color: const Color(0xFF666666),
              fontWeight: FontWeight.w400,
              height: 17 / 12,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String? subtitle;
  final Color backgroundColor;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    this.subtitle,
    this.backgroundColor = const Color(0xFFFFF5F5),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.h5Strong.copyWith(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTheme.h1.copyWith(
              fontSize: 32,
              color: AppColors.primaryRed,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          Text(
            unit,
            style: AppTheme.pLight.copyWith(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: AppTheme.pLight.copyWith(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

class BarChartData {
  final String label;
  final double value;
  final Color color;

  BarChartData({
    required this.label,
    required this.value,
    required this.color,
  });
}

class HorizontalBarChart extends StatelessWidget {
  final List<BarChartData> data;
  final String xAxisLabel;

  const HorizontalBarChart({
    super.key,
    required this.data,
    this.xAxisLabel = 'Value',
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = data.isEmpty
        ? 0.0
        : data.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        ...data.map((item) {
          final percentage = maxValue > 0 ? item.value / maxValue : 0.0;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    item.label,
                    style: AppTheme.pStrong.copyWith(
                      fontSize: 11,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColors.lightNeutral200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: percentage,
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: item.color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 16),
        // X-axis labels
        Padding(
          padding: const EdgeInsets.only(left: 78),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0',
                style: AppTheme.minimal.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '50,000',
                style: AppTheme.minimal.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '100,000',
                style: AppTheme.minimal.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 78),
          child: Text(
            xAxisLabel,
            style: AppTheme.pLight.copyWith(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
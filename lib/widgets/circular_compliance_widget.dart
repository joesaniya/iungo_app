import 'package:flutter/material.dart';
import 'package:iungo_application/theme/app_theme.dart';

class CircularComplianceWidget extends StatelessWidget {
  final int completed;
  final int total;
  final Color progressColor;

  const CircularComplianceWidget({
    super.key,
    required this.completed,
    required this.total,
    this.progressColor = const Color(0xFF4CAF50), // Green 500
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (completed / total * 100).round();
    final progress = completed / total;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppTheme.elevation9,
      ),
      child: Center(
        child: SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              SizedBox(
                width: 160,
                height: 160,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 16,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    const Color(0xFFE0E0E0), // Light Neutral 200
                  ),
                ),
              ),
              // Progress circle
              SizedBox(
                width: 160,
                height: 160,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 16,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ),
              // Center text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$completed/$total',
                    style: AppTheme.pLight.copyWith(
                      fontSize: 14,
                      color: const Color(0xFF666666),
                      fontWeight: FontWeight.w400,
                      height: 20 / 14,
                    ),
                  ),
                  Text(
                    '$percentage%',
                    style: AppTheme.h2.copyWith(
                      fontSize: 32,
                      color: progressColor,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
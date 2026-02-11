import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

class DonutChartData {
  final String label;
  final double value;
  final Color color;

  DonutChartData({
    required this.label,
    required this.value,
    required this.color,
  });
}

class DonutChart extends StatelessWidget {
  final List<DonutChartData> data;
  final double size;
  final double strokeWidth;

  const DonutChart({
    super.key,
    required this.data,
    this.size = 160,
    this.strokeWidth = 30,
  });

  @override
  Widget build(BuildContext context) {
    final total = data.fold(0.0, (sum, item) => sum + item.value);

    return Row(
      children: [
        // Donut Chart
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: DonutChartPainter(
              data: data,
              total: total,
              strokeWidth: strokeWidth,
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Legend
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: item.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.label,
                        style: AppTheme.pStrong.copyWith(
                          fontSize: 12,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<DonutChartData> data;
  final double total;
  final double strokeWidth;

  DonutChartPainter({
    required this.data,
    required this.total,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    double startAngle = -math.pi / 2;

    for (var item in data) {
      final sweepAngle = (item.value / total) * 2 * math.pi;
      final paint = Paint()
        ..color = item.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
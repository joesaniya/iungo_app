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

class DonutChart extends StatefulWidget {
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
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  int? _hoveredIndex;
  Offset? _tooltipPosition;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const SizedBox(
        height: 160,
        child: Center(child: Text('No data available')),
      );
    }

    final total = widget.data.fold(0.0, (sum, item) => sum + item.value);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          children: [
            // Donut Chart
            SizedBox(
              width: widget.size,
              height: widget.size,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomPaint(
                    size: Size(widget.size, widget.size),
                    painter: DonutChartPainter(
                      data: widget.data,
                      total: total,
                      strokeWidth: widget.strokeWidth,
                      hoveredIndex: _hoveredIndex,
                    ),
                  ),
                  // Interactive overlay
                  Positioned.fill(
                    child: GestureDetector(
                      onTapUp: (details) {
                        _handleTap(details.localPosition, total);
                      },
                      child: MouseRegion(
                        onHover: (event) {
                          _handleHover(event.localPosition, total);
                        },
                        onExit: (_) {
                          setState(() {
                            _hoveredIndex = null;
                            _tooltipPosition = null;
                          });
                        },
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // Legend
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.data.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        _hoveredIndex = index;
                        // Set tooltip position for legend hover
                        _tooltipPosition = Offset(
                          widget.size / 2,
                          widget.size / 2,
                        );
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        _hoveredIndex = null;
                        _tooltipPosition = null;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _hoveredIndex == index
                              ? item.color.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
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
                                  fontWeight: _hoveredIndex == index
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        // Tooltip overlay - positioned at top level to avoid clipping
        if (_hoveredIndex != null && _tooltipPosition != null)
          Positioned(
            left: _tooltipPosition!.dx - 60,
            top: _tooltipPosition!.dy - 50,
            child: IgnorePointer(
              child: _buildTooltip(widget.data[_hoveredIndex!]),
            ),
          ),
      ],
    );
  }

  void _handleTap(Offset position, double total) {
    final index = _getSegmentIndex(position, total);
    if (index != null) {
      setState(() {
        _hoveredIndex = index;
        _tooltipPosition = position;
      });
    }
  }

  void _handleHover(Offset position, double total) {
    final index = _getSegmentIndex(position, total);
    setState(() {
      _hoveredIndex = index;
      if (index != null) {
        _tooltipPosition = position;
      } else {
        _tooltipPosition = null;
      }
    });
  }

  int? _getSegmentIndex(Offset position, double total) {
    final center = Offset(widget.size / 2, widget.size / 2);
    final dx = position.dx - center.dx;
    final dy = position.dy - center.dy;

    // Calculate distance from center
    final distance = math.sqrt(dx * dx + dy * dy);
    final innerRadius = (widget.size / 2) - widget.strokeWidth;
    final outerRadius = widget.size / 2;

    // Check if position is within the donut ring
    if (distance < innerRadius || distance > outerRadius) {
      return null;
    }

    // Calculate angle
    var angle = math.atan2(dy, dx);
    angle = (angle + math.pi / 2) % (2 * math.pi);
    if (angle < 0) angle += 2 * math.pi;

    // Find which segment
    double currentAngle = 0;
    for (int i = 0; i < widget.data.length; i++) {
      final sweepAngle = (widget.data[i].value / total) * 2 * math.pi;
      if (angle >= currentAngle && angle < currentAngle + sweepAngle) {
        return i;
      }
      currentAngle += sweepAngle;
    }

    return null;
  }

  Widget _buildTooltip(DonutChartData data) {
    // Format the value with commas
    final formattedValue = data.value
        .toStringAsFixed(2)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: data.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                formattedValue,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<DonutChartData> data;
  final double total;
  final double strokeWidth;
  final int? hoveredIndex;

  DonutChartPainter({
    required this.data,
    required this.total,
    required this.strokeWidth,
    this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    double startAngle = -math.pi / 2;

    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      final sweepAngle = (item.value / total) * 2 * math.pi;

      final paint = Paint()
        ..color = hoveredIndex == i ? item.color.withOpacity(0.8) : item.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = hoveredIndex == i ? strokeWidth + 4 : strokeWidth
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
  bool shouldRepaint(DonutChartPainter oldDelegate) {
    return oldDelegate.hoveredIndex != hoveredIndex || oldDelegate.data != data;
  }
}

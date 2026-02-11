import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

class BarChartData {
  final String label;
  final double value;
  final Color color;

  BarChartData({required this.label, required this.value, required this.color});
}

class HorizontalBarChart extends StatefulWidget {
  final List<BarChartData> data;
  final String xAxisLabel;

  const HorizontalBarChart({
    super.key,
    required this.data,
    this.xAxisLabel = 'Value',
  });

  @override
  State<HorizontalBarChart> createState() => _HorizontalBarChartState();
}

class _HorizontalBarChartState extends State<HorizontalBarChart> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No data available')),
      );
    }

    final maxValue = widget.data
        .map((e) => e.value)
        .reduce((a, b) => a > b ? a : b);
    final barHeight = 36.0; // Height for each bar item (24 + 12 padding)
    final maxHeight = 400.0; // Maximum height before scrolling
    final contentHeight =
        widget.data.length * barHeight + 60; // +60 for axis labels
    final needsScroll = contentHeight > maxHeight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Bars section - scrollable if needed
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: needsScroll ? maxHeight - 60 : contentHeight - 60,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: widget.data.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final percentage = maxValue > 0 ? item.value / maxValue : 0.0;

                return MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _hoveredIndex = index;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _hoveredIndex = null;
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _hoveredIndex = _hoveredIndex == index ? null : index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(
                              item.label,
                              style: AppTheme.pStrong.copyWith(
                                fontSize: 11,
                                color: _hoveredIndex == index
                                    ? item.color
                                    : AppColors.textPrimary,
                                fontWeight: _hoveredIndex == index
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightNeutral200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width:
                                      MediaQuery.of(context).size.width *
                                      percentage *
                                      0.55,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: _hoveredIndex == index
                                        ? item.color.withOpacity(0.9)
                                        : item.color,
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: _hoveredIndex == index
                                        ? [
                                            BoxShadow(
                                              color: item.color.withOpacity(
                                                0.4,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                                // Tooltip - positioned outside the bar
                                if (_hoveredIndex == index)
                                  Positioned(
                                    left:
                                        (MediaQuery.of(context).size.width *
                                            percentage *
                                            0.55) +
                                        8,
                                    top: -6,
                                    child: _buildTooltip(item),
                                  ),
                              ],
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
        ),
        const SizedBox(height: 16),
        // X-axis labels - always visible at bottom
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
                _formatAxisValue(maxValue / 2),
                style: AppTheme.minimal.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                _formatAxisValue(maxValue),
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
            widget.xAxisLabel,
            style: AppTheme.pLight.copyWith(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTooltip(BarChartData data) {
    final formattedValue = _formatValue(data.value);

    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 150),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                '$formattedValue kg Co₂',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatValue(double value) {
    // Format with commas for thousands
    return value
        .toStringAsFixed(3)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  String _formatAxisValue(double value) {
    // Format axis labels
    if (value >= 1000) {
      return value
          .toStringAsFixed(0)
          .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          );
    }
    return value.toStringAsFixed(0);
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iungo_application/theme/app_theme.dart';

class MultiLineChartWidget extends StatelessWidget {
  final String title;
  final List<ChartLine> lines;
  final List<String> xLabels;
  final double minY;
  final double maxY;
  final Widget? infoIcon;

  const MultiLineChartWidget({
    super.key,
    required this.title,
    required this.lines,
    required this.xLabels,
    this.minY = 0,
    this.maxY = 125,
    this.infoIcon,
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
          // Title and legend
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.h4.copyWith(
                    fontSize: 16,
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.w400,
                    height: 19 / 16,
                  ),
                ),
              ),
              if (infoIcon != null) infoIcon!,
            ],
          ),
          const SizedBox(height: 8),
          // Legend
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: lines.map((line) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 2,
                    color: line.color,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    line.label,
                    style: AppTheme.pLight.copyWith(
                      fontSize: 10,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // Chart
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minY: minY,
                maxY: maxY,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFFE0E0E0),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 25,
                      reservedSize: 35,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: AppTheme.pLight.copyWith(
                            fontSize: 10,
                            color: const Color(0xFF666666),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < xLabels.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              xLabels[value.toInt()],
                              style: AppTheme.pLight.copyWith(
                                fontSize: 10,
                                color: const Color(0xFF666666),
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: lines.map((line) {
                  return LineChartBarData(
                    spots: line.data
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value))
                        .toList(),
                    isCurved: true,
                    color: line.color,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartLine {
  final String label;
  final List<double> data;
  final Color color;

  ChartLine({
    required this.label,
    required this.data,
    required this.color,
  });
}
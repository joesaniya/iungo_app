import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iungo_application/theme/app_theme.dart';

class LineChartWidget extends StatelessWidget {
  final String title;
  final List<ChartDataPoint> data;
  final Color lineColor;
  final Color? fillColor;
  final double minY;
  final double maxY;
  final bool showFill;

  const LineChartWidget({
    super.key,
    required this.title,
    required this.data,
    required this.lineColor,
    this.fillColor,
    this.minY = 0,
    this.maxY = 125,
    this.showFill = true,
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
            title,
            style: AppTheme.h4.copyWith(
              fontSize: 16,
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w400,
              height: 19 / 16,
            ),
          ),
          const SizedBox(height: 16),
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
                        if (value.toInt() >= 0 && value.toInt() < data.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              data[value.toInt()].label,
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
                lineBarsData: [
                  LineChartBarData(
                    spots: data
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value.value))
                        .toList(),
                    isCurved: true,
                    color: lineColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: showFill,
                      color: (fillColor ?? lineColor).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartDataPoint {
  final String label;
  final double value;

  ChartDataPoint({
    required this.label,
    required this.value,
  });
}
import 'package:flutter/material.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:iungo_application/theme/app_colors.dart';
import 'package:iungo_application/Business-Logic/waste_management_provider.dart';
import 'package:iungo_application/widgets/section_header_widget.dart';
import 'package:iungo_application/widgets/star_card_widget.dart';
import 'package:iungo_application/widgets/circular_compliance_widget.dart';
import 'package:iungo_application/widgets/line_chart_widget.dart';
import 'package:iungo_application/widgets/multi_line_chart_cwidget.dart';
import 'package:provider/provider.dart';

class BinCollectionDataTab extends StatelessWidget {
  const BinCollectionDataTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WasteManagementProvider>(
      builder: (context, provider, _) {
        final data = provider.getBinCollectionData();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bins information
              const SectionHeader(title: 'Bins information'),
              const SizedBox(height: 16),
              _buildBinsInformation(data),
              const SizedBox(height: 24),

              // Compliance
              const SectionHeader(title: 'Compliance'),
              const SizedBox(height: 16),
              _buildCompliance(data),
              const SizedBox(height: 24),

              // Bins collection data
              const SectionHeader(title: 'Bins collection data'),
              const SizedBox(height: 16),
              _buildBinsCollectionData(data),
              const SizedBox(height: 24),

              // Bins washing data
              const SectionHeader(title: 'Bins washing data'),
              const SizedBox(height: 16),
              _buildBinsWashingData(data),
              const SizedBox(height: 24),

              // Charts
              _buildCharts(provider),
              const SizedBox(height: 24),

              // Work orders chart
              _buildWorkOrdersChart(provider),
              const SizedBox(height: 24),

              // Map placeholder
              _buildMapPlaceholder(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBinsInformation(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                value: data['binsDeployed'],
                label: 'Bins deployed',
                valueColor: AppColors.teal,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StatCard(
                value: data['binsInStock'],
                label: 'Bins in stock',
                valueColor: AppColors.teal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatCard(
                value: data['binsStolenVandalised'],
                label: 'Bins stolen / vandalised',
                valueColor: AppColors.teal,
                isFullWidth: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  Widget _buildCompliance(Map<String, dynamic> data) {
    return CircularComplianceWidget(
      completed: data['complianceCompleted'],
      total: data['complianceTotal'],
      progressColor: AppColors.teal,
    );
  }

  Widget _buildBinsCollectionData(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                value: data['binsCollectedToday'],
                label: 'Bins collected today',
                valueColor: AppColors.chartBlue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StatCard(
                value: data['binsCollectedPerTruck'],
                label: 'Bins collected per truck',
                valueColor: AppColors.chartBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatCard(
                value: data['avgCollectedPerDay'],
                label: 'Avg. collected per day',
                valueColor: AppColors.chartBlue,
                isFullWidth: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  Widget _buildBinsWashingData(Map<String, dynamic> data) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            value: data['binsWashed'],
            label: 'Bins washed',
            valueColor: AppColors.chartBlue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatCard(
            value: data['avgBinsWashedPerTruck'],
            label: 'Avg. bins washed per truck',
            valueColor: AppColors.chartBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildCharts(WasteManagementProvider provider) {
    return Column(
      children: [
        // Bins collected per day chart
        LineChartWidget(
          title: 'Bins collected per day',
          lineColor: AppColors.chartPurple,
          fillColor: AppColors.chartPurpleLight,
          data: provider.getBinsCollectedPerDayData(),
        ),
        const SizedBox(height: 24),

        // Refuse collection truck efficiency chart
        LineChartWidget(
          title: 'Refuse collection truck efficiency',
          lineColor: AppColors.chartRed,
          fillColor: AppColors.chartRedLight,
          data: provider.getTruckEfficiencyData(),
        ),
        const SizedBox(height: 24),

        // Bins washed per day chart
        LineChartWidget(
          title: 'Bins washed per day',
          lineColor: AppColors.chartGreen,
          fillColor: AppColors.chartGreenLight,
          data: provider.getBinsWashedPerDayData(),
        ),
      ],
    );
  }

  Widget _buildWorkOrdersChart(WasteManagementProvider provider) {
    final workOrdersData = provider.getWorkOrdersData();
    final lines = <ChartLine>[];

    for (var lineData in workOrdersData['lines']) {
      Color color;
      switch (lineData['color']) {
        case 'gray':
          color = AppColors.chartGray;
          break;
        case 'green':
          color = AppColors.chartGreen;
          break;
        case 'red':
          color = AppColors.chartRed;
          break;
        case 'blue':
          color = AppColors.blue500;
          break;
        default:
          color = AppColors.chartGray;
      }

      lines.add(
        ChartLine(
          label: lineData['label'],
          data: (lineData['data'] as List)
              .map((e) => e is int ? e.toDouble() : e as double)
              .toList(),
          color: color,
        ),
      );
    }

    return MultiLineChartWidget(
      title: 'Work orders issued',
      xLabels: List<String>.from(workOrdersData['xLabels']),
      infoIcon: const Icon(
        Icons.info_outline,
        size: 16,
        color: AppColors.textSecondary,
      ),
      lines: lines,
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppTheme.elevation9,
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.map_outlined,
                  size: 64,
                  color: AppColors.textDisabled,
                ),
                const SizedBox(height: 16),
                Text(
                  'Work orders issued',
                  style: AppTheme.h4.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Map integration coming soon',
                  style: AppTheme.pLight.copyWith(
                    color: AppColors.textDisabled,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Column(
              children: [
                _buildMapButton(Icons.add),
                const SizedBox(height: 8),
                _buildMapButton(Icons.remove),
                const SizedBox(height: 8),
                _buildMapButton(Icons.filter_alt_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.mapButtonBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, color: AppColors.white, size: 20),
    );
  }
}

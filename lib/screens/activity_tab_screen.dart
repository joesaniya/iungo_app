import 'package:flutter/material.dart';
import 'package:iungo_application/Business-Logic/activity_tab_provider.dart';
import 'package:iungo_application/widgets/custom_dropdown_widget.dart';
import 'package:iungo_application/widgets/donut_chart_widget.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({super.key});

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActivityTabProvider>().initializeFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityTabProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && !provider.filtersLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Filters Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: AppTheme.elevation9,
                ),
                child: Column(
                  children: [
                    // Vehicle Filter
                    CustomDropdown(
                      label: 'Vehicle',
                      value: provider.selectedVehicle,
                      items: ['All', ...provider.vehicles.map((e) => e.name)],
                      onChanged: (value) {
                        provider.setVehicle(value == 'All' ? null : value);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Disposal Area Filter
                    CustomDropdown(
                      label: 'Disposal Area',
                      value: provider.selectedDisposalArea,
                      items: [
                        'All',
                        ...provider.disposalAreas.map((e) => e.name),
                      ],
                      onChanged: (value) {
                        provider.setDisposalArea(value == 'All' ? null : value);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Waste Type Filter
                    CustomDropdown(
                      label: 'Waste Type',
                      value: provider.selectedWasteType,
                      items: ['All', ...provider.wasteTypes.map((e) => e.name)],
                      onChanged: (value) {
                        provider.setWasteType(value == 'All' ? null : value);
                      },
                    ),
                    const SizedBox(height: 20),

                    // Apply Filter Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: provider.isLoading
                            ? null
                            : () => provider.applyFilters(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryPurple,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: provider.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white,
                                  ),
                                ),
                              )
                            : Text('Apply Filter', style: AppTheme.buttonText),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Recycling & Diversion Rate
              if (provider.diversionRate != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recycling & Diversion Rate',
                        style: AppTheme.h5Strong.copyWith(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '% diverted from landfill',
                        style: AppTheme.pLight.copyWith(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${provider.diversionRate!.displayWeight}%',
                        style: AppTheme.h1.copyWith(
                          fontSize: 40,
                          color: AppColors.primaryRed,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      if (provider.diversionRate!.chartData != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Recycled: ${provider.diversionRate!.chartData!['recycled'] ?? '0'} Kg  |  Total Waste: ${provider.diversionRate!.chartData!['total'] ?? '0'} Kg',
                          style: AppTheme.pLight.copyWith(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              const SizedBox(height: 16),

              // CIT Waste Composition - Only show if data is not empty
              if (provider.citWasteComposition?.chartData != null &&
                  _hasChartData(provider.citWasteComposition!.chartData!))
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: AppTheme.elevation9,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Waste Composition (CIT Vehicles)',
                        style: AppTheme.h5Strong.copyWith(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      DonutChart(
                        data: _getWasteCompositionData(
                          provider.citWasteComposition!.chartData!,
                        ),
                      ),
                    ],
                  ),
                ),
              if (provider.citWasteComposition?.chartData != null &&
                  _hasChartData(provider.citWasteComposition!.chartData!))
                const SizedBox(height: 16),

              // Non-CIT Waste Composition - Only show if data is not empty
              if (provider.nonCitWasteComposition?.chartData != null &&
                  _hasChartData(provider.nonCitWasteComposition!.chartData!))
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: AppTheme.elevation9,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Waste Composition (Non CIT Vehicles)',
                        style: AppTheme.h5Strong.copyWith(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      DonutChart(
                        data: _getWasteCompositionData(
                          provider.nonCitWasteComposition!.chartData!,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Helper method to check if chart data is not empty
  bool _hasChartData(Map<String, dynamic> chartData) {
    final labels = chartData['labels'] as List?;
    final values = chartData['values'] as List?;

    // Check if labels and values exist and are not empty
    if (labels != null && values != null) {
      return labels.isNotEmpty && values.isNotEmpty;
    }

    // Fallback: check if there are any keys besides metadata keys
    final dataKeys = chartData.keys.where(
      (key) =>
          key != 'labels' &&
          key != 'values' &&
          key != 'total_weight' &&
          key != 'recycled' &&
          key != 'total',
    );

    return dataKeys.isNotEmpty;
  }

  List<DonutChartData> _getWasteCompositionData(
    Map<String, dynamic> chartData,
  ) {
    final List<Color> colors = [
      AppColors.yellow600,
      AppColors.green500,
      AppColors.green700,
      AppColors.purple700,
      AppColors.purple900,
      const Color(0xFFFFB6B6),
      AppColors.red700,
    ];

    List<DonutChartData> data = [];
    int index = 0;

    // Handle labels and values arrays
    final labels = chartData['labels'] as List?;
    final values = chartData['values'] as List?;

    if (labels != null && values != null) {
      for (int i = 0; i < labels.length && i < values.length; i++) {
        data.add(
          DonutChartData(
            label: labels[i].toString(),
            value: double.tryParse(values[i].toString()) ?? 0,
            color: colors[index % colors.length],
          ),
        );
        index++;
      }
    } else {
      // Fallback: try to parse as key-value pairs
      chartData.forEach((key, value) {
        if (key != 'labels' &&
            key != 'values' &&
            key != 'total_weight' &&
            key != 'recycled' &&
            key != 'total') {
          data.add(
            DonutChartData(
              label: key,
              value: double.tryParse(value.toString()) ?? 0,
              color: colors[index % colors.length],
            ),
          );
          index++;
        }
      });
    }

    return data;
  }
}

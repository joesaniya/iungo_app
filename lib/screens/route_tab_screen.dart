import 'package:flutter/material.dart';
import 'package:iungo_application/Business-Logic/route_tab_provider.dart';
import 'package:iungo_application/widgets/bar_chart_data_widget.dart';
import 'package:iungo_application/widgets/custom_date_picker.dart';
import 'package:iungo_application/widgets/custom_dropdown_widget.dart';
import 'package:iungo_application/widgets/donut_chart_widget.dart';
import 'package:iungo_application/widgets/metric_card_widget.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

class RouteTab extends StatefulWidget {
  const RouteTab({super.key});

  @override
  State<RouteTab> createState() => _RouteTabState();
}

class _RouteTabState extends State<RouteTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RouteTabProvider>().initializeFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteTabProvider>(
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
                    // Zone Filter
                    CustomDropdown(
                      label: 'Zone',
                      value: provider.selectedZone,
                      items: ['All', ...provider.zones.map((e) => e.name)],
                      onChanged: (value) {
                        provider.setZone(value == 'All' ? null : value);
                      },
                    ),
                    const SizedBox(height: 16),

                    // From Date
                    CustomDateInput(
                      label: 'From Date',
                      selectedDate: provider.fromDate,
                      onDateSelected: (date) {
                        provider.setDateRange(date, provider.toDate);
                      },
                      isFromDate: true,
                    ),
                    const SizedBox(height: 16),

                    // To Date
                    CustomDateInput(
                      label: 'To Date',
                      selectedDate: provider.toDate,
                      onDateSelected: (date) {
                        provider.setDateRange(provider.fromDate, date);
                      },
                      isFromDate: false,
                    ),
                    const SizedBox(height: 16),

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

                    // Route Filter
                    CustomDropdown(
                      label: 'Route',
                      value: provider.selectedRoute,
                      items: ['All', ...provider.routes.map((e) => e.name)],
                      onChanged: (value) {
                        provider.setRoute(value == 'All' ? null : value);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Region Filter
                    CustomDropdown(
                      label: 'Region',
                      value: provider.selectedRegion,
                      items: ['All', ...provider.regions.map((e) => e.name)],
                      onChanged: (value) {
                        provider.setRegion(value == 'All' ? null : value);
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

              // Total Waste Collected
              if (provider.totalWasteCollected != null)
                MetricCard(
                  title: 'Total Waste Collected',
                  value: provider.totalWasteCollected!.value,
                  unit: provider.totalWasteCollected!.unit,
                ),
              const SizedBox(height: 16),

              // Zone Distribution Chart
              if (provider.totalWasteCollected?.chartData != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: AppTheme.elevation9,
                  ),
                  child: DonutChart(
                    data: _getZoneChartData(
                      provider.totalWasteCollected!.chartData!,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Collection Completion
              if (provider.collectionCompletion != null)
                MetricCard(
                  title: 'Collection Completion',
                  value: provider.collectionCompletion!.value,
                  unit: provider.collectionCompletion!.unit,
                ),
              const SizedBox(height: 16),

              // CO2 Emission & Route Efficiency Row
              Row(
                children: [
                  if (provider.co2Emission != null)
                    Expanded(
                      child: MetricCard(
                        title: 'CO₂ Emission',
                        value: provider.co2Emission!.value,
                        unit: provider.co2Emission!.unit,
                      ),
                    ),
                  const SizedBox(width: 12),
                  if (provider.routeEfficiency != null)
                    Expanded(
                      child: MetricCard(
                        title: 'Route Efficiency',
                        value: provider.routeEfficiency!.value,
                        unit: provider.routeEfficiency!.unit,
                        backgroundColor: const Color(0xFFFFF9F0),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // Vehicle Emissions Chart
              if (provider.co2Emission?.chartData != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: AppTheme.elevation9,
                  ),
                  child: HorizontalBarChart(
                    data: _getVehicleEmissionsData(
                      provider.co2Emission!.chartData!,
                    ),
                    xAxisLabel: 'Co. Emission (kg)',
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<DonutChartData> _getZoneChartData(Map<String, dynamic> chartData) {
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

    chartData.forEach((key, value) {
      data.add(
        DonutChartData(
          label: key,
          value: double.tryParse(value.toString()) ?? 0,
          color: colors[index % colors.length],
        ),
      );
      index++;
    });

    return data;
  }

  List<BarChartData> _getVehicleEmissionsData(Map<String, dynamic> chartData) {
    final List<Color> colors = [
      AppColors.yellow600,
      AppColors.green500,
      AppColors.green700,
      AppColors.purple700,
      AppColors.purple900,
      AppColors.red700,
      AppColors.blue700,
      AppColors.blue500,
      AppColors.blue900,
      AppColors.red900,
      AppColors.black,
    ];

    List<BarChartData> data = [];
    int index = 0;

    chartData.forEach((key, value) {
      data.add(
        BarChartData(
          label: key,
          value: double.tryParse(value.toString()) ?? 0,
          color: colors[index % colors.length],
        ),
      );
      index++;
    });

    return data;
  }
}

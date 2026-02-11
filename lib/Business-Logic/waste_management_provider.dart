import 'package:flutter/material.dart';
import 'package:iungo_application/widgets/line_chart_widget.dart';

class WasteManagementProvider extends ChangeNotifier {
  int _selectedTabIndex = 0;
  DateTimeRange? _selectedDateRange;

  // Getters
  int get selectedTabIndex => _selectedTabIndex;
  DateTimeRange? get selectedDateRange => _selectedDateRange;

  // Tab selection
  void selectTab(int index) {
    if (_selectedTabIndex != index) {
      _selectedTabIndex = index;
      notifyListeners();
    }
  }

  // Date range selection
  void setDateRange(DateTimeRange? dateRange) {
    _selectedDateRange = dateRange;
    notifyListeners();
  }

  // Mock data - replace with actual API calls
  Map<String, dynamic> getBinCollectionData() {
    return {
      'binsDeployed': '2881',
      'binsInStock': '221',
      'binsStolenVandalised': '221',
      'complianceCompleted': 89,
      'complianceTotal': 145,
      'binsCollectedToday': '38',
      'binsCollectedPerTruck': '16.3',
      'avgCollectedPerDay': '19.1',
      'binsWashed': '29',
      'avgBinsWashedPerTruck': '18.5',
    };
  }

  List<ChartDataPoint> getBinsCollectedPerDayData() {
    return [
      ChartDataPoint(label: 'Apr 23', value: 45),
      ChartDataPoint(label: 'Apr 30', value: 52),
      ChartDataPoint(label: 'May 7', value: 68),
      ChartDataPoint(label: 'May 14', value: 62),
      ChartDataPoint(label: 'May 21', value: 85),
      ChartDataPoint(label: 'May 28', value: 98),
      ChartDataPoint(label: 'Jun 4', value: 92),
    ];
  }

  List<ChartDataPoint> getTruckEfficiencyData() {
    return [
      ChartDataPoint(label: 'May 7', value: 42),
      ChartDataPoint(label: 'May 14', value: 55),
      ChartDataPoint(label: 'May 21', value: 72),
      ChartDataPoint(label: 'May 28', value: 68),
      ChartDataPoint(label: 'Jun 4', value: 95),
      ChartDataPoint(label: 'Jun 11', value: 98),
    ];
  }

  List<ChartDataPoint> getBinsWashedPerDayData() {
    return [
      ChartDataPoint(label: 'Apr 30', value: 38),
      ChartDataPoint(label: 'May 7', value: 52),
      ChartDataPoint(label: 'May 14', value: 68),
      ChartDataPoint(label: 'May 21', value: 58),
      ChartDataPoint(label: 'May 28', value: 88),
      ChartDataPoint(label: 'Jun 4', value: 102),
    ];
  }

  Map<String, dynamic> getWorkOrdersData() {
    return {
      'xLabels': [
        'May 7',
        'May 14',
        'May 21',
        'May 28',
        'Jun 4',
        'Jun 11',
      ],
      'lines': [
        {
          'label': 'Closed o/ SLA',
          'data': [115.0, 72.0, 88.0, 78.0, 88.0, 115.0],
          'color': 'gray',
        },
        {
          'label': 'Closed w/ SLA',
          'data': [62.0, 75.0, 108.0, 85.0, 102.0, 118.0],
          'color': 'green',
        },
        {
          'label': 'Open o/ SLA',
          'data': [32.0, 45.0, 68.0, 95.0, 112.0, 98.0],
          'color': 'red',
        },
        {
          'label': 'Open w/ SLA',
          'data': [28.0, 35.0, 58.0, 75.0, 85.0, 72.0],
          'color': 'blue',
        },
      ],
    };
  }
}
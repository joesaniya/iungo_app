import 'package:flutter/material.dart';

class FilterOption {
  final String id;
  final String name;

  FilterOption({required this.id, required this.name});

  factory FilterOption.fromJson(Map<String, dynamic> json) {
    return FilterOption(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}

class WasteData {
  final String totalWeight;
  final List<String> labels;
  final List<double> values;
  final Map<String, dynamic>? chartData;

  WasteData({
    required this.totalWeight,
    required this.labels,
    required this.values,
    this.chartData,
  });

  factory WasteData.fromJson(Map<String, dynamic> json) {
    // Handle nested 'data' object
    final dataObj = json['data'] ?? json;

    // Get total_weight and handle empty string
    String totalWeight = dataObj['total_weight']?.toString() ?? '0';
    if (totalWeight.isEmpty) {
      totalWeight = '0';
    }

    return WasteData(
      totalWeight: totalWeight,
      labels:
          (dataObj['labels'] as List?)?.map((e) => e.toString()).toList() ?? [],
      values:
          (dataObj['values'] as List?)
              ?.map((e) => double.tryParse(e.toString()) ?? 0.0)
              .toList() ??
          [],
      chartData: dataObj,
    );
  }

  // Helper getter for display
  String get displayWeight => totalWeight;

  // Helper to get total as double
  double get totalAsDouble {
    return double.tryParse(totalWeight.replaceAll(',', '')) ?? 0.0;
  }

  // Helper to get sum of all values
  double get totalValue {
    return values.fold(0.0, (sum, value) => sum + value);
  }
}

class ZoneData {
  final String zoneName;
  final double value;
  final Color color;

  ZoneData({required this.zoneName, required this.value, required this.color});
}

class VehicleEmission {
  final String vehicleId;
  final double emission;
  final Color color;

  VehicleEmission({
    required this.vehicleId,
    required this.emission,
    required this.color,
  });
}

class WasteComposition {
  final String category;
  final double percentage;
  final Color color;

  WasteComposition({
    required this.category,
    required this.percentage,
    required this.color,
  });
}

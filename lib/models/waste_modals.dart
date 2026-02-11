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
  final String value;
  final String unit;
  final Map<String, dynamic>? chartData;

  WasteData({
    required this.value,
    required this.unit,
    this.chartData,
  });

  factory WasteData.fromJson(Map<String, dynamic> json) {
    return WasteData(
      value: json['value']?.toString() ?? '0',
      unit: json['unit']?.toString() ?? '',
      chartData: json['chart_data'] as Map<String, dynamic>?,
    );
  }
}

class ZoneData {
  final String zoneName;
  final double value;
  final Color color;

  ZoneData({
    required this.zoneName,
    required this.value,
    required this.color,
  });
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
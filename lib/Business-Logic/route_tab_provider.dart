import 'package:flutter/material.dart';
import 'package:iungo_application/models/waste_modals.dart';
import 'package:iungo_application/services/waste_management_service.dart';


class RouteTabProvider extends ChangeNotifier {
  final WasteManagementService _service = WasteManagementService();

  // Filter options
  List<FilterOption> zones = [];
  List<FilterOption> vehicles = [];
  List<FilterOption> routes = [];
  List<FilterOption> regions = [];

  // Selected filter values
  String? selectedZone;
  String? selectedVehicle;
  String? selectedRoute;
  String? selectedRegion;
  DateTime? fromDate;
  DateTime? toDate;

  // Data
  WasteData? totalWasteCollected;
  WasteData? collectionCompletion;
  WasteData? co2Emission;
  WasteData? routeEfficiency;

  bool isLoading = false;
  bool filtersLoaded = false;

  // Initialize filters
  Future<void> initializeFilters() async {
    if (filtersLoaded) return;
    
    isLoading = true;
    notifyListeners();

    try {
      zones = await _service.fetchZones();
      vehicles = await _service.fetchVehicles();
      routes = await _service.fetchRoutes();
      regions = await _service.fetchRegions();
      filtersLoaded = true;
    } catch (e) {
      print('Error loading filters: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  // Update filter selections
  void setZone(String? value) {
    selectedZone = value;
    notifyListeners();
  }

  void setVehicle(String? value) {
    selectedVehicle = value;
    notifyListeners();
  }

  void setRoute(String? value) {
    selectedRoute = value;
    notifyListeners();
  }

  void setRegion(String? value) {
    selectedRegion = value;
    notifyListeners();
  }

  void setDateRange(DateTime? from, DateTime? to) {
    fromDate = from;
    toDate = to;
    notifyListeners();
  }

  // Apply filters and fetch data
  Future<void> applyFilters() async {
    isLoading = true;
    notifyListeners();

    try {
      final fromDateStr = fromDate != null
          ? '${fromDate!.year}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}'
          : '';
      final toDateStr = toDate != null
          ? '${toDate!.year}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}'
          : '';

      // Fetch all data in parallel with exact body format
      final results = await Future.wait([
        _service.fetchWasteData(
          viewName: 'total_waste_collected',
          zone: selectedZone ?? '',
          route: selectedRoute ?? '',
          vehicle: selectedVehicle ?? '',
          region: selectedRegion ?? '',
          fromDate: fromDateStr,
          toDate: toDateStr,
        ),
        _service.fetchWasteData(
          viewName: 'collection_completion',
          zone: selectedZone ?? '',
          route: selectedRoute ?? '',
          vehicle: selectedVehicle ?? '',
          region: selectedRegion ?? '',
          fromDate: fromDateStr,
          toDate: toDateStr,
        ),
        _service.fetchWasteData(
          viewName: 'co2_emission',
          zone: selectedZone ?? '',
          route: selectedRoute ?? '',
          vehicle: selectedVehicle ?? '',
          region: selectedRegion ?? '',
          fromDate: fromDateStr,
          toDate: toDateStr,
        ),
        _service.fetchWasteData(
          viewName: 'route_efficiency',
          zone: selectedZone ?? '',
          route: selectedRoute ?? '',
          vehicle: selectedVehicle ?? '',
          region: selectedRegion ?? '',
          fromDate: fromDateStr,
          toDate: toDateStr,
        ),
      ]);

      totalWasteCollected = results[0];
      collectionCompletion = results[1];
      co2Emission = results[2];
      routeEfficiency = results[3];
    } catch (e) {
      print('Error applying filters: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  void clearFilters() {
    selectedZone = null;
    selectedVehicle = null;
    selectedRoute = null;
    selectedRegion = null;
    fromDate = null;
    toDate = null;
    notifyListeners();
  }
}
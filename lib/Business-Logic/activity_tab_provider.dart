import 'package:flutter/material.dart';
import 'package:iungo_application/models/waste_modals.dart';
import 'package:iungo_application/services/waste_management_service.dart';

class ActivityTabProvider extends ChangeNotifier {
  final WasteManagementService _service = WasteManagementService();

  // Filter options
  List<FilterOption> vehicles = [];
  List<FilterOption> disposalAreas = [];
  List<FilterOption> wasteTypes = [];

  // Selected filter values
  String? selectedVehicle;
  String? selectedDisposalArea;
  String? selectedWasteType;

  // Data
  WasteData? diversionRate;
  WasteData? citWasteComposition;
  WasteData? nonCitWasteComposition;

  bool isLoading = false;
  bool filtersLoaded = false;

  // Initialize filters
  Future<void> initializeFilters() async {
    if (filtersLoaded) return;

    isLoading = true;
    notifyListeners();

    try {
      print('📥 Fetching MRF vehicles...');
      vehicles = await _service.fetchMRFVehicles();
      print('✅ MRF Vehicles loaded: ${vehicles.length} items');

      print('📥 Fetching disposal areas...');
      disposalAreas = await _service.fetchDisposalAreas();
      print('✅ Disposal areas loaded: ${disposalAreas.length} items');

      print('📥 Fetching waste types...');
      wasteTypes = await _service.fetchWasteTypes();
      print('✅ Waste types loaded: ${wasteTypes.length} items');

      filtersLoaded = true;

      print('🎉 All activity filters loaded successfully!');
    } catch (e) {
      print('❌ Error loading activity filters: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  // Update filter selections
  void setVehicle(String? value) {
    selectedVehicle = value;
    notifyListeners();
  }

  void setDisposalArea(String? value) {
    selectedDisposalArea = value;
    notifyListeners();
  }

  void setWasteType(String? value) {
    selectedWasteType = value;
    notifyListeners();
  }

  // Apply filters and fetch data
  Future<void> applyFilters() async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch all data in parallel
      final results = await Future.wait([
        _service.fetchWasteData(
          viewName: 'diversion_rate',
          vehicleId: selectedVehicle,
          disposalArea: selectedDisposalArea,
          wasteType: selectedWasteType,
        ),
        _service.fetchWasteData(
          viewName: 'cit_waste',
          vehicleId: selectedVehicle,
          disposalArea: selectedDisposalArea,
          wasteType: selectedWasteType,
        ),
        _service.fetchWasteData(
          viewName: 'non_cit_waste',
          vehicleId: selectedVehicle,
          disposalArea: selectedDisposalArea,
          wasteType: selectedWasteType,
        ),
      ]);

      diversionRate = results[0];
      citWasteComposition = results[1];
      nonCitWasteComposition = results[2];
    } catch (e) {
      print('Error applying filters: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  void clearFilters() {
    selectedVehicle = null;
    selectedDisposalArea = null;
    selectedWasteType = null;
    notifyListeners();
  }
}

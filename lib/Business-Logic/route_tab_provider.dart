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

  // Selected filter values (null means "All")
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

  // Initialize filters AND load initial data
  Future<void> initializeFilters() async {
    if (filtersLoaded) return;

    isLoading = true;
    notifyListeners();

    try {
      print('📥 Fetching zones...');
      zones = await _service.fetchZones();
      print('✅ Zones loaded: ${zones.length} items');

      print('📥 Fetching vehicles...');
      vehicles = await _service.fetchVehicles();
      print('✅ Vehicles loaded: ${vehicles.length} items');

      print('📥 Fetching routes...');
      routes = await _service.fetchRoutes();
      print('✅ Routes loaded: ${routes.length} items');

      print('📥 Fetching regions...');
      regions = await _service.fetchRegions();
      print('✅ Regions loaded: ${regions.length} items');

      filtersLoaded = true;
      print('🎉 All filters loaded successfully!');

      // Automatically load initial data with EMPTY filters (show all data)
      await _loadData();
    } catch (e) {
      print('❌ Error loading filters: $e');
      isLoading = false;
      notifyListeners();
    }
  }

  // Private method to load data
  Future<void> _loadData() async {
    try {
      // Format dates only if they exist
      final fromDateStr = fromDate != null
          ? '${fromDate!.year}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}'
          : '';
      final toDateStr = toDate != null
          ? '${toDate!.year}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}'
          : '';

      print('🔄 Loading waste data...');
      print('   Zone: ${selectedZone ?? "ALL"}');
      print('   Vehicle: ${selectedVehicle ?? "ALL"}');
      print('   Route: ${selectedRoute ?? "ALL"}');
      print('   Region: ${selectedRegion ?? "ALL"}');
      print('   From: ${fromDateStr.isEmpty ? "ALL" : fromDateStr}');
      print('   To: ${toDateStr.isEmpty ? "ALL" : toDateStr}');

      // Fetch all data in parallel - use EMPTY STRING for null values
      final results = await Future.wait([
        _service.fetchWasteData(
          viewName: 'total_waste_collected',
          zone: selectedZone ?? '', // Empty string = ALL
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

      print('✅ Data loaded successfully!');
      print('   Total Waste: ${totalWasteCollected ?? "null"}');
      print('   Completion: ${collectionCompletion ?? "null"}');
      print('   CO2: ${co2Emission ?? "null"}');
      print('   Efficiency: ${routeEfficiency ?? "null"}');
    } catch (e) {
      print('❌ Error loading data: $e');
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

    await _loadData();
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

/*import 'package:flutter/material.dart';
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

  // Initialize filters AND load initial data
  Future<void> initializeFilters() async {
    if (filtersLoaded) return;

    isLoading = true;
    notifyListeners();

    try {
      print('📥 Fetching zones...');
      zones = await _service.fetchZones();
      print('✅ Zones loaded: ${zones.length} items');

      print('📥 Fetching vehicles...');
      vehicles = await _service.fetchVehicles();
      print('✅ Vehicles loaded: ${vehicles.length} items');

      print('📥 Fetching routes...');
      routes = await _service.fetchRoutes();
      print('✅ Routes loaded: ${routes.length} items');

      print('📥 Fetching regions...');
      regions = await _service.fetchRegions();
      print('✅ Regions loaded: ${regions.length} items');

      filtersLoaded = true;
      print('🎉 All filters loaded successfully!');

      // Automatically load initial data with empty filters
      await _loadData();
    } catch (e) {
      print('❌ Error loading filters: $e');
      isLoading = false;
      notifyListeners();
    }
  }

  // Private method to load data
  Future<void> _loadData() async {
    try {
      final fromDateStr = fromDate != null
          ? '${fromDate!.year}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}'
          : '';
      final toDateStr = toDate != null
          ? '${toDate!.year}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}'
          : '';

      print('🔄 Loading waste data...');

      // Fetch all data in parallel
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

      print('✅ Data loaded successfully!');
    } catch (e) {
      print('❌ Error loading data: $e');
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

    await _loadData();
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


*/

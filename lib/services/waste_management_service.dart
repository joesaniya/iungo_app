
import 'package:iungo_application/Data-Provider/dio-client.dart';
import 'package:iungo_application/models/waste_modals.dart';


class WasteManagementService {
  final DioClient _dioClient = DioClient();
  final String baseUrl = 'https://iungo.citgroupltd.com/API';

  // Fetch zone filter options
  Future<List<FilterOption>> fetchZones() async {
    final response = await _dioClient.performCall(
      requestType: RequestType.post,
      url: '$baseUrl/filter_master.php',
      data: {'fetchzone': '1'},
    );

    if (response?.statusCode == 200 && response?.data != null) {
      final List data = response!.data['zones'] ?? [];
      return data.map((e) => FilterOption.fromJson(e)).toList();
    }
    return [];
  }

  // Fetch vehicle filter options
  Future<List<FilterOption>> fetchVehicles() async {
    final response = await _dioClient.performCall(
      requestType: RequestType.post,
      url: '$baseUrl/filter_master.php',
      data: {'fetchvehicle': '1'},
    );

    if (response?.statusCode == 200 && response?.data != null) {
      final List data = response!.data['vehicles'] ?? [];
      return data.map((e) => FilterOption.fromJson(e)).toList();
    }
    return [];
  }

  // Fetch route filter options
  Future<List<FilterOption>> fetchRoutes() async {
    final response = await _dioClient.performCall(
      requestType: RequestType.post,
      url: '$baseUrl/filter_master.php',
      data: {'fetchroute': '1'},
    );

    if (response?.statusCode == 200 && response?.data != null) {
      final List data = response!.data['routes'] ?? [];
      return data.map((e) => FilterOption.fromJson(e)).toList();
    }
    return [];
  }

  // Fetch region filter options
  Future<List<FilterOption>> fetchRegions() async {
    final response = await _dioClient.performCall(
      requestType: RequestType.post,
      url: '$baseUrl/filter_master.php',
      data: {'fetchregion': '1'},
    );

    if (response?.statusCode == 200 && response?.data != null) {
      final List data = response!.data['regions'] ?? [];
      return data.map((e) => FilterOption.fromJson(e)).toList();
    }
    return [];
  }

  // Fetch MRF vehicles
  Future<List<FilterOption>> fetchMRFVehicles() async {
    final response = await _dioClient.performCall(
      requestType: RequestType.post,
      url: '$baseUrl/filter_master.php',
      data: {'fetchmrfvehicle': '1'},
    );

    if (response?.statusCode == 200 && response?.data != null) {
      final List data = response!.data['vehicles'] ?? [];
      return data.map((e) => FilterOption.fromJson(e)).toList();
    }
    return [];
  }

  // Fetch disposal areas
  Future<List<FilterOption>> fetchDisposalAreas() async {
    final response = await _dioClient.performCall(
      requestType: RequestType.post,
      url: '$baseUrl/filter_master.php',
      data: {'fetchdisposalarea': '1'},
    );

    if (response?.statusCode == 200 && response?.data != null) {
      final List data = response!.data['disposal_areas'] ?? [];
      return data.map((e) => FilterOption.fromJson(e)).toList();
    }
    return [];
  }

  // Fetch waste types
  Future<List<FilterOption>> fetchWasteTypes() async {
    final response = await _dioClient.performCall(
      requestType: RequestType.post,
      url: '$baseUrl/filter_master.php',
      data: {'fetchwastetype': '1'},
    );

    if (response?.statusCode == 200 && response?.data != null) {
      final List data = response!.data['waste_types'] ?? [];
      return data.map((e) => FilterOption.fromJson(e)).toList();
    }
    return [];
  }

  // Fetch waste management data
  Future<WasteData?> fetchWasteData({
    required String viewName,
    String? zone,
    String? route,
    String? vehicle,
    String? region,
    String? fromDate,
    String? toDate,
    String? disposalArea,
    String? wasteType,
    String? vehicleId,
  }) async {
    Map<String, dynamic> requestBody = {};

    // For route tab - always include all fields
    if (zone != null || route != null || vehicle != null || region != null) {
      requestBody = {
        'zone': zone ?? '',
        'route': route ?? '',
        'vehicle': vehicle ?? '',
        'region': region ?? '',
        'from_date': fromDate ?? '',
        'to_date': toDate ?? '',
        'view_name': viewName,
      };
    } 
    // For activity tab
    else {
      requestBody = {
        'disposal_area': disposalArea ?? '',
        'waste_type': wasteType ?? '',
        'vehicle_id': vehicleId ?? '',
        'view_name': viewName,
      };
    }

    final response = await _dioClient.performCall(
      requestType: RequestType.post,
      url: '$baseUrl/waste_management_api.php',
      data: requestBody,
    );

    if (response?.statusCode == 200 && response?.data != null) {
      return WasteData.fromJson(response!.data);
    }
    return null;
  }
}
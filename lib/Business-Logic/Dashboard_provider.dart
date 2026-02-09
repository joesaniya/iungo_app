import 'package:flutter/material.dart';
import 'dart:developer';
import '../services/auth_storage.dart';

class DashboardProvider extends ChangeNotifier {
  final AuthStorage _authStorage = AuthStorage();

  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  String _userId = '';
  String _userName = '';
  String _userType = '';
  String _userEmail = '';

  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;
  String get userId => _userId;
  String get userName => _userName;
  String get userType => _userType;
  String get userEmail => _userEmail;

  DashboardProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _userData = await _authStorage.getUserData();

      log('Dashboard - User Data: $_userData');

      if (_userData != null) {
        // Extract user information based on API response structure
        _userId = _userData!['user_id'] ?? '';
        _userName = _userData!['username'] ?? 'User';
        _userType = _userData!['user_type'] ?? '';
        _userEmail = _userData!['email'] ?? '';

        log('User ID: $_userId');
        log('Username: $_userName');
        log('User Type: $_userType');
        log('Email: $_userEmail');
      }
    } catch (e) {
      log('Error loading user data: $e');
      _userName = 'User';
      _userEmail = '';
      _userType = '';
      _userId = '';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshUserData() async {
    await _loadUserData();
  }
}

/*import 'package:flutter/material.dart';
import '../services/auth_storage.dart';

class DashboardProvider extends ChangeNotifier {
  final AuthStorage _authStorage = AuthStorage();
  
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  String _userName = '';
  String _userEmail = '';

  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;
  String get userName => _userName;
  String get userEmail => _userEmail;

  DashboardProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _userData = await _authStorage.getUserData();
      
      if (_userData != null) {
        // Extract user information from the stored data
        // Adjust these keys based on your API response structure
        _userName = _userData!['name'] ?? _userData!['username'] ?? 'User';
        _userEmail = _userData!['email'] ?? _userData!['username'] ?? '';
      }
    } catch (e) {
      _userName = 'User';
      _userEmail = '';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshUserData() async {
    await _loadUserData();
  }
}*/

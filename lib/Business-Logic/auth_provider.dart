import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:iungo_application/services/auth_api_service.dart';
import 'dart:io';
import 'dart:developer';

import '../services/auth_storage.dart';

class AuthProvider extends ChangeNotifier {
  final AuthApiService _apiService = AuthApiService();
  final AuthStorage _authStorage = AuthStorage();

  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _errorMessage = '';
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _hasLoginError = false;
  bool _hasForgotPasswordError = false;
  bool _hasResetPasswordError = false;
  bool _hasSetPasswordError = false;

  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get hasLoginError => _hasLoginError;
  bool get hasForgotPasswordError => _hasForgotPasswordError;
  bool get hasResetPasswordError => _hasResetPasswordError;
  bool get hasSetPasswordError => _hasSetPasswordError;

  void setEmail(String value) {
    _email = value;
    _clearErrorIfNeeded();
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    _clearErrorIfNeeded();
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    _clearErrorIfNeeded();
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void _clearErrorIfNeeded() {
    if (_errorMessage.isNotEmpty) {
      _errorMessage = '';
      _hasLoginError = false;
      _hasForgotPasswordError = false;
      _hasResetPasswordError = false;
      _hasSetPasswordError = false;
    }
  }

  void clearError() {
    _errorMessage = '';
    _hasLoginError = false;
    _hasForgotPasswordError = false;
    _hasResetPasswordError = false;
    _hasSetPasswordError = false;
    notifyListeners();
  }

  // Get device information
  Future<Map<String, String>> _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceId = '';
    String deviceName = '';
    String deviceModal = '';

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        deviceName = androidInfo.device;
        deviceModal = androidInfo.model;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? '';
        deviceName = iosInfo.name;
        deviceModal = iosInfo.model;
      }
    } catch (e) {
      deviceId = 'unknown';
      deviceName = 'unknown';
      deviceModal = 'unknown';
    }

    return {
      'device_id': deviceId,
      'device_name': deviceName,
      'device_modal': deviceModal,
    };
  }

  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = '';
    _hasLoginError = false;
    notifyListeners();

    // Client-side validation
    if (_email.isEmpty || _password.isEmpty) {
      _errorMessage = 'Please fill in all fields';
      _hasLoginError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (!_email.contains('@')) {
      _errorMessage = 'Please enter a valid email';
      _hasLoginError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      // Get device information
      final deviceInfo = await _getDeviceInfo();

      // Call API
      final response = await _apiService.login(
        username: _email,
        password: _password,
        deviceId: deviceInfo['device_id']!,
        deviceName: deviceInfo['device_name']!,
        deviceModal: deviceInfo['device_modal']!,
      );

      log('Login Response: $response');

      if (response == null) {
        _errorMessage = 'Network error. Please check your connection.';
        _hasLoginError = true;
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Check response structure: {"code": 200, "data": {...}}
      if (response['code'] == 200 && response['data'] != null) {
        final userData = response['data'] as Map<String, dynamic>;

        log('Login successful! User data: $userData');

        // Save login state to SharedPreferences
        await _authStorage.saveLoginState(isLoggedIn: true, userData: userData);

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Login failed. Please try again.';
        _hasLoginError = true;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      log('Login exception: $e');

      // Extract the exact error message from the exception
      String errorText = e.toString();

      // Remove "Exception: " prefix if present
      if (errorText.startsWith('Exception: ')) {
        errorText = errorText.replaceFirst('Exception: ', '');
      }

      // Set the exact error message from API
      _errorMessage = errorText;
      _hasLoginError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login1() async {
    _isLoading = true;
    _errorMessage = '';
    _hasLoginError = false;
    notifyListeners();

    // Client-side validation
    if (_email.isEmpty ||
        _password.isEmpty ||
        !_email.contains('@') ||
        _password.length < 6) {
      _errorMessage =
          'Your email and password combination is wrong. Please try again';
      _hasLoginError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      // Get device information
      final deviceInfo = await _getDeviceInfo();

      // Call API
      final response = await _apiService.login(
        username: _email,
        password: _password,
        deviceId: deviceInfo['device_id']!,
        deviceName: deviceInfo['device_name']!,
        deviceModal: deviceInfo['device_modal']!,
      );

      log('Login Response: $response');

      if (response == null) {
        _errorMessage = 'Network error. Please check your connection.';
        _hasLoginError = true;
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Check response structure: {"code": 200, "data": {...}}
      if (response['code'] == 200 && response['data'] != null) {
        final userData = response['data'] as Map<String, dynamic>;

        log('Login successful! User data: $userData');

        // Save login state to SharedPreferences
        await _authStorage.saveLoginState(isLoggedIn: true, userData: userData);

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage =
            'Your email and password combination is wrong. Please try again';
        _hasLoginError = true;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      log('Login exception: $e');
      _errorMessage =
          'Your email and password combination is wrong. Please try again';
      _hasLoginError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Check if user is already logged in
  Future<bool> checkLoginStatus() async {
    return await _authStorage.isLoggedIn();
  }

  // Logout
  Future<void> logout() async {
    await _authStorage.clearAll();
    reset();
  }

  Future<bool> resetPassword() async {
    _isLoading = true;
    _errorMessage = '';
    _hasForgotPasswordError = false;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (_email.isEmpty) {
      _errorMessage = 'Please enter your email';
      _hasForgotPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (!_email.contains('@')) {
      _errorMessage = 'Please enter a valid email';
      _hasForgotPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> submitSetPassword() async {
    _isLoading = true;
    _errorMessage = '';
    _hasSetPasswordError = false;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (_email.isEmpty || _password.isEmpty || _confirmPassword.isEmpty) {
      _errorMessage = 'Please fill in all fields';
      _hasSetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (!_email.contains('@')) {
      _errorMessage = 'Please enter a valid email';
      _hasSetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (_password.length < 6) {
      _errorMessage = 'Password must be at least 6 characters';
      _hasSetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (_password != _confirmPassword) {
      _errorMessage = 'Passwords do not match';
      _hasSetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> submitResetPassword() async {
    _isLoading = true;
    _errorMessage = '';
    _hasResetPasswordError = false;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (_password.isEmpty || _confirmPassword.isEmpty) {
      _errorMessage = 'Please fill in all fields';
      _hasResetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (_password.length < 6) {
      _errorMessage = 'Password must be at least 6 characters';
      _hasResetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (_password != _confirmPassword) {
      _errorMessage = 'Passwords do not match';
      _hasResetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  void reset() {
    _email = '';
    _password = '';
    _confirmPassword = '';
    _errorMessage = '';
    _isLoading = false;
    _isPasswordVisible = false;
    _isConfirmPasswordVisible = false;
    _hasLoginError = false;
    _hasForgotPasswordError = false;
    _hasResetPasswordError = false;
    _hasSetPasswordError = false;
    notifyListeners();
  }
}

/*import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:iungo_application/services/auth_api_service.dart';
import 'dart:io';

import '../services/auth_storage.dart';

class AuthProvider extends ChangeNotifier {
  final AuthApiService _apiService = AuthApiService();
  final AuthStorage _authStorage = AuthStorage();

  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _errorMessage = '';
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _hasLoginError = false;
  bool _hasForgotPasswordError = false;
  bool _hasResetPasswordError = false;
  bool _hasSetPasswordError = false;

  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get hasLoginError => _hasLoginError;
  bool get hasForgotPasswordError => _hasForgotPasswordError;
  bool get hasResetPasswordError => _hasResetPasswordError;
  bool get hasSetPasswordError => _hasSetPasswordError;

  void setEmail(String value) {
    _email = value;
    _clearErrorIfNeeded();
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    _clearErrorIfNeeded();
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    _clearErrorIfNeeded();
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void _clearErrorIfNeeded() {
    if (_errorMessage.isNotEmpty) {
      _errorMessage = '';
      _hasLoginError = false;
      _hasForgotPasswordError = false;
      _hasResetPasswordError = false;
      _hasSetPasswordError = false;
    }
  }

  void clearError() {
    _errorMessage = '';
    _hasLoginError = false;
    _hasForgotPasswordError = false;
    _hasResetPasswordError = false;
    _hasSetPasswordError = false;
    notifyListeners();
  }

  // Get device information
  Future<Map<String, String>> _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceId = '';
    String deviceName = '';
    String deviceModal = '';

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        deviceName = androidInfo.device;
        deviceModal = androidInfo.model;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? '';
        deviceName = iosInfo.name;
        deviceModal = iosInfo.model;
      }
    } catch (e) {
      deviceId = 'unknown';
      deviceName = 'unknown';
      deviceModal = 'unknown';
    }

    return {
      'device_id': deviceId,
      'device_name': deviceName,
      'device_modal': deviceModal,
    };
  }

  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = '';
    _hasLoginError = false;
    notifyListeners();

    // Client-side validation
    if (_email.isEmpty ||
        _password.isEmpty ||
        !_email.contains('@') ||
        _password.length < 6) {
      _errorMessage =
          'Your email and password combination is wrong. Please try again';
      _hasLoginError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      // Get device information
      final deviceInfo = await _getDeviceInfo();

      // Call API
      final response = await _apiService.login(
        username: _email,
        password: _password,
        deviceId: deviceInfo['device_id']!,
        deviceName: deviceInfo['device_name']!,
        deviceModal: deviceInfo['device_modal']!,
      );

      if (response != null && response['status'] == 'success') {
        // Save login state to SharedPreferences
        await _authStorage.saveLoginState(
          isLoggedIn: true,
          userData: response['data'],
          token: response['token'],
        );

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage =
            'Your email and password combination is wrong. Please try again';
        _hasLoginError = true;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage =
          'Your email and password combination is wrong. Please try again';
      _hasLoginError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Check if user is already logged in
  Future<bool> checkLoginStatus() async {
    return await _authStorage.isLoggedIn();
  }

  // Logout
  Future<void> logout() async {
    await _authStorage.clearAll();
    reset();
  }

  Future<bool> resetPassword() async {
    _isLoading = true;
    _errorMessage = '';
    _hasForgotPasswordError = false;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (_email.isEmpty) {
      _errorMessage = 'Please enter your email';
      _hasForgotPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (!_email.contains('@')) {
      _errorMessage = 'Please enter a valid email';
      _hasForgotPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> submitSetPassword() async {
    _isLoading = true;
    _errorMessage = '';
    _hasSetPasswordError = false;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (_email.isEmpty || _password.isEmpty || _confirmPassword.isEmpty) {
      _errorMessage = 'Please fill in all fields';
      _hasSetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (!_email.contains('@')) {
      _errorMessage = 'Please enter a valid email';
      _hasSetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (_password.length < 6) {
      _errorMessage = 'Password must be at least 6 characters';
      _hasSetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (_password != _confirmPassword) {
      _errorMessage = 'Passwords do not match';
      _hasSetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> submitResetPassword() async {
    _isLoading = true;
    _errorMessage = '';
    _hasResetPasswordError = false;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (_password.isEmpty || _confirmPassword.isEmpty) {
      _errorMessage = 'Please fill in all fields';
      _hasResetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (_password.length < 6) {
      _errorMessage = 'Password must be at least 6 characters';
      _hasResetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (_password != _confirmPassword) {
      _errorMessage = 'Passwords do not match';
      _hasResetPasswordError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  void reset() {
    _email = '';
    _password = '';
    _confirmPassword = '';
    _errorMessage = '';
    _isLoading = false;
    _isPasswordVisible = false;
    _isConfirmPasswordVisible = false;
    _hasLoginError = false;
    _hasForgotPasswordError = false;
    _hasResetPasswordError = false;
    _hasSetPasswordError = false;
    notifyListeners();
  }
}
*/
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
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
      notifyListeners();
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

  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = '';
    _hasLoginError = false;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Check all validation conditions and throw same error
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

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> login1() async {
    _isLoading = true;
    _errorMessage = '';
    _hasLoginError = false;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Example validation
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

    // Simulate login failure for demo
    if (_password.length < 6) {
      _errorMessage =
          'Your email and password combination is wrong. Please try again';
      _hasLoginError = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> resetPassword() async {
    _isLoading = true;
    _errorMessage = '';
    _hasForgotPasswordError = false;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Validate email
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

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Validate inputs
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

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Validate inputs
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

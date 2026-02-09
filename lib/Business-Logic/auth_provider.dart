import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String _errorMessage = '';
  bool _isLoading = false;
  
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  
  void setEmail(String value) {
    _email = value;
    _errorMessage = '';
    notifyListeners();
  }
  
  void setPassword(String value) {
    _password = value;
    _errorMessage = '';
    notifyListeners();
  }
  
  void setConfirmPassword(String value) {
    _confirmPassword = value;
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
  
  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
  
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }
  
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  
  Future<bool> login() async {
    setLoading(true);
    clearError();
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Validate credentials
    if (_email.isEmpty || _password.isEmpty) {
      setErrorMessage('Please fill in all fields');
      setLoading(false);
      return false;
    }
    
    if (!_email.contains('@')) {
      setErrorMessage('Please enter a valid email address');
      setLoading(false);
      return false;
    }
    
    // Simulate wrong credentials
    if (_email != 'johndoe@email.com' || _password != 'password123') {
      setErrorMessage('Your email and password combination is wrong. Please try again.');
      setLoading(false);
      return false;
    }
    
    setLoading(false);
    return true;
  }
  
  Future<bool> resetPassword() async {
    setLoading(true);
    clearError();
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    if (_email.isEmpty) {
      setErrorMessage('Please enter your email address');
      setLoading(false);
      return false;
    }
    
    if (!_email.contains('@')) {
      setErrorMessage('Please enter a valid email address');
      setLoading(false);
      return false;
    }
    
    setLoading(false);
    return true;
  }
  
  Future<bool> setNewPassword() async {
    setLoading(true);
    clearError();
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    if (_password.isEmpty || _confirmPassword.isEmpty) {
      setErrorMessage('Please fill in all fields');
      setLoading(false);
      return false;
    }
    
    if (_password.length < 8) {
      setErrorMessage('Password must be at least 8 characters');
      setLoading(false);
      return false;
    }
    
    if (_password != _confirmPassword) {
      setErrorMessage('Passwords do not match');
      setLoading(false);
      return false;
    }
    
    setLoading(false);
    return true;
  }
  
  void reset() {
    _email = '';
    _password = '';
    _confirmPassword = '';
    _isPasswordVisible = false;
    _isConfirmPasswordVisible = false;
    _errorMessage = '';
    _isLoading = false;
    notifyListeners();
  }
}

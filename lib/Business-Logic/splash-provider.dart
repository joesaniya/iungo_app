import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iungo_application/screens/Profile_screen.dart';
import 'package:iungo_application/screens/login_screen.dart';
import '../services/auth_storage.dart';

class SplashProvider extends ChangeNotifier {
  double _opacity = 0.0;
  bool _isVisible = false;
  final AuthStorage _authStorage = AuthStorage();

  double get opacity => _opacity;
  bool get isVisible => _isVisible;

  SplashProvider(BuildContext context) {
    _startAnimation(context);
  }

  void _startAnimation(BuildContext context) {
    _isVisible = true;
    _opacity = 1.0;
    notifyListeners();

    Timer(const Duration(seconds: 3), () async {
      // Check login status
      final isLoggedIn = await _authStorage.isLoggedIn();

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                isLoggedIn ? ProfileScreen() : const LoginScreen(),
          ),
          (route) => false,
        );
      }
    });
  }
}

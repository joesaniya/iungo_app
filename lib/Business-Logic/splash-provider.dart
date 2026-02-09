import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:iungo_application/screens/login_screen.dart';
import 'package:iungo_application/screens/set_password_screen.dart';
import 'package:iungo_application/screens/set_password_screen_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  double _opacity = 0.0;
  bool _isVisible = false;

  double get opacity => _opacity;
  bool get isVisible => _isVisible;

  SplashProvider(BuildContext context) {
    _startAnimation(context);
  }

  void _startAnimation(BuildContext context) {
    _isVisible = true;
    _opacity = 1.0;
    notifyListeners();

    Timer(const Duration(seconds: 5), () async {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    });
  }
}

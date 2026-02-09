import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
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
      Navigator.pushNamed(context, '//set-password');
    });
  }
}

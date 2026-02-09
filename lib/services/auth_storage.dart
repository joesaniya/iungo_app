import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserData = 'user_data';

  // Save login state
  Future<void> saveLoginState({
    required bool isLoggedIn,
    required Map<String, dynamic> userData,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, isLoggedIn);
    await prefs.setString(_keyUserData, jsonEncode(userData));
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Get user data
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_keyUserData);
    
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  // Get specific user info
  Future<String?> getUserId() async {
    final userData = await getUserData();
    return userData?['user_id'];
  }

  Future<String?> getUsername() async {
    final userData = await getUserData();
    return userData?['username'];
  }

  Future<String?> getUserType() async {
    final userData = await getUserData();
    return userData?['user_type'];
  }

  Future<String?> getEmail() async {
    final userData = await getUserData();
    return userData?['email'];
  }

  // Clear all data (logout)
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthStorage {
//   static const String _keyIsLoggedIn = 'is_logged_in';
//   static const String _keyUserData = 'user_data';
//   static const String _keyToken = 'auth_token';

//   // Save login state
//   Future<void> saveLoginState({
//     required bool isLoggedIn,
//     Map<String, dynamic>? userData,
//     String? token,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_keyIsLoggedIn, isLoggedIn);
    
//     if (userData != null) {
//       await prefs.setString(_keyUserData, jsonEncode(userData));
//     }
    
//     if (token != null) {
//       await prefs.setString(_keyToken, token);
//     }
//   }

//   // Check if user is logged in
//   Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_keyIsLoggedIn) ?? false;
//   }

//   // Get user data
//   Future<Map<String, dynamic>?> getUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userDataString = prefs.getString(_keyUserData);
    
//     if (userDataString != null) {
//       return jsonDecode(userDataString);
//     }
//     return null;
//   }

//   // Get token
//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyToken);
//   }

//   // Clear all data (logout)
//   Future<void> clearAll() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//   }
// }
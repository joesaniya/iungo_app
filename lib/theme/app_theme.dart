import 'package:flutter/material.dart';

class AppTheme {
  // Color Styles from design system
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightNeutral100 = Color(0xFFF5F5F5);
  static const Color lightNeutral200 = Color(0xFFE0E0E0);
  static const Color gray = Color(0xFF9E9E9E);
  static const Color black = Color(0xFF000000);
  
  static const Color blue100 = Color(0xFFBBDEFB);
  static const Color blue300 = Color(0xFF64B5F6);
  static const Color blue500 = Color(0xFF2196F3);
  static const Color blue700 = Color(0xFF1976D2);
  static const Color blue900 = Color(0xFF0D47A1);
  
  static const Color red100 = Color(0xFFFFCDD2);
  static const Color red300 = Color(0xFFE57373);
  static const Color red700 = Color(0xFFD32F2F);
  static const Color red900 = Color(0xFFB71C1C);
  
  static const Color yellow600 = Color(0xFFFDD835);
  
  static const Color purple100 = Color(0xFFE1BEE7);
  static const Color purple700 = Color(0xFF7B1FA2);
  static const Color purple900 = Color(0xFF4A148C);
  
  static const Color green100 = Color(0xFFC8E6C9);
  static const Color green500 = Color(0xFF4CAF50);
  static const Color green700 = Color(0xFF388E3C);
  
  // Primary brand colors
  static const Color primaryPurple = Color(0xFF5D2E5F); // Main button color
  static const Color primaryRed = Color(0xFFC62828); // Logo red
  static const Color errorRed = Color(0xFFD32F2F);
  static const Color successGreen = Color(0xFF81C784);
  
  // Text Styles based on design system
  static const String fontFamily = 'Gotham';
  
  // H1 - 34/40
  static TextStyle h1 = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 34,
    height: 40 / 34,
    fontWeight: FontWeight.w500,
    color: Color(0xFF333333),
  );
  
  // H2 - 26/32
  static TextStyle h2 = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    height: 32 / 26,
    fontWeight: FontWeight.w500,
    color: Color(0xFF333333),
  );
  
  // H3 - 18/24
  static TextStyle h3 = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w500,
    color: Color(0xFF333333),
  );
  
  // H4 - 16/19
  static TextStyle h4 = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 19 / 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFF333333),
  );
  
  // H5 (light) - 14/20
  static TextStyle h5Light = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF666666),
  );
  
  // H5 (strong) - 14/20
  static TextStyle h5Strong = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF333333),
  );
  
  // Paragraph (light) - 12/17
  static TextStyle pLight = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 17 / 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF666666),
  );
  
  // Paragraph (strong) - 12/17
  static TextStyle pStrong = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 17 / 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF333333),
  );
  
  // Minimal - 9/13
  static TextStyle minimal = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    height: 13 / 9,
    fontWeight: FontWeight.w500,
    color: Color(0xFF666666),
  );
  
  // Button text style
  static TextStyle buttonText = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 19 / 16,
    fontWeight: FontWeight.w500,
    color: white,
  );
  
  // Input label style
  static TextStyle inputLabel = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 17 / 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF666666),
  );
  
  // Link text style
  static TextStyle linkText = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 17 / 12,
    fontWeight: FontWeight.w500,
    color: primaryPurple,
    decoration: TextDecoration.none,
  );
  
  // Helper text style
  static TextStyle helperText = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    height: 15 / 11,
    fontWeight: FontWeight.w400,
    color: Color(0xFF666666),
  );
  
  // Error text style
  static TextStyle errorText = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    height: 15 / 11,
    fontWeight: FontWeight.w400,
    color: errorRed,
  );
  
  // Responsive sizing utility
  static double getResponsiveSize(BuildContext context, double size) {
    final width = MediaQuery.of(context).size.width;
    // Base width is 375 (iPhone standard)
    return size * (width / 375);
  }
  
  static double getResponsiveHeight(BuildContext context, double height) {
    final screenHeight = MediaQuery.of(context).size.height;
    // Base height is 812 (iPhone standard)
    return height * (screenHeight / 812);
  }
  
  // Shadow styles
  static List<BoxShadow> elevation9 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.09),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> elevation17 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.17),
      blurRadius: 30,
      offset: const Offset(0, 6),
    ),
  ];
}

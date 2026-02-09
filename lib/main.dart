import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iungo_application/Business-Logic/common-provider.dart';
import 'package:iungo_application/screens/splash_screen.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: ProviderHelperClass.instance.providerLists,
      child: ScreenUtilInit(
        designSize: const Size(390, 840),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: AppTheme.primaryPurple,
              scaffoldBackgroundColor: AppTheme.lightNeutral100,
              fontFamily: AppTheme.fontFamily,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppTheme.primaryPurple,
                primary: AppTheme.primaryPurple,
                secondary: AppTheme.primaryRed,
              ),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
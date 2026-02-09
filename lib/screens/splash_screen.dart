import 'package:flutter/material.dart';
import 'package:iungo_application/Business-Logic/splash-provider.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashProvider(context),
      child: Consumer<SplashProvider>(
        builder: (context, splashProvider, _) {
          return Scaffold(
            backgroundColor: AppTheme.lightNeutral100,
            body: Center(
              child: AnimatedOpacity(
                opacity: splashProvider.opacity,
                duration: const Duration(seconds: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedScale(
                      scale: splashProvider.isVisible ? 1.2 : 0.8,
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInOut,
                      // child: const Icon(
                      //   Icons.videocam_rounded,
                      //   color: Colors.white,
                      //   size: 100,
                      // ),
                      child: Image.asset(
                        'assets/images/iungo-logo.png',

                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Ingo App",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(color: Colors.white),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashProvider>(context, listen: false).startAnimation(
        context,
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          );
        },
      );
    });
  }*/

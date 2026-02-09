import 'package:flutter/material.dart';
import 'package:iungo_application/Business-Logic/Dashboard_provider.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, _) {
          return Scaffold(
            backgroundColor: AppTheme.lightNeutral100,
            body:Text("Dashboard")
          );
        },
      ),
    );
  }
}
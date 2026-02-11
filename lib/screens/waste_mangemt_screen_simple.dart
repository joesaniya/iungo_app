import 'package:flutter/material.dart';
import 'package:iungo_application/screens/activity_tab_screen.dart';
import 'package:iungo_application/screens/route_tab_screen.dart';

import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

class WasteManagementScreen1 extends StatefulWidget {
  const WasteManagementScreen1({super.key});

  @override
  State<WasteManagementScreen1> createState() => _WasteManagementScreen1State();
}

class _WasteManagementScreen1State extends State<WasteManagementScreen1>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightNeutral100,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.lightNeutral100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tap to Select Client',
                style: AppTheme.h5Strong.copyWith(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: AppColors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primaryPurple,
              indicatorWeight: 3,
              labelColor: AppColors.primaryPurple,
              unselectedLabelColor: AppColors.textSecondary,
              labelStyle: AppTheme.h5Strong.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Route'),
                Tab(text: 'Activity'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [RouteTab(), ActivityTab()],
      ),
    );
  }
}

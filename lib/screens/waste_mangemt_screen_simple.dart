import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iungo_application/screens/activity_tab_screen.dart';
import 'package:iungo_application/screens/route_tab_screen.dart';
import 'package:iungo_application/widgets/custom_appbar_widget.dart';

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
    log('Initializing WasteManagementScreen1 with TabController');
    _tabController = TabController(
      length: 4,
      vsync: this,
    ); // FIXED: Changed from 2 to 4
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
      appBar: CustomAppBar(onMenuPressed: () {}),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: AppColors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start, // Align tabs to start
              labelColor: AppColors.textPrimary,
              unselectedLabelColor: AppColors.textSecondary,
              labelStyle: AppTheme.h5Strong.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTheme.h5Light.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              indicatorColor: AppColors.primaryPurple,
              indicatorWeight: 2.5,
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.zero, // Remove container padding
              labelPadding: const EdgeInsets.symmetric(
                horizontal: 12,
              ), // Reduced from 16
              dividerColor: AppColors.border.withOpacity(0.2),
              overlayColor: WidgetStateProperty.all(
                Colors.transparent,
              ), // Remove splash effect
              tabs: const [
                Tab(text: 'Route'),
                Tab(text: 'Activity'),
                Tab(text: 'Fleet efficiency'),
                Tab(text: 'Weighing details'),
              ],
            ),
          ),

          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                RouteTab(), // Bin collection data
                ActivityTab(), // Monitoring service
                ComingSoonTab(tabName: 'Fleet efficiency'),
                ComingSoonTab(tabName: 'Weighing details'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Coming Soon Placeholder Widget
class ComingSoonTab extends StatelessWidget {
  final String tabName;

  const ComingSoonTab({super.key, required this.tabName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.lightNeutral100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction_rounded,
              size: 64,
              color: AppColors.textSecondary.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              tabName,
              style: AppTheme.h5Strong.copyWith(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Coming Soon',
              style: AppTheme.pLight.copyWith(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iungo_application/screens/activity_tab_screen.dart';
import 'package:iungo_application/screens/route_tab_screen.dart';
import 'package:iungo_application/widgets/custom_appbar_widget.dart';

import '../theme/app_theme.dart';

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
    log('Initializing WasteManagementScreen1 with TabController');
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
      appBar: CustomAppBar(onMenuPressed: () {}),
      body: TabBarView(
        controller: _tabController,
        children: const [RouteTab(), ActivityTab()],
      ),
    );
  }
}
*/
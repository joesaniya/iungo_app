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

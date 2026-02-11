import 'package:flutter/material.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:iungo_application/widgets/custom_appbar_widget.dart';
import 'package:iungo_application/widgets/custom_tab_bar_widget.dart';

import 'package:iungo_application/widgets/multi_line_chart_cwidget.dart';
import 'package:iungo_application/widgets/section_header_widget.dart';
import 'package:iungo_application/widgets/star_card_widget.dart';

import 'package:iungo_application/widgets/circular_compliance_widget.dart';
import 'package:iungo_application/widgets/line_chart_widget.dart';

class WasteManagementScreen extends StatefulWidget {
  const WasteManagementScreen({super.key});

  @override
  State<WasteManagementScreen> createState() => _WasteManagementScreenState();
}

class _WasteManagementScreenState extends State<WasteManagementScreen> {
  int _selectedTabIndex = 0;

  final List<TabItem> _tabs = [
    TabItem(title: 'Bin collection data'),
    TabItem(title: 'Monitoring service'),
    TabItem(title: 'Fleet efficiency'),
    TabItem(title: 'Weighing details', comingSoon: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: CustomAppBar(
        onMenuPressed: () {
          _showMenuDrawer(context);
        },
      ),
      body: Column(
        children: [
          // Title and Date Range
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Waste management',
                  style: AppTheme.h2.copyWith(
                    fontSize: 26,
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.w500,
                    height: 32 / 26,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Show date range picker
                  },
                  child: Row(
                    children: [
                      Text(
                        'Date range',
                        style: AppTheme.pStrong.copyWith(
                          fontSize: 12,
                          color: const Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Color(0xFF333333),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTabBar(
              tabs: _tabs,
              selectedIndex: _selectedTabIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Scroll to top or other action
        },
        backgroundColor: AppTheme.primaryPurple,
        child: const Icon(Icons.keyboard_arrow_up, color: AppTheme.white),
      ),*/
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildBinCollectionDataTab();
      case 1:
        return _buildMonitoringServiceTab();
      case 2:
        return _buildFleetEfficiencyTab();
      default:
        return const SizedBox();
    }
  }

  Widget _buildBinCollectionDataTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bins information
        const SectionHeader(title: 'Bins information'),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: StatCard(
                value: '2881',
                label: 'Bins deployed',
                valueColor: Color(0xFF4CAF50), // Green 500
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: StatCard(
                value: '221',
                label: 'Bins in stock',
                valueColor: Color(0xFF4CAF50), // Green 500
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const StatCard(
          value: '221',
          label: 'Bins stolen / vandalised',
          valueColor: Color(0xFF4CAF50), // Green 500
          isFullWidth: true,
        ),
        const SizedBox(height: 24),

        // Compliance
        const SectionHeader(title: 'Compliance'),
        const SizedBox(height: 16),
        const CircularComplianceWidget(
          completed: 89,
          total: 145,
          progressColor: Color(0xFF4CAF50), // Green 500
        ),
        const SizedBox(height: 24),

        // Bins collection data
        const SectionHeader(title: 'Bins collection data'),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: StatCard(
                value: '38',
                label: 'Bins collected today',
                valueColor: Color(0xFF2196F3), // Blue 500
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: StatCard(
                value: '16.3',
                label: 'Bins collected per truck',
                valueColor: Color(0xFF2196F3), // Blue 500
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const StatCard(
          value: '19.1',
          label: 'Avg. collected per day',
          valueColor: Color(0xFF2196F3), // Blue 500
          isFullWidth: true,
        ),
        const SizedBox(height: 24),

        // Bins washing data
        const SectionHeader(title: 'Bins washing data'),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: StatCard(
                value: '29',
                label: 'Bins washed',
                valueColor: Color(0xFF2196F3), // Blue 500
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: StatCard(
                value: '18.5',
                label: 'Avg. bins washed per truck',
                valueColor: Color(0xFF2196F3), // Blue 500
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Bins collected per day chart
        LineChartWidget(
          title: 'Bins collected per day',
          lineColor: const Color(0xFF7B1FA2), // Purple 700
          fillColor: const Color(0xFFE1BEE7), // Purple 100
          data: [
            ChartDataPoint(label: 'Apr 23', value: 45),
            ChartDataPoint(label: 'Apr 30', value: 52),
            ChartDataPoint(label: 'May 7', value: 68),
            ChartDataPoint(label: 'May 14', value: 62),
            ChartDataPoint(label: 'May 21', value: 85),
            ChartDataPoint(label: 'May 28', value: 98),
            ChartDataPoint(label: 'Jun 4', value: 92),
          ],
        ),
        const SizedBox(height: 24),

        // Refuse collection truck efficiency chart
        LineChartWidget(
          title: 'Refuse collection truck efficiency',
          lineColor: const Color(0xFFD32F2F), // Red 700
          fillColor: const Color(0xFFFFCDD2), // Red 100
          data: [
            ChartDataPoint(label: 'May 7', value: 42),
            ChartDataPoint(label: 'May 14', value: 55),
            ChartDataPoint(label: 'May 21', value: 72),
            ChartDataPoint(label: 'May 28', value: 68),
            ChartDataPoint(label: 'Jun 4', value: 95),
            ChartDataPoint(label: 'Jun 11', value: 98),
          ],
        ),
        const SizedBox(height: 24),

        // Bins washed per day chart
        LineChartWidget(
          title: 'Bins washed per day',
          lineColor: const Color(0xFF388E3C), // Green 700
          fillColor: const Color(0xFFC8E6C9), // Green 100
          data: [
            ChartDataPoint(label: 'Apr 30', value: 38),
            ChartDataPoint(label: 'May 7', value: 52),
            ChartDataPoint(label: 'May 14', value: 68),
            ChartDataPoint(label: 'May 21', value: 58),
            ChartDataPoint(label: 'May 28', value: 88),
            ChartDataPoint(label: 'Jun 4', value: 102),
          ],
        ),
        const SizedBox(height: 24),

        // Work orders issued multi-line chart
        MultiLineChartWidget(
          title: 'Work orders issued',
          xLabels: const [
            'May 7',
            'May 14',
            'May 21',
            'May 28',
            'Jun 4',
            'Jun 11',
          ],
          infoIcon: const Icon(
            Icons.info_outline,
            size: 16,
            color: Color(0xFF666666),
          ),
          lines: [
            ChartLine(
              label: 'Closed o/ SLA',
              data: [115, 72, 88, 78, 88, 115],
              color: const Color(0xFF9E9E9E), // Gray
            ),
            ChartLine(
              label: 'Closed w/ SLA',
              data: [62, 75, 108, 85, 102, 118],
              color: const Color(0xFF388E3C), // Green 700
            ),
            ChartLine(
              label: 'Open o/ SLA',
              data: [32, 45, 68, 95, 112, 98],
              color: const Color(0xFFD32F2F), // Red 700
            ),
            ChartLine(
              label: 'Open w/ SLA',
              data: [28, 35, 58, 75, 85, 72],
              color: const Color(0xFF2196F3), // Blue 500
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Map placeholder (Work orders issued map)
        _buildMapPlaceholder(),
      ],
    );
  }

  Widget _buildMonitoringServiceTab() {
    return const Center(child: Text('Monitoring Service Content'));
  }

  Widget _buildFleetEfficiencyTab() {
    return const Center(child: Text('Fleet Efficiency Content'));
  }

  Widget _buildMapPlaceholder() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppTheme.elevation9,
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.map_outlined,
                  size: 64,
                  color: Color(0xFF9E9E9E),
                ),
                const SizedBox(height: 16),
                Text(
                  'Work orders issued',
                  style: AppTheme.h4.copyWith(color: const Color(0xFF666666)),
                ),
                const SizedBox(height: 8),
                Text(
                  'Map integration coming soon',
                  style: AppTheme.pLight.copyWith(
                    color: const Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Column(
              children: [
                _buildMapButton(Icons.add),
                const SizedBox(height: 8),
                _buildMapButton(Icons.remove),
                const SizedBox(height: 8),
                _buildMapButton(Icons.filter_alt_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF6B7C93),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, color: AppTheme.white, size: 20),
    );
  }

  void _showMenuDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Menu', style: AppTheme.h2),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // Add logout logic
              },
            ),
          ],
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:iungo_application/widgets/custom_appbar_widget.dart';

class WasteManagementScreen extends StatelessWidget {
  const WasteManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: CustomAppBar(
        onMenuPressed: () {
          _showMenuDrawer(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screen title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Waste management',
                  style: AppTheme.h2.copyWith(
                    color: const Color(0xFF333333),
                  ),
                ),
                // Date range button
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.lightNeutral200,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Date range',
                        style: AppTheme.pStrong.copyWith(
                          color: const Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Color(0xFF333333),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Tab navigation would go here
            // Add your tabs: Bin collection data, Monitoring service, etc.
            
            // Content sections based on the design
            _buildBinsInformation(),
            const SizedBox(height: 24),
            _buildCompliance(),
            const SizedBox(height: 24),
            _buildBinsCollectionData(),
          ],
        ),
      ),
    );
  }

  Widget _buildBinsInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bins information',
          style: AppTheme.h4.copyWith(
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                value: '2881',
                label: 'Bins deployed',
                color: AppTheme.green500,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                value: '221',
                label: 'Bins in stock',
                color: AppTheme.green500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          value: '221',
          label: 'Bins stolen / vandalised',
          color: AppTheme.green500,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppTheme.elevation9,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTheme.h2.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.pLight.copyWith(
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompliance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Compliance',
          style: AppTheme.h4.copyWith(
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: AppTheme.elevation9,
          ),
          child: Center(
            child: Column(
              children: [
                // Circular progress indicator would go here
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: CircularProgressIndicator(
                            value: 0.61,
                            strokeWidth: 12,
                            backgroundColor: AppTheme.lightNeutral200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.green500,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '89/145',
                              style: AppTheme.pLight.copyWith(
                                color: const Color(0xFF666666),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '61%',
                              style: AppTheme.h2.copyWith(
                                color: AppTheme.green500,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBinsCollectionData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bins collection data',
          style: AppTheme.h4.copyWith(
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                value: '38',
                label: 'Bins collected today',
                color: AppTheme.blue500,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                value: '16.3',
                label: 'Bins collected per truck',
                color: AppTheme.blue500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          value: '19.1',
          label: 'Avg. collected per day',
          color: AppTheme.blue500,
        ),
      ],
    );
  }

  void _showMenuDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Menu', style: AppTheme.h2),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // Add logout logic
              },
            ),
          ],
        ),
      ),
    );
  }
}*/
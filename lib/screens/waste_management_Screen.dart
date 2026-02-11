import 'package:flutter/material.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:iungo_application/theme/app_colors.dart';
import 'package:iungo_application/Business-Logic/waste_management_provider.dart';
import 'package:iungo_application/widgets/custom_appbar_widget.dart';
import 'package:iungo_application/widgets/custom_tab_bar_widget.dart';
import 'package:iungo_application/widgets/date_range_picker_widget.dart';
import 'package:iungo_application/widgets/multi_line_chart_cwidget.dart';
import 'package:iungo_application/widgets/section_header_widget.dart';
import 'package:iungo_application/widgets/star_card_widget.dart';
import 'package:iungo_application/widgets/circular_compliance_widget.dart';
import 'package:iungo_application/widgets/line_chart_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WasteManagementScreen extends StatelessWidget {
  const WasteManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WasteManagementProvider(),
      child: Consumer<WasteManagementProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: CustomAppBar(
              onMenuPressed: () {
                _showMenuDrawer(context);
              },
            ),
            body: Column(
              children: [
                // Title and Date Range
                _buildHeader(context, provider),

                // Tab Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTabBar(
                    tabs: _getTabs(),
                    selectedIndex: provider.selectedTabIndex,
                    onTabSelected: provider.selectTab,
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: _buildTabContent(provider),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WasteManagementProvider provider) {
    final dateRangeText = provider.selectedDateRange == null
        ? 'Date range'
        : '${DateFormat('MMM d, yyyy').format(provider.selectedDateRange!.start)} - ${DateFormat('MMM d, yyyy').format(provider.selectedDateRange!.end)}';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'Waste management',
              style: AppTheme.h2.copyWith(
                fontSize: 26,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
                height: 32 / 26,
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _selectDateRange(context, provider),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      dateRangeText,
                      style: AppTheme.pStrong.copyWith(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TabItem> _getTabs() {
    return [
      TabItem(title: 'Bin collection data'),
      TabItem(title: 'Monitoring service'),
      TabItem(title: 'Fleet efficiency'),
      TabItem(title: 'Weighing details', comingSoon: true),
    ];
  }

  Future<void> _selectDateRange(
    BuildContext context,
    WasteManagementProvider provider,
  ) async {
    final result = await showCustomDateRangePicker(
      context: context,
      initialDateRange: provider.selectedDateRange,
    );

    if (result != null) {
      provider.setDateRange(result);
    }
  }

  Widget _buildTabContent(WasteManagementProvider provider) {
    switch (provider.selectedTabIndex) {
      case 0:
        return _buildBinCollectionDataTab(provider);
      case 1:
        return _buildMonitoringServiceTab();
      case 2:
        return _buildFleetEfficiencyTab();
      default:
        return const SizedBox();
    }
  }

  Widget _buildBinCollectionDataTab(WasteManagementProvider provider) {
    final data = provider.getBinCollectionData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bins information
        const SectionHeader(title: 'Bins information'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatCard(
                value: data['binsDeployed'],
                label: 'Bins deployed',
                valueColor: AppColors.teal,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StatCard(
                value: data['binsInStock'],
                label: 'Bins in stock',
                valueColor: AppColors.teal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        StatCard(
          value: data['binsStolenVandalised'],
          label: 'Bins stolen / vandalised',
          valueColor: AppColors.teal,
          isFullWidth: true,
        ),
        const SizedBox(height: 24),

        // Compliance
        const SectionHeader(title: 'Compliance'),
        const SizedBox(height: 16),
        CircularComplianceWidget(
          completed: data['complianceCompleted'],
          total: data['complianceTotal'],
          progressColor: AppColors.teal,
        ),
        const SizedBox(height: 24),

        // Bins collection data
        const SectionHeader(title: 'Bins collection data'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatCard(
                value: data['binsCollectedToday'],
                label: 'Bins collected today',
                valueColor: AppColors.chartBlue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StatCard(
                value: data['binsCollectedPerTruck'],
                label: 'Bins collected per truck',
                valueColor: AppColors.chartBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        StatCard(
          value: data['avgCollectedPerDay'],
          label: 'Avg. collected per day',
          valueColor: AppColors.chartBlue,
          isFullWidth: true,
        ),
        const SizedBox(height: 24),

        // Bins washing data
        const SectionHeader(title: 'Bins washing data'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatCard(
                value: data['binsWashed'],
                label: 'Bins washed',
                valueColor: AppColors.chartBlue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StatCard(
                value: data['avgBinsWashedPerTruck'],
                label: 'Avg. bins washed per truck',
                valueColor: AppColors.chartBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Bins collected per day chart
        LineChartWidget(
          title: 'Bins collected per day',
          lineColor: AppColors.chartPurple,
          fillColor: AppColors.chartPurpleLight,
          data: provider.getBinsCollectedPerDayData(),
        ),
        const SizedBox(height: 24),

        // Refuse collection truck efficiency chart
        LineChartWidget(
          title: 'Refuse collection truck efficiency',
          lineColor: AppColors.chartRed,
          fillColor: AppColors.chartRedLight,
          data: provider.getTruckEfficiencyData(),
        ),
        const SizedBox(height: 24),

        // Bins washed per day chart
        LineChartWidget(
          title: 'Bins washed per day',
          lineColor: AppColors.chartGreen,
          fillColor: AppColors.chartGreenLight,
          data: provider.getBinsWashedPerDayData(),
        ),
        const SizedBox(height: 24),

        // Work orders issued multi-line chart
        _buildWorkOrdersChart(provider),
        const SizedBox(height: 24),

        // Map placeholder (Work orders issued map)
        _buildMapPlaceholder(),
      ],
    );
  }

  Widget _buildWorkOrdersChart(WasteManagementProvider provider) {
    final workOrdersData = provider.getWorkOrdersData();
    final lines = <ChartLine>[];

    for (var lineData in workOrdersData['lines']) {
      Color color;
      switch (lineData['color']) {
        case 'gray':
          color = AppColors.chartGray;
          break;
        case 'green':
          color = AppColors.chartGreen;
          break;
        case 'red':
          color = AppColors.chartRed;
          break;
        case 'blue':
          color = AppColors.blue500;
          break;
        default:
          color = AppColors.chartGray;
      }

      lines.add(
        ChartLine(
          label: lineData['label'],
          data: (lineData['data'] as List)
              .map((e) => e is int ? e.toDouble() : e as double)
              .toList(),
          color: color,
        ),
      );
    }

    return MultiLineChartWidget(
      title: 'Work orders issued',
      xLabels: List<String>.from(workOrdersData['xLabels']),
      infoIcon: const Icon(
        Icons.info_outline,
        size: 16,
        color: AppColors.textSecondary,
      ),
      lines: lines,
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
        color: AppColors.backgroundLight,
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
                  color: AppColors.textDisabled,
                ),
                const SizedBox(height: 16),
                Text(
                  'Work orders issued',
                  style: AppTheme.h4.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Map integration coming soon',
                  style: AppTheme.pLight.copyWith(
                    color: AppColors.textDisabled,
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
        color: AppColors.mapButtonBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, color: AppColors.white, size: 20),
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
import 'package:iungo_application/widgets/custom_tab_bar_widget.dart';
import 'package:iungo_application/widgets/date_range_picker_widget.dart';
import 'package:iungo_application/widgets/multi_line_chart_cwidget.dart';
import 'package:iungo_application/widgets/section_header_widget.dart';
import 'package:iungo_application/widgets/star_card_widget.dart';
import 'package:iungo_application/widgets/circular_compliance_widget.dart';
import 'package:iungo_application/widgets/line_chart_widget.dart';
import 'package:intl/intl.dart';

class WasteManagementScreen extends StatefulWidget {
  const WasteManagementScreen({super.key});

  @override
  State<WasteManagementScreen> createState() => _WasteManagementScreenState();
}

class _WasteManagementScreenState extends State<WasteManagementScreen> {
  int _selectedTabIndex = 0;
  DateTimeRange? _selectedDateRange;

  final List<TabItem> _tabs = [
    TabItem(title: 'Bin collection data'),
    TabItem(title: 'Monitoring service'),
    TabItem(title: 'Fleet efficiency'),
    TabItem(title: 'Weighing details', comingSoon: true),
  ];

  String get _dateRangeText {
    if (_selectedDateRange == null) return 'Date range';
    final format = DateFormat('MMM d, yyyy');
    return '${format.format(_selectedDateRange!.start)} - ${format.format(_selectedDateRange!.end)}';
  }

  Future<void> _selectDateRange() async {
    final result = await showCustomDateRangePicker(
      context: context,
      initialDateRange: _selectedDateRange,
    );

    if (result != null) {
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

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
                  onTap: _selectDateRange,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _dateRangeText,
                          style: AppTheme.pStrong.copyWith(
                            fontSize: 12,
                            color: const Color(0xFF333333),
                            fontWeight: FontWeight.w400,
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
                valueColor: Color(0xFF66B29B), // Exact Figma color
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: StatCard(
                value: '221',
                label: 'Bins in stock',
                valueColor: Color(0xFF66B29B), // Exact Figma color
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const StatCard(
          value: '221',
          label: 'Bins stolen / vandalised',
          valueColor: Color(0xFF66B29B), // Exact Figma color
          isFullWidth: true,
        ),
        const SizedBox(height: 24),

        // Compliance
        const SectionHeader(title: 'Compliance'),
        const SizedBox(height: 16),
        const CircularComplianceWidget(
          completed: 89,
          total: 145,
          progressColor: Color(0xFF66B29B), // Exact Figma color
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
                valueColor: Color(0xFF3F79AD), // Exact Figma Blue
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: StatCard(
                value: '16.3',
                label: 'Bins collected per truck',
                valueColor: Color(0xFF3F79AD), // Exact Figma Blue
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const StatCard(
          value: '19.1',
          label: 'Avg. collected per day',
          valueColor: Color(0xFF3F79AD), // Exact Figma Blue
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
                valueColor: Color(0xFF3F79AD), // Exact Figma Blue
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: StatCard(
                value: '18.5',
                label: 'Avg. bins washed per truck',
                valueColor: Color(0xFF3F79AD), // Exact Figma Blue
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
*/
  /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Scroll to top or other action
        },
        backgroundColor: AppTheme.primaryPurple,
        child: const Icon(Icons.keyboard_arrow_up, color: AppTheme.white),
      ),*/
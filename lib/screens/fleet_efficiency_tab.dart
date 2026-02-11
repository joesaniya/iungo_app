import 'package:flutter/material.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:iungo_application/theme/app_colors.dart';
import 'package:iungo_application/Business-Logic/waste_management_provider.dart';
import 'package:provider/provider.dart';

class FleetEfficiencyTab extends StatelessWidget {
  const FleetEfficiencyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WasteManagementProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder content
              _buildPlaceholderContent(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Icon(
            Icons.local_shipping_outlined,
            size: 80,
            color: AppColors.textDisabled,
          ),
          const SizedBox(height: 24),
          Text(
            'Fleet Efficiency',
            style: AppTheme.h3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Content coming soon',
            style: AppTheme.pLight.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This section will include:',
                  style: AppTheme.h5Strong.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildFeatureItem('Vehicle performance metrics'),
                _buildFeatureItem('Fuel consumption analysis'),
                _buildFeatureItem('Route optimization data'),
                _buildFeatureItem('Maintenance schedules'),
                _buildFeatureItem('Driver efficiency reports'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: AppColors.success,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTheme.pStrong.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
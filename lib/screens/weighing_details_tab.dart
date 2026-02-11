import 'package:flutter/material.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:iungo_application/theme/app_colors.dart';
import 'package:iungo_application/Business-Logic/waste_management_provider.dart';
import 'package:provider/provider.dart';

class WeighingDetailsTab extends StatelessWidget {
  const WeighingDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WasteManagementProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coming soon content
              _buildComingSoonContent(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildComingSoonContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.scale_outlined,
              size: 60,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'COMING SOON',
              style: AppTheme.minimal.copyWith(
                color: AppColors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Weighing Details',
            style: AppTheme.h3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Advanced weighing analytics and reporting features are currently under development',
              textAlign: TextAlign.center,
              style: AppTheme.pLight.copyWith(
                color: AppColors.textSecondary,
              ),
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
                  'Upcoming features:',
                  style: AppTheme.h5Strong.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildFeatureItem('Automated weight tracking'),
                _buildFeatureItem('Weight distribution analytics'),
                _buildFeatureItem('Load optimization insights'),
                _buildFeatureItem('Compliance reporting'),
                _buildFeatureItem('Historical weight data'),
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
            Icons.schedule,
            size: 16,
            color: AppColors.warning,
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
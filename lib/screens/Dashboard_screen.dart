import 'package:flutter/material.dart';
import 'package:iungo_application/Business-Logic/Dashboard_provider.dart';
import 'package:iungo_application/Business-Logic/auth_provider.dart';
import 'package:iungo_application/screens/login_screen.dart';
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
            appBar: AppBar(
              backgroundColor: AppTheme.primaryPurple,
              title: const Text(
                'Dashboard',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () async {
                    final authProvider = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );
                    await authProvider.logout();

                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                ),
              ],
            ),
            body: dashboardProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryPurple,
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: AppTheme.elevation9,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: AppTheme.pLight.copyWith(
                                  color: AppTheme.gray,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                dashboardProvider.userName,
                                style: AppTheme.h2.copyWith(
                                  color: AppTheme.primaryPurple,
                                ),
                              ),
                              if (dashboardProvider.userType.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryPurple.withOpacity(
                                      0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    dashboardProvider.userType,
                                    style: AppTheme.pLight.copyWith(
                                      color: AppTheme.primaryPurple,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // User Information Section
                        Text(
                          'Account Details',
                          style: AppTheme.h2.copyWith(
                            color: AppTheme.primaryPurple,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: AppTheme.elevation9,
                          ),
                          child: Column(
                            children: [
                              _buildInfoRow(
                                'User ID',
                                dashboardProvider.userId,
                              ),
                              const Divider(height: 24),
                              _buildInfoRow(
                                'Username',
                                dashboardProvider.userName,
                              ),
                              const Divider(height: 24),
                              _buildInfoRow(
                                'Email',
                                dashboardProvider.userEmail,
                              ),
                              const Divider(height: 24),
                              _buildInfoRow('Role', dashboardProvider.userType),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: AppTheme.pLight.copyWith(
              color: AppTheme.gray,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value.isEmpty ? '-' : value,
            style: AppTheme.pLight.copyWith(color: AppTheme.primaryPurple),
          ),
        ),
      ],
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:iungo_application/Business-Logic/Dashboard_provider.dart';
import 'package:iungo_application/Business-Logic/auth_provider.dart';
import 'package:iungo_application/screens/login_screen.dart';
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
            appBar: AppBar(
              backgroundColor: AppTheme.primaryPurple,
              title: const Text(
                'Dashboard',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () async {
                    final authProvider = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );
                    await authProvider.logout();

                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                ),
              ],
            ),
            body: dashboardProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryPurple,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: AppTheme.elevation9,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: AppTheme.pLight.copyWith(
                                  color: AppTheme.gray,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                dashboardProvider.userName,
                                style: AppTheme.h2.copyWith(
                                  color: AppTheme.primaryPurple,
                                ),
                              ),
                              if (dashboardProvider.userEmail.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  dashboardProvider.userEmail,
                                  style: AppTheme.pLight.copyWith(
                                    color: AppTheme.gray,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // User Info Section
                        Text(
                          'User Information',
                          style: AppTheme.h2.copyWith(
                            color: AppTheme.primaryPurple,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Display all user data
                        if (dashboardProvider.userData != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: AppTheme.elevation9,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: dashboardProvider.userData!.entries.map(
                                (entry) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          child: Text(
                                            '${entry.key}:',
                                            style: AppTheme.pLight.copyWith(
                                              color: AppTheme.gray,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            entry.value.toString(),
                                            style: AppTheme.pLight.copyWith(
                                              color: AppTheme.primaryPurple,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
*/

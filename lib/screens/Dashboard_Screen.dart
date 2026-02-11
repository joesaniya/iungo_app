import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iungo_application/Business-Logic/Dashboard_provider.dart';
import 'package:iungo_application/Business-Logic/auth_provider.dart';
import 'package:iungo_application/models/menu_item.dart';
import 'package:iungo_application/screens/login_screen.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:iungo_application/widgets/client_selector.dart';
import 'package:iungo_application/widgets/custom_menu_icon.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, _) {
          final accessibleMenus = MenuConfig.getAccessibleMenus(
            dashboardProvider.empAccessPages,
          );
          return Scaffold(
            backgroundColor: AppTheme.white,
            appBar: AppBar(
              backgroundColor: AppTheme.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/images/iungo-logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              title: const ClientSelector(),
              actions: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg-icons/menu.svg',
                    width: 20,
                    height: 17.33,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF354252),
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    _showMenuDrawer(context, dashboardProvider);
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
                        // Title
                        Text(
                          'Choose the dashboard you want to preview',
                          style: AppTheme.h3.copyWith(
                            color: const Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Menu Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1.0,
                              ),
                          itemCount: accessibleMenus.length,
                          itemBuilder: (context, index) {
                            return _buildMenuCard(
                              context,
                              accessibleMenus[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, MenuItem menuItem) {
    return GestureDetector(
      onTap: menuItem.comingSoon
          ? null
          : () {
              Navigator.pushNamed(context, menuItem.route);
            },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppTheme.elevation9,
        ),
        child: Stack(
          children: [
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Custom Icon
                  CustomMenuIcon(
                    menuId: menuItem.id,
                    color: menuItem.color,
                    size: 56,
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    menuItem.title,
                    textAlign: TextAlign.center,
                    style: AppTheme.h4.copyWith(
                      color: menuItem.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            // Coming Soon badge
            if (menuItem.comingSoon)
              Positioned(
                top: 12,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF81C784),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Coming Soon',
                      style: AppTheme.minimal.copyWith(
                        color: AppTheme.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showMenuDrawer(BuildContext context, DashboardProvider provider) {
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
              onTap: () async {
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
      ),
    );
  }
}/*import 'package:flutter/material.dart';
import 'package:iungo_application/Business-Logic/Dashboard_provider.dart';
import 'package:iungo_application/Business-Logic/auth_provider.dart';
import 'package:iungo_application/models/menu_item.dart';
import 'package:iungo_application/screens/login_screen.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:iungo_application/widgets/client_selector.dart';
import 'package:iungo_application/widgets/custom_menu_icon.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, _) {
          final accessibleMenus = MenuConfig.getAccessibleMenus(
            dashboardProvider.empAccessPages,
          );
          return Scaffold(
            backgroundColor: AppTheme.white,
            appBar: AppBar(
              backgroundColor: AppTheme.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/images/iungo-logo.png', // Your infinity logo
                  fit: BoxFit.contain,
                ),
              ),
              title: const ClientSelector(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.menu, color: Color(0xFF333333)),
                  onPressed: () {
                    _showMenuDrawer(context, dashboardProvider);
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
                        // Title
                        Text(
                          'Choose the dashboard you want to preview',
                          style: AppTheme.h3.copyWith(
                            color: const Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Menu Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1.0,
                              ),
                          itemCount: accessibleMenus.length,
                          itemBuilder: (context, index) {
                            return _buildMenuCard(
                              context,
                              accessibleMenus[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          );
          /*    return Scaffold(
            backgroundColor: AppTheme.white,
            appBar: AppBar(
              backgroundColor: AppTheme.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/images/iungo-logo.png', // Your infinity logo
                  fit: BoxFit.contain,
                ),
              ),
              title: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.lightNeutral200),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Tap to select client',
                      style: AppTheme.h5Light.copyWith(
                        color: AppTheme.gray,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppTheme.gray,
                      size: 20,
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.menu, color: Color(0xFF333333)),
                  onPressed: () {
                    _showMenuDrawer(context, dashboardProvider);
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
                        // Title
                        Text(
                          'Choose the dashboard you want to preview',
                          style: AppTheme.h3.copyWith(
                            color: const Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Menu Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1.0,
                              ),
                          itemCount: accessibleMenus.length,
                          itemBuilder: (context, index) {
                            return _buildMenuCard(
                              context,
                              accessibleMenus[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          );
     */
        },
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, MenuItem menuItem) {
    return GestureDetector(
      onTap: menuItem.comingSoon
          ? null
          : () {
              Navigator.pushNamed(context, menuItem.route);
            },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppTheme.elevation9,
        ),
        child: Stack(
          children: [
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Custom Icon
                  CustomMenuIcon(
                    menuId: menuItem.id,
                    color: menuItem.color,
                    size: 56,
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    menuItem.title,
                    textAlign: TextAlign.center,
                    style: AppTheme.h4.copyWith(
                      color: menuItem.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            // Coming Soon badge
            if (menuItem.comingSoon)
              Positioned(
                top: 12,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF81C784),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Coming Soon',
                      style: AppTheme.minimal.copyWith(
                        color: AppTheme.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showMenuDrawer(BuildContext context, DashboardProvider provider) {
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
              onTap: () async {
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
      ),
    );
  }
}

/* Widget _buildMenuCard(BuildContext context, MenuItem menuItem) {
    return GestureDetector(
      onTap: menuItem.comingSoon
          ? null
          : () {
              Navigator.pushNamed(context, menuItem.route);
            },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppTheme.elevation9,
        ),
        child: Stack(
          children: [
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Custom Icon
                  CustomMenuIcon(
                    menuId: menuItem.id,
                    color: menuItem.color,
                    size: 56,
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    menuItem.title,
                    textAlign: TextAlign.center,
                    style: AppTheme.h4.copyWith(
                      color: menuItem.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            // Coming Soon badge
            if (menuItem.comingSoon)
              Positioned(
                top: 12,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF81C784),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Coming Soon',
                      style: AppTheme.minimal.copyWith(
                        color: AppTheme.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showMenuDrawer(BuildContext context, DashboardProvider provider) {
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
              onTap: () async {
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
      ),
    );
  }
}*/
*/
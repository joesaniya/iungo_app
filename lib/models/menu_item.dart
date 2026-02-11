import 'package:flutter/material.dart';
import 'package:iungo_application/screens/waste_mangemt_screen_simple.dart';
import 'package:iungo_application/theme/app_colors.dart';

class MenuItem {
  final String id;
  final String title;
  final Color color;
  final String? route;
  final Widget? screen;
  final bool comingSoon;

  MenuItem({
    required this.id,
    required this.title,
    required this.color,
    this.route,
    this.screen,
    this.comingSoon = false,
  });

  // Navigate to the screen
  void navigate(BuildContext context) {
    if (comingSoon) return;

    // Prefer direct screen navigation over routes for better error handling
    if (screen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen!));
    } else if (route != null) {
      // Use pushNamed with error handling
      Navigator.pushNamed(context, route!).catchError((error) {
        // Handle navigation error
        debugPrint('Navigation error: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Route not found: $route'),
            backgroundColor: AppColors.error,
          ),
        );
        return null;
      });
    }
  }
}

class MenuConfig {
  // Using centralized color from AppColors
  static const Color menuColor = AppColors.primaryPurple;

  static final Map<String, MenuItem> menuItems = {
    '1': MenuItem(
      id: '1',
      title: 'Contract\nperformance',
      color: menuColor,
      route: '/contract-performance',
    ),
    '2': MenuItem(
      id: '2',
      title: 'Waste\nmanagement',
      color: menuColor,
      screen: WasteManagementScreen(),
      // screen: const WasteManagementScreen(),
    ),
    '3': MenuItem(
      id: '3',
      title: 'Cleaning',
      color: menuColor,
      route: '/cleaning',
    ),
    '4': MenuItem(
      id: '4',
      title: 'Compliance',
      color: menuColor,
      route: '/compliance',
    ),
    '5': MenuItem(
      id: '5',
      title: 'Technical',
      color: menuColor,
      route: '/technical-services',
    ),
    '6': MenuItem(
      id: '6',
      title: 'Spaces',
      color: menuColor,
      route: '/spaces',
      comingSoon: true,
    ),
    '7': MenuItem(
      id: '7',
      title: 'Wellbeing',
      color: menuColor,
      route: '/wellbeing',
      comingSoon: true,
    ),
  };

  static List<MenuItem> getAccessibleMenus(List<String> accessPages) {
    return accessPages
        .where((pageId) => menuItems.containsKey(pageId))
        .map((pageId) => menuItems[pageId]!)
        .toList();
  }
}/*import 'package:flutter/material.dart';
import 'package:iungo_application/screens/waste_management_screen.dart';

class MenuItem {
  final String id;
  final String title;
  final Color color;
  final String? route;
  final Widget? screen;
  final bool comingSoon;

  MenuItem({
    required this.id,
    required this.title,
    required this.color,
    this.route,
    this.screen,
    this.comingSoon = false,
  });

  // Navigate to the screen
  void navigate(BuildContext context) {
    if (comingSoon) return;
    
    if (screen != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen!),
      );
    } else if (route != null) {
      Navigator.pushNamed(context, route!);
    }
  }
}

class MenuConfig {
  // Using the exact purple color from design
  static const Color menuPurple = Color(0xFF5D2E5F);

  static final Map<String, MenuItem> menuItems = {
    '1': MenuItem(
      id: '1',
      title: 'Contract\nperformance',
      color: menuPurple,
      route: '/contract-performance',
    ),
    '2': MenuItem(
      id: '2',
      title: 'Waste\nmanagement',
      color: menuPurple,
      screen: const WasteManagementScreen(),
    ),
    '3': MenuItem(
      id: '3',
      title: 'Cleaning',
      color: menuPurple,
      route: '/cleaning',
    ),
    '4': MenuItem(
      id: '4',
      title: 'Compliance',
      color: menuPurple,
      route: '/compliance',
    ),
    '5': MenuItem(
      id: '5',
      title: 'Technical',
      color: menuPurple,
      route: '/technical-services',
    ),
    '6': MenuItem(
      id: '6',
      title: 'Spaces',
      color: menuPurple,
      route: '/spaces',
      comingSoon: true,
    ),
    '7': MenuItem(
      id: '7',
      title: 'Wellbeing',
      color: menuPurple,
      route: '/wellbeing',
      comingSoon: true,
    ),
  };

  static List<MenuItem> getAccessibleMenus(List<String> accessPages) {
    return accessPages
        .where((pageId) => menuItems.containsKey(pageId))
        .map((pageId) => menuItems[pageId]!)
        .toList();
  }
}
*/

// import 'package:flutter/material.dart';

// class MenuItem {
//   final String id;
//   final String title;
//   final Color color;
//   final String route;
//   final bool comingSoon;

//   MenuItem({
//     required this.id,
//     required this.title,
//     required this.color,
//     required this.route,
//     this.comingSoon = false,
//   });
// }

// class MenuConfig {
//   // Using the exact purple color from design
//   static const Color menuPurple = Color(0xFF5D2E5F);

//   static final Map<String, MenuItem> menuItems = {
//     '1': MenuItem(
//       id: '1',
//       title: 'Contract\nperformance',
//       color: menuPurple,
//       route: '/contract-performance',
//     ),
//     '2': MenuItem(
//       id: '2',
//       title: 'Waste\nmanagement',
//       color: menuPurple,
//       route: '/waste-management',
//     ),
//     '3': MenuItem(
//       id: '3',
//       title: 'Cleaning',
//       color: menuPurple,
//       route: '/cleaning',
//     ),
//     '4': MenuItem(
//       id: '4',
//       title: 'Compliance',
//       color: menuPurple,
//       route: '/compliance',
//     ),
//     '5': MenuItem(
//       id: '5',
//       title: 'Technical',
//       color: menuPurple,
//       route: '/technical-services',
//     ),
//     '6': MenuItem(
//       id: '6',
//       title: 'Spaces',
//       color: menuPurple,
//       route: '/spaces',
//       comingSoon: true,
//     ),
//     '7': MenuItem(
//       id: '7',
//       title: 'Wellbeing',
//       color: menuPurple,
//       route: '/wellbeing',
//       comingSoon: true,
//     ),
//   };

//   static List<MenuItem> getAccessibleMenus(List<String> accessPages) {
//     return accessPages
//         .where((pageId) => menuItems.containsKey(pageId))
//         .map((pageId) => menuItems[pageId]!)
//         .toList();
//   }
// }
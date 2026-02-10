import 'package:flutter/material.dart';

class MenuItem {
  final String id;
  final String title;
  final Color color;
  final String route;
  final bool comingSoon;

  MenuItem({
    required this.id,
    required this.title,
    required this.color,
    required this.route,
    this.comingSoon = false,
  });
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
      route: '/waste-management',
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
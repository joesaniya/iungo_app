import 'package:flutter/material.dart';
import 'package:iungo_application/theme/app_theme.dart';

class CustomTabBar extends StatelessWidget {
  final List<TabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final isSelected = index == selectedIndex;
            final isComingSoon = tab.comingSoon;

            return GestureDetector(
              onTap: isComingSoon ? null : () => onTabSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? AppTheme.primaryPurple
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tab.title,
                      style: AppTheme.h5Strong.copyWith(
                        fontSize: 14,
                        color: isSelected
                            ? AppTheme.primaryPurple
                            : const Color(0xFF666666),
                        fontWeight: isSelected
                            ? FontWeight.w500
                            : FontWeight.w400,
                        height: 20 / 14,
                      ),
                    ),
                    if (isComingSoon) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF81C784),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          'Coming Soon',
                          style: AppTheme.minimal.copyWith(
                            fontSize: 8,
                            color: AppTheme.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class TabItem {
  final String title;
  final bool comingSoon;

  TabItem({required this.title, this.comingSoon = false});
}


/*import 'package:flutter/material.dart';
import 'package:iungo_application/theme/app_theme.dart';

class CustomTabBar extends StatelessWidget {
  final List<TabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == selectedIndex;
          final isComingSoon = tab.comingSoon;

          return Expanded(
            child: GestureDetector(
              onTap: isComingSoon ? null : () => onTabSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? AppTheme.primaryPurple
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        tab.title,
                        textAlign: TextAlign.center,
                        style: AppTheme.h5Strong.copyWith(
                          fontSize: 14,
                          color: isSelected
                              ? AppTheme.primaryPurple
                              : const Color(0xFF666666),
                          fontWeight: isSelected
                              ? FontWeight.w500
                              : FontWeight.w400,
                          height: 20 / 14,
                        ),
                      ),
                    ),
                    if (isComingSoon) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF81C784),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          'Coming Soon',
                          style: AppTheme.minimal.copyWith(
                            fontSize: 8,
                            color: AppTheme.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class TabItem {
  final String title;
  final bool comingSoon;

  TabItem({
    required this.title,
    this.comingSoon = false,
  });
}*/
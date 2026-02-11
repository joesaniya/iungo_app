import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:iungo_application/widgets/client_selector.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;
  final bool showClientSelector;
  final Widget? customCenter;
  final List<Widget>? additionalActions;

  const CustomAppBar({
    super.key,
    this.onMenuPressed,
    this.showClientSelector = true,
    this.customCenter,
    this.additionalActions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(
          'assets/images/iungo-logo.png',
          fit: BoxFit.contain,
        ),
      ),
      title: customCenter ?? 
             (showClientSelector ? const ClientSelector() : null),
      centerTitle: false,
      actions: [
        // Additional actions if provided
        if (additionalActions != null) ...additionalActions!,
        
        // Menu icon
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
          onPressed: onMenuPressed,
        ),
      ],
    );
  }
}
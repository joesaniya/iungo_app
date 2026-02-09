import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum ButtonSize { large, medium, small }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonSize size;
  final bool isLoading;
  final bool hasDropdown;
  final bool isOutlined;
  
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.size = ButtonSize.large,
    this.isLoading = false,
    this.hasDropdown = false,
    this.isOutlined = false,
  }) : super(key: key);
  
  double _getHeight() {
    switch (size) {
      case ButtonSize.large:
        return 48;
      case ButtonSize.medium:
        return 40;
      case ButtonSize.small:
        return 32;
    }
  }
  
  double _getFontSize() {
    switch (size) {
      case ButtonSize.large:
        return 16;
      case ButtonSize.medium:
        return 14;
      case ButtonSize.small:
        return 12;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width * 0.053; // ~20px on 375px width
    
    return Container(
      width: double.infinity,
      height: _getHeight(),
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? AppTheme.white : AppTheme.primaryPurple,
          foregroundColor: isOutlined ? AppTheme.primaryPurple : AppTheme.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isOutlined 
                ? const BorderSide(color: AppTheme.primaryPurple, width: 1)
                : BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.getResponsiveSize(context, 24),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isOutlined ? AppTheme.primaryPurple : AppTheme.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (hasDropdown)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.add_circle_outline, size: 18),
                    ),
                  Flexible(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: _getFontSize(),
                        fontWeight: FontWeight.w500,
                        color: isOutlined ? AppTheme.primaryPurple : AppTheme.white,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (hasDropdown)
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.keyboard_arrow_down, size: 18),
                    ),
                ],
              ),
      ),
    );
  }
}

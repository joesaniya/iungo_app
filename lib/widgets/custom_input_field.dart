import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String placeholder;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onToggleVisibility;
  final Function(String) onChanged;
  final String? initialValue;
  final TextInputType? keyboardType;

  const CustomInputField({
    Key? key,
    required this.label,
    required this.placeholder,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onToggleVisibility,
    required this.onChanged,
    this.initialValue,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width * 0.053;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: horizontalPadding, bottom: 6),
          child: Text(widget.label, style: AppTheme.inputLabel),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.lightNeutral200, width: 1),
          ),
          child: TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            obscureText: widget.isPassword && !widget.isPasswordVisible,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            style: AppTheme.h5Strong.copyWith(color: AppTheme.black),
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: AppTheme.h5Light.copyWith(color: AppTheme.gray),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppTheme.getResponsiveSize(context, 16),
                vertical: AppTheme.getResponsiveSize(context, 14),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        widget.isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppTheme.gray,
                        size: 20,
                      ),
                      onPressed: widget.onToggleVisibility,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}/*import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onToggleVisibility;
  final Function(String) onChanged;
  final String? initialValue;
  final TextInputType? keyboardType;
  
  const CustomInputField({
    Key? key,
    required this.label,
    required this.placeholder,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onToggleVisibility,
    required this.onChanged,
    this.initialValue,
    this.keyboardType,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width * 0.053; // ~20px on 375px width
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: horizontalPadding, bottom: 6),
          child: Text(
            label,
            style: AppTheme.inputLabel,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.lightNeutral200,
              width: 1,
            ),
          ),
          child: TextField(
            onChanged: onChanged,
            obscureText: isPassword && !isPasswordVisible,
            keyboardType: keyboardType ?? TextInputType.text,
            style: AppTheme.h5Strong.copyWith(color: AppTheme.black),
            controller: initialValue != null 
                ? TextEditingController(text: initialValue)
                : null,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: AppTheme.h5Light.copyWith(
                color: AppTheme.gray,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppTheme.getResponsiveSize(context, 16),
                vertical: AppTheme.getResponsiveSize(context, 14),
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppTheme.gray,
                        size: 20,
                      ),
                      onPressed: onToggleVisibility,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
*/
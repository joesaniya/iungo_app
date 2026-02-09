import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Business-Logic/auth_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetPasswordScreen2 extends StatelessWidget {
  const SetPasswordScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.lightNeutral100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height - MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                SizedBox(height: height * 0.04),

                // Logo
                Image.asset(
                  'assets/images/iungo-logo.png',
                  width: 139.17.w,
                  height: 150.h,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: height * 0.05),

                // Set Password Card
                Container(
                  width: width * 0.894,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.053),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: AppTheme.elevation9,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Welcome to Iungo title
                          Column(
                            children: [
                              Text(
                                'Welcome to Iungo',
                                style: AppTheme.h2.copyWith(
                                  color: AppTheme.primaryPurple,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Please set a password for your account',
                                style: AppTheme.pLight.copyWith(
                                  color: AppTheme.gray,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: height * 0.03),

                          // Email Input (read-only/display)
                          CustomInputField(
                            label: 'Email',
                            placeholder: 'Type your email here',
                            onChanged: authProvider.setEmail,
                            keyboardType: TextInputType.emailAddress,
                            initialValue: authProvider.email,
                          ),

                          SizedBox(height: height * 0.02),

                          // Password Input
                          CustomInputField(
                            label: 'Password',
                            placeholder: 'Enter your password here',
                            isPassword: true,
                            isPasswordVisible: authProvider.isPasswordVisible,
                            onToggleVisibility:
                                authProvider.togglePasswordVisibility,
                            onChanged: authProvider.setPassword,
                          ),

                          SizedBox(height: height * 0.02),

                          // Confirm Password Input
                          CustomInputField(
                            label: 'Confirm password',
                            placeholder: 'Re-enter your password',
                            isPassword: true,
                            isPasswordVisible: authProvider.isConfirmPasswordVisible,
                            onToggleVisibility:
                                authProvider.toggleConfirmPasswordVisibility,
                            onChanged: authProvider.setConfirmPassword,
                          ),

                          // Error Message
                          if (authProvider.errorMessage.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.053,
                                right: width * 0.053,
                                top: 8,
                              ),
                              child: Text(
                                authProvider.errorMessage,
                                style: AppTheme.errorText,
                              ),
                            ),

                          SizedBox(height: height * 0.03),

                          // Set password button
                          CustomButton(
                            text: 'Set password',
                            onPressed: () async {
                             final success = await authProvider.submitSetPassword();
                              if (success && context.mounted) {
                                // Navigate to home or dashboard
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Password set successfully!'),
                                    backgroundColor: AppTheme.successGreen,
                                  ),
                                );
                              }
                            },
                            isLoading: authProvider.isLoading,
                          ),

                          SizedBox(height: height * 0.02),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
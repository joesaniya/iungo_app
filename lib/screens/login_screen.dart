import 'package:flutter/material.dart';
import 'package:iungo_application/screens/Profile_screen.dart';
import 'package:provider/provider.dart';
import '../Business-Logic/auth_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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

                // Login Card
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
                          // Welcome back title
                          Column(
                            children: [
                              Text(
                                'Welcome back',
                                style: AppTheme.h2.copyWith(
                                  color: AppTheme.primaryPurple,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Log in below to continue',
                                style: AppTheme.pLight.copyWith(
                                  color: AppTheme.gray,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: height * 0.03),

                          // Email Input
                          CustomInputField(
                            label: 'Email',
                            placeholder: 'Type your email here',
                            onChanged: authProvider.setEmail,
                            keyboardType: TextInputType.emailAddress,
                            hasError: authProvider.hasLoginError,
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
                            hasError: authProvider.hasLoginError,
                          ),

                          // Error Message
                          if (authProvider.errorMessage.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.053,
                                right: width * 0.053,
                                top: 8,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  authProvider.errorMessage,
                                  style: AppTheme.pLight.copyWith(
                                    color: AppTheme.errorRed,
                                  ),
                                ),
                              ),
                            ),

                          SizedBox(height: height * 0.03),

                          // Log in button
                          CustomButton(
                            text: 'Log in',
                            onPressed: () async {
                              final success = await authProvider.login();
                              if (success && context.mounted) {
                                // Navigate to Dashboard
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                            isLoading: authProvider.isLoading,
                          ),

                          /* CustomButton(
                            text: 'Log in',
                            onPressed: () async {
                              final success = await authProvider.login();
                              if (success && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login successful!'),
                                    backgroundColor: AppTheme.successGreen,
                                  ),
                                );
                              }
                            },
                            isLoading: authProvider.isLoading,
                          ),*/
                          SizedBox(height: height * 0.02),

                          // Forgot password link
                          Center(
                            child: TextButton(
                              onPressed: () {
                                authProvider.clearError();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot password?',
                                style: AppTheme.linkText,
                              ),
                            ),
                          ),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Business-Logic/auth_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

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
                // IungoLogo(size: width * 0.21),
                Image.asset(
                  'assets/images/iungo-logo.png',
                  width: 139.17.w,
                  height: 150.h,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: height * 0.05),

                // Forgot Password Card
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
                          // Forgot password title
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.053,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Forgot password?',
                                  style: AppTheme.h2.copyWith(
                                    color: AppTheme.primaryPurple,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'It happens to the best of us. Enter your email below and we\'ll send you a reset link.',
                                  style: AppTheme.pLight.copyWith(
                                    color: AppTheme.gray,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: height * 0.03),

                          // Email Input
                          CustomInputField(
                            label: 'Email',
                            placeholder: 'johndoe@email.com',
                            initialValue: 'johndoe@email.com',
                            onChanged: authProvider.setEmail,
                            keyboardType: TextInputType.emailAddress,
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

                          // Reset password button
                          CustomButton(
                            text: 'Reset password',
                            onPressed: () async {
                              final success = await authProvider
                                  .resetPassword();
                              if (success && context.mounted) {
                                Navigator.pushNamed(context, '/reset-password');
                              }
                            },
                            isLoading: authProvider.isLoading,
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

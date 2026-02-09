import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Business-Logic/auth_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/iungo_logo.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);
  
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
                // IungoLogo(size: width * 0.21),
                
                SizedBox(height: height * 0.05),
                
                // Set Password Card
                Expanded(
                  child: Container(
                    width: width * 0.894,
                    margin: EdgeInsets.symmetric(horizontal: width * 0.053),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppTheme.elevation9,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: height * 0.04,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Welcome to iungo title
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.053,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome to iungo',
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
                            ),
                            
                            SizedBox(height: height * 0.03),
                            
                            // Email Input (read-only)
                            CustomInputField(
                              label: 'Email',
                              placeholder: 'johndoe@email.com',
                              initialValue: 'johndoe@email.com',
                              onChanged: authProvider.setEmail,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            
                            SizedBox(height: height * 0.02),
                            
                            // Password Input
                            CustomInputField(
                              label: 'Password',
                              placeholder: '••••••••••••',
                              isPassword: true,
                              isPasswordVisible: authProvider.isPasswordVisible,
                              onToggleVisibility: authProvider.togglePasswordVisibility,
                              onChanged: authProvider.setPassword,
                            ),
                            
                            SizedBox(height: height * 0.02),
                            
                            // Confirm Password Input
                            CustomInputField(
                              label: 'Confirm password',
                              placeholder: '12345678',
                              isPassword: true,
                              isPasswordVisible: authProvider.isConfirmPasswordVisible,
                              onToggleVisibility: authProvider.toggleConfirmPasswordVisibility,
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
                                final success = await authProvider.setNewPassword();
                                if (success && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Password set successfully!'),
                                      backgroundColor: AppTheme.successGreen,
                                    ),
                                  );
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/login',
                                    (route) => false,
                                  );
                                }
                              },
                              isLoading: authProvider.isLoading,
                            ),
                          ],
                        ),
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

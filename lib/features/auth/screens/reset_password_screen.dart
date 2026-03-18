import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.lightGradient, // #EAF5FA to #F6FBFE
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Back arrow ───────────────────────────────────
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.deepBlue),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

              const Spacer(),

              // ── Main Content block centered vertically ───────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title + Graphic Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Reset\nPassword',
                                style: TextStyle(
                                  color: AppColors.deepBlue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Create a new, strong\npassword.",
                                style: TextStyle(
                                  color: AppColors.deepBlue,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _AvatarCard(),
                      ],
                    ),

                    const SizedBox(height: 50),

                    // Form
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'New password',
                        style: TextStyle(
                          color: AppColors.deepBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const CustomTextField(
                      hintText: 'Enter your new password',
                      isPassword: true,
                      withBorder: true,
                    ),

                    const SizedBox(height: 24),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Confirm password',
                        style: TextStyle(
                          color: AppColors.deepBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const CustomTextField(
                      hintText: 'Confirm your new password',
                      isPassword: true,
                      withBorder: true,
                    ),

                    const SizedBox(height: 48),

                    // Confirm button
                    CustomButton(
                      text: 'Confirm',
                      backgroundColor: AppColors.deepBlue,
                      textColor: Colors.white,
                      borderRadius: 14.0,
                      onPressed: () {
                        // TODO: handle password reset
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ── Back to login (Bottom fixed) ───────────────────
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  ),
                  child: const Text(
                    'Back to login ?',
                    style: TextStyle(
                      color: AppColors.deepBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.deepBlue,
          width: 3.5,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Icon(
              Icons.person,
              color: AppColors.deepBlue,
              size: 65,
            ),
          ),
          Positioned(
            bottom: 12,
            left: 6,
            right: 6,
            child: Container(
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.deepBlue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'xxxx',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3.0,
                    height: 1.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

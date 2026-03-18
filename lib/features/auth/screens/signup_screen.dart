import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/curved_header.dart';
import '../../../core/widgets/logo_widget.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_divider.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  // ── Curved white circular dawira header ─────────────────
                  CurvedHeader(
                    height: 350,
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            LogoWidget(size: 260),
                            SizedBox(height: 10),
                            
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Title ───────────────────────────────────────────────
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Form ────────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const CustomTextField(
                          hintText: 'First Name',
                        ),
                        const SizedBox(height: 12),
                        const CustomTextField(
                          hintText: 'Last Name',
                        ),
                        const SizedBox(height: 12),
                        const CustomTextField(
                          hintText: 'UserName',
                        ),
                        const SizedBox(height: 12),
                        const CustomTextField(
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        const CustomTextField(
                          hintText: 'Password',
                          isPassword: true,
                        ),

                        const SizedBox(height: 30),

                        // ── Glowing Sign Up button ────────────────────────
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: CustomButton(
                            text: 'Sign up',
                            backgroundColor: Colors.white,
                            textColor: AppColors.deepBlue,
                            hasGlow: true,
                            onPressed: () {
                              // TODO: handle sign up
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Flexible Spacer to push bottom content down ───────
                  const Spacer(),

                  // ── Bottom section (Divider + Link) ───────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const CustomDivider(),
                        const SizedBox(height: 14),
                        const Text(
                          'Already have an account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: AppColors.deepBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom safe space
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
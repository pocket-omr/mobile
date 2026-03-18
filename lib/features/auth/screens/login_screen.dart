import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/curved_header.dart';
import '../../../core/widgets/logo_widget.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_divider.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        // Use CustomScrollView to allow Spacers to work while still being scrollable if needed
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  // ── Curved white circular dawira header ─────────────────
                  CurvedHeader(
                    height: 350, // Enough height for the big logo + deep curve
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            LogoWidget(size: 260), // Large size as requested
                            SizedBox(height: 10),
                            
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Title ───────────────────────────────────────────────
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const Spacer(flex: 2),

                  // ── Form ────────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const CustomTextField(
                          hintText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        const CustomTextField(
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                        ),
                        const SizedBox(height: 12),

                        // ── Remember me + Forgot password ─────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.white,
                                      ),
                                      child: Checkbox(
                                        value: _rememberMe,
                                        onChanged: (v) => setState(
                                            () => _rememberMe = v ?? false),
                                        fillColor:
                                            WidgetStateProperty.resolveWith(
                                                (states) {
                                          return Colors.white;
                                        }),
                                        checkColor: AppColors.deepBlue,
                                        side: BorderSide.none,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Flexible(
                                    child: Text(
                                      'Remember me',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const ForgotPasswordScreen()),
                              ),
                              child: const Text(
                                'Forgot password ?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 2),

                  // ── Glowing Sign In button ────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CustomButton(
                      text: 'Sign in',
                      backgroundColor: Colors.white,
                      textColor: AppColors.deepBlue,
                      hasGlow: true,
                      onPressed: () {
                        // TODO: handle sign in
                      },
                    ),
                  ),

                  // ── Flexible Spacer to push bottom content down ───────
                  const Spacer(flex: 3),

                  // ── Bottom section (Divider + Link) ───────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const CustomDivider(),
                        const SizedBox(height: 16),
                        const Text(
                          "Don't have an account ?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignupScreen()),
                          ),
                          child: const Text(
                            'Sign Up',
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
import 'package:flutter/material.dart';
import '../../../core/widgets/logo_widget.dart';
import '../../../core/widgets/custom_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // ── PNG Background layer ────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash_screen.png',
              fit: BoxFit.cover,
            ),
          ),

          // ── Foreground content ──────────────────────────────────
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ── Top section: logo + text ─────────────────────
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      const LogoWidget(size: 280),
                      const SizedBox(height: 14),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Smart platform for creating\nand evaluating quizzes.',
                            style: TextStyle(
                              color: Color(0xFF0D3B6E),
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Bottom section: buttons ───────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 48),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(
                        text: 'Sign Up',
                        backgroundColor: Colors.white,
                        textColor: const Color(0xFF0D3B6E),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignupScreen()),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: 'Sign In',
                        backgroundColor: Colors.transparent,
                        textColor: Colors.white,
                        borderColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

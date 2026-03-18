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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Vertical gradient: very light blue → darker blue (top → bottom)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFDFF3FC), // very light blue at top
              Color(0xFF1976D2), // deeper blue at bottom
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ── Top section: logo + text ─────────────────────────
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),

                    // Logo — proportional to the design
                    const LogoWidget(size: 280),

                    const SizedBox(height: 14),

                    // App title
                    

                    const SizedBox(height: 14),

                    // Subtitle
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

              // ── Bottom section: buttons ──────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 48),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Sign Up — white fill, dark blue text
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

                    // Sign In — transparent, white border + text
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
      ),
    );
  }
}

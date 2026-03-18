import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import 'login_screen.dart';
import 'reset_password_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

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
                                'Verify Your\nCode',
                                style: TextStyle(
                                  color: AppColors.deepBlue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Enter the verification code sent\nto your email to reset your\npassword.",
                                style: TextStyle(
                                  color: AppColors.deepBlue,
                                  fontSize: 11,
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

                    // OTP label
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter Code',
                        style: TextStyle(
                          color: AppColors.deepBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 4-digit OTP boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (i) => _OtpBox(
                        controller: _controllers[i],
                        focusNode: _focusNodes[i],
                        onChanged: (val) {
                          if (val.length == 1 && i < 3) {
                            _focusNodes[i + 1].requestFocus();
                          } else if (val.isEmpty && i > 0) {
                            _focusNodes[i - 1].requestFocus();
                          }
                        },
                      )),
                    ),

                    const SizedBox(height: 48),

                    // Confirm button
                    CustomButton(
                      text: 'Confirm code',
                      backgroundColor: AppColors.deepBlue,
                      textColor: Colors.white,
                      borderRadius: 14.0,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ResetPasswordScreen()),
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

/// Single OTP digit input box.
class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.deepBlue, width: 1.2),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          color: AppColors.deepBlue,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
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

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onOrderTap;
  const HomeTab({super.key, required this.onOrderTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = AuthService.instance.currentUser;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF04070E), Color(0xFF0A1628), Color(0xFF0C1E36)]
              : const [Color(0xFFE3F2FF), Color(0xFFF7FAFD), Color(0xFFD6E9FB)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(top: 30, right: -40, child: _orb(140, AppColors.cyan.withOpacity(0.14))),
          Positioned(bottom: 120, left: -50, child: _orb(180, AppColors.orange.withOpacity(0.12))),
          Positioned(top: 180, left: 40, child: _orb(60, AppColors.cyan.withOpacity(0.08))),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                Container(
                  width: 108,
                  height: 108,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      AppColors.cyan.withOpacity(0.45),
                      AppColors.orange.withOpacity(0.3),
                    ]),
                    border: Border.all(color: AppColors.cyan, width: 2.4),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.cyan.withOpacity(0.4),
                        blurRadius: 32,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.memory_rounded, size: 52, color: Colors.white),
                ),
                const SizedBox(height: 26),
                ShaderMask(
                  shaderCallback: (b) => const LinearGradient(
                    colors: [AppColors.cyan, Color(0xFF7DD3FC), AppColors.orange],
                  ).createShader(b),
                  child: const Text(
                    'فرنو یار',
                    style: TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'فروشگاه و ابزار الکترونیکی',
                  style: TextStyle(
                    color: context.cMuted,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                if (user != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    'سلام ${user.name}',
                    style: TextStyle(fontWeight: FontWeight.w800, color: context.cText),
                  ),
                ],
                const Spacer(flex: 2),
                // دکمه ثبت سفارش خفن
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: GestureDetector(
                    onTap: onOrderTap,
                    child: Container(
                      width: double.infinity,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00C2FF), Color(0xFF0077FF), Color(0xFFFF7A3D)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cyan.withOpacity(0.45),
                            blurRadius: 22,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.5),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_checkout_rounded,
                              color: Colors.white, size: 28),
                          SizedBox(width: 12),
                          Text(
                            'ثبت سفارش',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'قطعات الکترونیکی با چند کلیک',
                  style: TextStyle(fontSize: 12, color: context.cDim),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orb(double s, Color c) =>
      Container(width: s, height: s, decoration: BoxDecoration(shape: BoxShape.circle, color: c));
}

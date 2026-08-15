import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/config.dart';
import '../theme.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onAuthChanged;
  const HomeTab({super.key, required this.onAuthChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = AuthService.instance.currentUser;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [const Color(0xFF060A12), const Color(0xFF0D1524)]
              : [const Color(0xFFF2F7FF), const Color(0xFFE4EEF9)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            // لوگو چیپ
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.cyan.withOpacity(0.35),
                    AppColors.orange.withOpacity(0.25),
                  ],
                ),
                border: Border.all(color: AppColors.cyan.withOpacity(0.55), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withOpacity(0.25),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.memory_rounded, size: 44, color: AppColors.cyan),
            ),
            const SizedBox(height: 28),
            // عنوان خفن
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.cyan, Color(0xFF7DD3FC), AppColors.orange],
              ).createShader(bounds),
              child: const Text(
                'فرنو یار',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -1,
                  height: 1.1,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'ابزارهای الکترونیکی و محاسبه‌گر',
              style: TextStyle(
                fontSize: 15,
                color: context.cMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 28),
            if (user != null)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.cyan.withOpacity(0.1),
                  border: Border.all(color: AppColors.cyan.withOpacity(0.35)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_rounded, color: AppColors.green, size: 20),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'خوش آمدی ${user.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: context.cText,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'برای سفارش و سبد خرید وارد حساب شو',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.cDim, fontSize: 13),
                ),
              ),
            if (!AppConfig.hasServer) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'سرور آنلاین هنوز تنظیم نشده — بعد از قرار دادن آدرس API در config.dart ثبت‌نام فعال می‌شود.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: context.cDim),
                ),
              ),
            ],
            const Spacer(flex: 3),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'از نوار پایین وارد ابزارها شو',
                style: TextStyle(fontSize: 12, color: context.cDim),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

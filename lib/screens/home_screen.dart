import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../theme.dart';
import 'tools_hub_screen.dart';
import 'guide_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// باز کردن تلگرام؛ اول tg:// بعد https
  Future<void> _openTelegram(String usernameOrBot) async {
    final user = usernameOrBot.replaceAll('@', '').replaceAll('https://t.me/', '');
    final tg = Uri.parse('tg://resolve?domain=$user');
    final web = Uri.parse('https://t.me/$user');
    try {
      if (await canLaunchUrl(tg)) {
        await launchUrl(tg, mode: LaunchMode.externalApplication);
        return;
      }
    } catch (_) {}
    await launchUrl(web, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final app = FarnoYarApp.of(context);
    final isDark = app?.isDark ?? false;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? const [Color(0xFF0A1528), Color(0xFF05080F), Color(0xFF0A0A14)]
                : const [Color(0xFFE8F0FF), Color(0xFFF2F5FA), Color(0xFFFFF8F0)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 12, 0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.orange.withOpacity(0.2),
                            AppColors.cyan.withOpacity(0.15),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.orange.withOpacity(0.4)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.memory, size: 14, color: AppColors.orange),
                          SizedBox(width: 4),
                          Text('الکترونیک', style: TextStyle(color: AppColors.orange, fontSize: 12, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Material(
                      color: context.cCard,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => app?.toggleTheme(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: context.cLine),
                          ),
                          child: Icon(
                            isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                            color: isDark ? AppColors.gold : AppColors.purple,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                  children: [
                    _HeroCard(isDark: isDark),
                    const SizedBox(height: 26),
                    Text(
                      'منو',
                      style: TextStyle(
                        color: context.cMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _MenuCard(
                      icon: Icons.build_circle_rounded,
                      title: 'ابزارها',
                      subtitle: 'محاسبات الکترونیک · کاملاً آفلاین',
                      colors: const [Color(0xFFFF6B1A), Color(0xFFEA580C)],
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ToolsHubScreen())),
                    ),
                    const SizedBox(height: 12),
                    _MenuCard(
                      icon: Icons.shopping_cart_rounded,
                      title: 'خرید قطعه الکترونیکی',
                      subtitle: 'سفارش از ربات فرنو الکترونیک',
                      colors: const [Color(0xFF10B981), Color(0xFF059669)],
                      onTap: () => _openTelegram('FarnoElectronicBot'),
                    ),
                    const SizedBox(height: 12),
                    _MenuCard(
                      icon: Icons.campaign_rounded,
                      title: 'کانال ما',
                      subtitle: '@FarnoElectronic',
                      colors: const [Color(0xFF0EA5E9), Color(0xFF0284C7)],
                      onTap: () => _openTelegram('FarnoElectronic'),
                    ),
                    const SizedBox(height: 12),
                    _MenuCard(
                      icon: Icons.code_rounded,
                      title: 'برنامه‌نویس',
                      subtitle: '@nvdrl',
                      colors: const [Color(0xFFA855F7), Color(0xFF7C3AED)],
                      onTap: () => _openTelegram('nvdrl'),
                    ),
                    const SizedBox(height: 12),
                    _MenuCard(
                      icon: Icons.menu_book_rounded,
                      title: 'راهنما',
                      subtitle: 'آموزش کامل استفاده از فرنو یار',
                      colors: const [Color(0xFF22C55E), Color(0xFF16A34A)],
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GuideScreen())),
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: Text(
                        'فرنو یار · دستیار الکترونیک',
                        style: TextStyle(color: context.cDim, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
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

class _HeroCard extends StatelessWidget {
  final bool isDark;
  const _HeroCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF122038), Color(0xFF0A1220), Color(0xFF1A1035)]
              : const [Color(0xFFFFFFFF), Color(0xFFE8EEFF), Color(0xFFFFF4EB)],
        ),
        border: Border.all(
          color: isDark ? AppColors.cyan.withOpacity(0.25) : AppColors.orange.withOpacity(0.25),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? AppColors.cyan : AppColors.orange).withOpacity(0.12),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // مدار ساده با آیکون
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.orange.withOpacity(0.35), width: 2),
                ),
              ),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.orange, Color(0xFFFF9A3C)],
                  ),
                  boxShadow: [
                    BoxShadow(color: AppColors.orange.withOpacity(0.45), blurRadius: 18, offset: const Offset(0, 6)),
                  ],
                ),
                child: const Icon(Icons.memory, color: Colors.white, size: 34),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'فرنو یار',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: context.cText,
              letterSpacing: -0.8,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'دستیار هوشمند الکترونیک',
            style: TextStyle(fontSize: 14.5, color: context.cMuted, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _chip('آفلاین', Icons.cloud_off_outlined),
              _chip('فارسی', Icons.translate),
              _chip('سریع', Icons.bolt),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.orange.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.orange.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.orange),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: AppColors.orange, fontSize: 11.5, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> colors;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.cCard,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: context.cLine.withOpacity(0.7)),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colors),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: colors.first.withOpacity(0.35), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: context.cText)),
                    const SizedBox(height: 3),
                    Text(subtitle, style: TextStyle(fontSize: 12, color: context.cMuted)),
                  ],
                ),
              ),
              Icon(Icons.chevron_left, color: context.cDim, size: 26),
            ],
          ),
        ),
      ),
    );
  }
}

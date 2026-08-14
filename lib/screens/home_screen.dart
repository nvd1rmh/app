import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../theme.dart';
import 'tools_hub_screen.dart';
import 'guide_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = FarnoYarApp.of(context);
    final isDark = app?.isDark ?? true;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0A1220), AppColors.dBg, const Color(0xFF050810)]
                : [const Color(0xFFE8F0FF), AppColors.lBg, const Color(0xFFF8FAFC)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 12, 0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.orange.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.orange.withOpacity(0.35)),
                      ),
                      child: const Text(
                        'v1.1',
                        style: TextStyle(color: AppColors.orange, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Spacer(),
                    // Theme toggle — sun / moon
                    Material(
                      color: context.cCard,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => app?.toggleTheme(),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                            color: isDark ? AppColors.gold : AppColors.purple,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                  children: [
                    // Hero
                    _HeroCard(isDark: isDark),
                    const SizedBox(height: 28),
                    Text(
                      'منو',
                      style: TextStyle(
                        color: context.cMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _MenuCard(
                      icon: Icons.build_circle_rounded,
                      title: 'ابزارها',
                      subtitle: 'محاسبات الکترونیک · کاملاً آفلاین',
                      gradient: const [Color(0xFFF97316), Color(0xFFEA580C)],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ToolsHubScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _MenuCard(
                      icon: Icons.campaign_rounded,
                      title: 'کانال تلگرامی ما',
                      subtitle: '@FarnoElectronic',
                      gradient: const [Color(0xFF0EA5E9), Color(0xFF0284C7)],
                      onTap: () => _openUrl('https://t.me/FarnoElectronic'),
                    ),
                    const SizedBox(height: 12),
                    _MenuCard(
                      icon: Icons.code_rounded,
                      title: 'توسعه‌دهنده و برنامه‌نویس',
                      subtitle: '@nvdrl',
                      gradient: const [Color(0xFFA855F7), Color(0xFF7C3AED)],
                      onTap: () => _openUrl('https://t.me/nvdrl'),
                    ),
                    const SizedBox(height: 12),
                    _MenuCard(
                      icon: Icons.menu_book_rounded,
                      title: 'راهنما',
                      subtitle: 'نحوه استفاده از فرنو یار',
                      gradient: const [Color(0xFF22C55E), Color(0xFF16A34A)],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const GuideScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        'ربات هوشمند فرنو الکترونیک',
                        style: TextStyle(color: context.cDim, fontSize: 12),
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
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF152038), const Color(0xFF0C1220), const Color(0xFF1A1030)]
              : [const Color(0xFFFFFFFF), const Color(0xFFE0E7FF), const Color(0xFFFFF7ED)],
        ),
        border: Border.all(
          color: isDark ? AppColors.orange.withOpacity(0.25) : AppColors.orange.withOpacity(0.2),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange.withOpacity(isDark ? 0.12 : 0.08),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          // Circuit-style icon
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.orange, Color(0xFFFB923C)],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.orange.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.memory, color: Colors.white, size: 36),
          ),
          const SizedBox(height: 20),
          Text(
            'فرنو یار',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: context.cText,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'دستیار هوشمند الکترونیک',
            style: TextStyle(
              fontSize: 15,
              color: context.cMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _chip('آفلاین', Icons.cloud_off_outlined),
              _chip('فارسی', Icons.language),
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
        border: Border.all(color: AppColors.orange.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.orange),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: AppColors.orange, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: context.cLine.withOpacity(0.6)),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: gradient.first.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: context.cText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12.5, color: context.cMuted),
                    ),
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

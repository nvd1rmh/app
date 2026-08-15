import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import 'guide_screen.dart';

class AboutScreen extends StatelessWidget {
  final VoidCallback onAuthChanged;
  const AboutScreen({super.key, required this.onAuthChanged});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        Text(
          'درباره فرنو یار',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: context.cText,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'جعبه ابزار الکترونیکی و بستر فروش قطعات — ساخته‌شده برای جامعه الکترونیک ایران.',
          style: TextStyle(color: context.cMuted, height: 1.5),
        ),
        const SizedBox(height: 20),
        _card(
          context,
          icon: Icons.telegram,
          color: const Color(0xFF2AABEE),
          title: 'کانال تلگرام',
          subtitle: 'اخبار و قطعات · @FarnoElectronic',
          onTap: () => _open('https://t.me/FarnoElectronic'),
        ),
        _card(
          context,
          icon: Icons.code_rounded,
          color: AppColors.purple,
          title: 'توسعه‌دهنده',
          subtitle: 'برنامه‌نویس · @nvdrl',
          onTap: () => _open('https://t.me/nvdrl'),
        ),
        _card(
          context,
          icon: Icons.menu_book_rounded,
          color: AppColors.gold,
          title: 'راهنما',
          subtitle: 'نحوه استفاده از ابزارها و اپ',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GuideScreen()),
            );
          },
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            'نسخه ۱٫۳٫۰',
            style: TextStyle(fontSize: 12, color: context.cDim),
          ),
        ),
      ],
    );
  }

  Widget _card(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: context.cCard,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: color.withOpacity(0.15),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: context.cText)),
                      const SizedBox(height: 3),
                      Text(subtitle, style: TextStyle(fontSize: 12.5, color: context.cMuted)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_left_rounded, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

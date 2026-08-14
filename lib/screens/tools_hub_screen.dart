import 'package:flutter/material.dart';
import '../data/tools_data.dart';
import '../theme.dart';
import 'category_screen.dart';

class ToolsHubScreen extends StatelessWidget {
  const ToolsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ابزارها'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          // Header banner
          Container(
            margin: const EdgeInsets.only(bottom: 18),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: isDark
                    ? [const Color(0xFF0D1B2A), const Color(0xFF1B2838)]
                    : [const Color(0xFFE8F4FF), const Color(0xFFD6E8FF)],
              ),
              border: Border.all(
                color: AppColors.cyan.withOpacity(isDark ? 0.45 : 0.35),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyan.withOpacity(isDark ? 0.12 : 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.cyan.withOpacity(0.3), AppColors.orange.withOpacity(0.2)],
                    ),
                    border: Border.all(color: AppColors.cyan.withOpacity(0.5)),
                  ),
                  child: const Icon(Icons.memory, color: AppColors.cyan, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'جعبه ابزار الکترونیکی',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: context.cText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'مقاومت · خازن · سلف · LED · قانون اهم و بیشتر',
                        style: TextStyle(fontSize: 12, color: context.cMuted, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(toolCategories.length, (i) {
            final cat = toolCategories[i];
            return _CatCard(cat: cat);
          }),
        ],
      ),
    );
  }
}

class _CatCard extends StatelessWidget {
  final ToolCategory cat;
  const _CatCard({required this.cat});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CategoryScreen(category: cat)),
            );
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  cat.color.withOpacity(isDark ? 0.18 : 0.12),
                  context.cCard,
                ],
              ),
              border: Border.all(color: cat.color.withOpacity(0.4), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: cat.color.withOpacity(isDark ? 0.15 : 0.1),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          cat.color.withOpacity(0.35),
                          cat.color.withOpacity(0.1),
                        ],
                      ),
                      border: Border.all(color: cat.color.withOpacity(0.55)),
                      boxShadow: [
                        BoxShadow(
                          color: cat.color.withOpacity(0.25),
                          blurRadius: 10,
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(cat.emoji, style: const TextStyle(fontSize: 28)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: context.cText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cat.subtitle,
                          style: TextStyle(fontSize: 12.5, color: context.cMuted, height: 1.35),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: cat.color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${cat.tools.length} ابزار',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: cat.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_left_rounded, color: cat.color, size: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

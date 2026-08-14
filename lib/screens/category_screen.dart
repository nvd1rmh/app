import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/tools_data.dart';
import '../theme.dart';
import 'tool_router.dart';

class CategoryScreen extends StatelessWidget {
  final ToolCategory category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.emoji} ${category.title}'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        physics: const BouncingScrollPhysics(),
        itemCount: category.tools.length,
        itemBuilder: (context, i) {
          final t = category.tools[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: AppTheme.card,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => openTool(context, t.id),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: t.color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(t.icon, color: t.color, size: 26),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.title,
                              style: GoogleFonts.vazirmatn(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.text,
                              ),
                            ),
                            if (t.subtitle.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                t.subtitle,
                                style: GoogleFonts.vazirmatn(
                                  fontSize: 13,
                                  color: AppTheme.muted,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_left, color: t.color),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

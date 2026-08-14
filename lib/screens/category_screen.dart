import 'package:flutter/material.dart';
import '../data/tools_data.dart';
import '../theme.dart';
import 'tool_router.dart';

class CategoryScreen extends StatelessWidget {
  final ToolCategory category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.emoji} ${category.title}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        itemCount: category.tools.length,
        itemBuilder: (context, i) {
          final tool = category.tools[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 11),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => openTool(context, tool.id),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: context.cCard,
                    border: Border.all(color: tool.color.withOpacity(0.28)),
                    boxShadow: [
                      BoxShadow(
                        color: tool.color.withOpacity(isDark ? 0.12 : 0.07),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: LinearGradient(
                              colors: [
                                tool.color.withOpacity(0.3),
                                tool.color.withOpacity(0.08),
                              ],
                            ),
                            border: Border.all(color: tool.color.withOpacity(0.45)),
                          ),
                          child: Icon(tool.icon, color: tool.color, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tool.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: context.cText,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                tool.subtitle,
                                style: TextStyle(fontSize: 12, color: context.cMuted, height: 1.3),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: tool.color.withOpacity(0.12),
                          ),
                          child: Icon(Icons.chevron_left_rounded, color: tool.color, size: 22),
                        ),
                      ],
                    ),
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

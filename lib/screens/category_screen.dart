import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: context.cCard,
              borderRadius: BorderRadius.circular(18),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => openTool(context, tool.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: context.cLine.withOpacity(0.45)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: tool.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(tool.icon, color: tool.color, size: 22),
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
                                fontWeight: FontWeight.w600,
                                color: context.cText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              tool.subtitle,
                              style: TextStyle(fontSize: 12, color: context.cMuted),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_left, color: context.cDim),
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

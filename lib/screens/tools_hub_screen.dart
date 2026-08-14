import 'package:flutter/material.dart';
import '../data/tools_data.dart';
import '../theme.dart';
import 'category_screen.dart';

class ToolsHubScreen extends StatelessWidget {
  const ToolsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛠 ابزارها'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        itemCount: toolCategories.length,
        itemBuilder: (context, i) {
          final cat = toolCategories[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: context.cCard,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CategoryScreen(category: cat)),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: context.cLine.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: cat.color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: cat.color.withOpacity(0.35)),
                        ),
                        child: Center(
                          child: Text(cat.emoji, style: const TextStyle(fontSize: 26)),
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
                                fontWeight: FontWeight.w700,
                                color: context.cText,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${cat.tools.length} ابزار',
                              style: TextStyle(fontSize: 13, color: context.cMuted),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_left, color: cat.color, size: 28),
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

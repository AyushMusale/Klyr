import 'package:flutter/material.dart';
import 'package:klyr/data/model/summary_row.dart';



class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.rows});

  final List<SummaryRow> rows;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final dividerColor = isDark
        ? Colors.white.withValues(alpha: 0.10)
        : Colors.black.withValues(alpha: 0.08);
    final labelColor = isDark
        ? Colors.white.withValues(alpha: 0.55)
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                children: [
                  Text(
                    rows[i].label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: labelColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    rows[i].value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: rows[i].valueColor,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
            ),
            if (i < rows.length - 1)
              Divider(height: 1, thickness: 1, color: dividerColor),
          ],
        ],
      ),
    );
  }
}

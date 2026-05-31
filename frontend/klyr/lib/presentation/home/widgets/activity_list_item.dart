import 'package:flutter/material.dart';
import 'package:klyr/data/model/activity_items.dart';



class ActivityListItem extends StatelessWidget {
  const ActivityListItem({super.key, required this.item, required this.fn});

  final ActivityItem item;
  final GestureTapCallback fn;

  static const _accent = Color(0xFFE8630A);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final highlighted = item.isHighlighted;

    final bg =
        highlighted
            ? _accent
            : (isDark ? const Color(0xFF1C1C1E) : Colors.white);
    final borderColor =
        highlighted
            ? Colors.transparent
            : (isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.08));
    final titleColor =
        highlighted
            ? Colors.white
            : (isDark ? Colors.white : const Color(0xFF333333));
    final subtitleColor =
        highlighted
            ? Colors.white.withValues(alpha: 0.85)
            : (isDark
                ? Colors.white.withValues(alpha: 0.55)
                : const Color(0xFF888888));
    final amountColor = highlighted ? Colors.white : _accent;

    return GestureDetector(
      onTap: fn,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.date,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: subtitleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              item.amount,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: amountColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

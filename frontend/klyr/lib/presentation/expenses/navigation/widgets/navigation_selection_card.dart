import 'package:flutter/material.dart';
import 'package:klyr/theme/app_theme.dart';

class SelectionCard extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final String label;
  final GestureTapCallback onTap;
  final bool selected;
  const SelectionCard({
    super.key,
    required this.isDark,
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final surface = isDark ? AppColors.darkCard : Colors.white;
    final border =
        isDark ? Colors.white.withValues(alpha: 0.10) : Colors.black.withValues(alpha: 0.06);

    final bg =
        selected
            ? cs.primary.withValues(alpha: isDark ? 0.18 : 0.10)
            : surface;
    final borderColor = selected ? cs.primary.withValues(alpha: 0.70) : border;
    final iconColor =
        selected
            ? cs.primary
            : (isDark
                ? Colors.white.withValues(alpha: 0.78)
                : Colors.black.withValues(alpha: 0.72));
    final textColor =
        selected
            ? (isDark ? Colors.white : Colors.black.withValues(alpha: 0.85))
            : (isDark
                ? Colors.white.withValues(alpha: 0.70)
                : Colors.black.withValues(alpha: 0.70));

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final compact = w < 110;
        final iconSize = compact ? 20.0 : 24.0;
        final padV = compact ? 10.0 : 12.0;
        final padH = compact ? 8.0 : 12.0;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(vertical: padV, horizontal: padH),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor, width: selected ? 1.5 : 1),
                boxShadow:
                    selected && !isDark
                        ? [
                          BoxShadow(
                            color: cs.primary.withValues(alpha: 0.12),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ]
                        : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: iconSize, color: iconColor),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: textColor,
                          height: 1.1,
                          fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

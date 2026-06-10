import 'package:flutter/material.dart';
import 'package:klyr/theme/app_theme.dart';

class GroupMemberItem {
  const GroupMemberItem({
    required this.name,
    required this.subtitle,
    required this.badge,
    this.avatarLabel,
  });

  final String name;
  final String subtitle;
  final String badge;
  final String? avatarLabel;
}

class GroupMemberTile extends StatelessWidget {
  const GroupMemberTile({super.key, required this.isDark, required this.member});

  final bool isDark;
  final GroupMemberItem member;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final borderColor =
        isDark ? AppColors.darkBorder : Colors.black.withValues(alpha: 0.08);
    final titleColor = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final subtitleColor =
        isDark
            ? Colors.white.withValues(alpha: 0.5)
            : const Color(0xFF888888);
    final badgeBg =
        isDark
            ? Colors.white.withValues(alpha: 0.08)
            : AppColors.primary.withValues(alpha: 0.12);
    final avatarText = member.avatarLabel ?? member.name;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primary,
            child: Text(
              avatarText.length <= 3 ? avatarText : avatarText[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  member.subtitle,
                  style: TextStyle(color: subtitleColor, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              member.badge,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

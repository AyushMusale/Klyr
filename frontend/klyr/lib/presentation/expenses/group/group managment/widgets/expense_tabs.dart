import 'package:flutter/material.dart';
import 'package:klyr/theme/app_theme.dart';

// ─── Segmented Tab Toggle ────────────────────────────────────────────────────

class BuildExpenseTab extends StatelessWidget {
  final bool isDark;
  final double width;
  final double height;
  final int selectedTab;
  final GestureTapCallback onEqual;
  final GestureTapCallback onCustom;

  const BuildExpenseTab({
    super.key,
    required this.isDark,
    required this.height,
    required this.width,
    required this.selectedTab,
    required this.onEqual,
    required this.onCustom,
  });

  @override
  Widget build(BuildContext context) {
    final Color trackColor =
        isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF0F0F0);
    final Color activeText = Colors.white;
    final Color inactiveText =
        isDark ? const Color(0xFF888888) : const Color(0xFF666666);

    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _Tab(
            label: 'Equal',
            isActive: selectedTab == 0,
            activeText: activeText,
            inactiveText: inactiveText,
            onTap: onEqual,
          ),
          _Tab(
            label: 'Custom',
            isActive: selectedTab == 1,
            activeText: activeText,
            inactiveText: inactiveText,
            onTap: onCustom,
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color activeText;
  final Color inactiveText;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    required this.isActive,
    required this.activeText,
    required this.inactiveText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow:
                isActive
                    ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? activeText : inactiveText,
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Member Share Tile ───────────────────────────────────────────────────────

class ShareAmountTile extends StatelessWidget {
  final bool isDark;
  final double maxHeight;
  final double maxWidth;
  final String initials;
  final String email;
  final TextEditingController controller;
  final bool readOnly;
  final double value;

  const ShareAmountTile({
    super.key,
    required this.isDark,
    required this.maxHeight,
    required this.maxWidth,
    required this.initials,
    required this.email,
    required this.controller,
    this.readOnly = true,
    this.value = 0.00,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final Color borderColor =
        isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0);
    final Color subtextColor =
        isDark ? const Color(0xFFAAAAAA) : const Color(0xFF555555);
    final Color fieldBg =
        isDark ? const Color(0xFF111111) : const Color(0xFFF5F5F5);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: maxHeight * 0.07,
      width: maxWidth,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with glow
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFCC5500).withValues(alpha: 0.4),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFF2A1200),
              child: Text(
                initials,
                style: const TextStyle(
                  color: Color(0xFFFF8C3A),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Email
          Expanded(
            child: Text(
              email,
              style: TextStyle(
                color: subtextColor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 10),

          // Amount field
          SizedBox(
            width: maxWidth * 0.22,
            height: 36,
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                fillColor: fieldBg,
                filled: true,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 9,
                ),
                hintText: value.toStringAsFixed(2),
                hintStyle: TextStyle(
                  color:
                      isDark
                          ? const Color(0xFF555555)
                          : const Color(0xFFAAAAAA),
                  fontSize: 13,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderColor, width: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Equal Split List ────────────────────────────────────────────────────────

class EqualTabs extends StatelessWidget {
  final Map<String, TextEditingController> members;
  final bool isDark;
  final double maxHeight;
  final double maxWidth;
  final double amount;

  const EqualTabs({
    super.key,
    required this.members,
    required this.isDark,
    required this.maxHeight,
    required this.maxWidth,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final emails = members.keys.toList();
    return Column(
      children: List.generate(emails.length, (index) {
        final email = emails[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ShareAmountTile(
            isDark: isDark,
            maxHeight: maxHeight,
            maxWidth: maxWidth,
            initials:
                email.length >= 2 ? email.substring(0, 2).toUpperCase() : '??',
            email: email,
            controller: members[email]!,
            readOnly: true,
            value: amount / members.length,
          ),
        );
      }),
    );
  }
}

// ─── Custom Split List ───────────────────────────────────────────────────────

class CustomTabs extends StatelessWidget {
  final Map<String, TextEditingController> members;
  final bool isDark;
  final double maxHeight;
  final double maxWidth;

  const CustomTabs({
    super.key,
    required this.members,
    required this.isDark,
    required this.maxHeight,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final emails = members.keys.toList();
    return Column(
      children: List.generate(emails.length, (index) {
        final email = emails[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ShareAmountTile(
            isDark: isDark,
            maxHeight: maxHeight,
            maxWidth: maxWidth,
            initials:
                email.length >= 2 ? email.substring(0, 2).toUpperCase() : '??',
            email: email,
            controller: members[email]!,
            readOnly: false,
          ),
        );
      }),
    );
  }
}

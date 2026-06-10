import 'package:flutter/material.dart';
import 'package:klyr/theme/app_theme.dart';

class GroupInputField extends StatelessWidget {
  const GroupInputField({
    super.key,
    required this.isDark,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.keyboardType,
    this.suffix,
    this.onSubmitted,
    this.readOnly = false,
  });

  final bool isDark;
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final ValueChanged<String>? onSubmitted;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final fieldBg = isDark ? AppColors.darkCard : Colors.white;
    final fieldBorder =
        isDark ? AppColors.darkBorder : Colors.black.withValues(alpha: 0.08);
    final fieldText = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final fieldHint =
        isDark
            ? Colors.white.withValues(alpha: 0.35)
            : const Color(0xFFB0B0B0);
    final iconColor =
        isDark
            ? Colors.white.withValues(alpha: 0.4)
            : const Color(0xFFAAAAAA);

    return TextField(
      controller: controller,
      readOnly: readOnly,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      style: TextStyle(color: fieldText, fontSize: 15),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: fieldHint, fontSize: 15),
        filled: true,
        fillColor: fieldBg,
        prefixIcon: Icon(prefixIcon, size: 20, color: iconColor),
        suffixIcon:
            suffix == null
                ? null
                : Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: suffix,
                ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: fieldBorder),
        ),
      ),
    );
  }
}

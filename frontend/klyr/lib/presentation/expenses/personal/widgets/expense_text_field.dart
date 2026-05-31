import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klyr/theme/app_theme.dart';

class ExpenseTextField extends StatelessWidget {
  const ExpenseTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.fieldBg,
    required this.fieldText,
    required this.fieldHint,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.suffix,
    this.style,
  });

  final TextEditingController controller;
  final String hint;
  final Color fieldBg;
  final Color fieldText;
  final Color fieldHint;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffix;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      style: (style ?? const TextStyle(fontSize: 15)).copyWith(
        color: fieldText,
      ),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: fieldHint, fontSize: 15),
        filled: true,
        fillColor: fieldBg,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        suffixIcon:
            suffix == null
                ? null
                : Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: suffix,
                ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

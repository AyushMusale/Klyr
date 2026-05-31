import 'package:flutter/material.dart';
import 'package:klyr/theme/app_theme.dart';

class ExpenseSubmitButton extends StatelessWidget {
  const ExpenseSubmitButton({
    super.key,
    required this.enabled,
    required this.isDark,
    required this.onPressed,
    this.text,
  });

  final String? text;
  final bool enabled;
  final bool isDark;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      height: dh * 0.05,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor:
              isDark ? AppColors.darkCard : const Color(0xFFE8E8E8),
          disabledForegroundColor:
              isDark ? AppColors.darkSubText : const Color(0xFFB0B0B0),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text ?? '+ add expense',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

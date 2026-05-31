import 'package:flutter/material.dart';
import 'package:klyr/theme/app_theme.dart';

class EditandDeleteButtuon extends StatelessWidget {
  const EditandDeleteButtuon({
    super.key,
    required this.isDark,
    required this.onEdit,
    required this.onDelete
  });
  final bool isDark;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    return SizedBox(
      height: dh * 0.05,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: ElevatedButton(
              onPressed: onEdit,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, size: 18, color: Colors.white),
                  SizedBox(width: 6),
                  Text(
                    "Edit",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Colors.white : Colors.black,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    size: 18,
                    color: isDark ? Colors.black : Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

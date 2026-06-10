import 'package:flutter/material.dart';
import 'package:klyr/theme/app_theme.dart';

class SplitSummaryRow extends StatelessWidget {
  final String sum;
  final String total;
  final bool isDark;

  const SplitSummaryRow({
    super.key,
    required this.sum,
    required this.total,
    required this.isDark,
  });

  bool get _isValid {
    final t = double.tryParse(total) ?? 0.0;
    final s = double.tryParse(sum) ?? 0.0;
    return (t - s).abs() < 0.01;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            "split  ",
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.darkSubText : const Color(0xFF6B6B6B),
            ),
          ),
          Text(
            sum,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _isValid ? AppColors.primary : Colors.redAccent,
            ),
          ),
          Text(
            " / ${total.isEmpty ? '0.00' : total}",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

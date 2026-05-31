import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final String label;
  const SelectionCard({
    super.key,
    required this.isDark,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.orange : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: isDark ? Colors.white : Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon), Text(label)],
      ),
    );
  }
}

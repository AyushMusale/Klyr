import 'package:flutter/material.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/widgets/group_input_field.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/widgets/group_section_label.dart';

class GroupNameSection extends StatelessWidget {
  const GroupNameSection({
    super.key,
    required this.isDark,
    required this.controller,
    this.readOnly = false,
  });

  final bool isDark;
  final TextEditingController controller;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final labelColor =
        isDark
            ? Colors.white.withValues(alpha: 0.45)
            : const Color(0xFF888888);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GroupSectionLabel(text: 'Group name', color: labelColor),
        const SizedBox(height: 8),
        GroupInputField(
          isDark: isDark,
          controller: controller,
          readOnly: readOnly,
          hint: 'e.g. Goa Trip, Flatmates...',
          prefixIcon: Icons.groups_outlined,
        ),
      ],
    );
  }
}

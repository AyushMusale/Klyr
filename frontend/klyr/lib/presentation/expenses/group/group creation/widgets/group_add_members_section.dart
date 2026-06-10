import 'package:flutter/material.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/widgets/group_input_field.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/widgets/group_member_tile.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/widgets/group_members_list.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/widgets/group_section_label.dart';
import 'package:klyr/theme/app_theme.dart';

class GroupAddMembersSection extends StatelessWidget {
  const GroupAddMembersSection({
    super.key,
    required this.isDark,
    required this.emailController,
    required this.members,
    required this.onAddMember,
    this.readOnly = false,
  });

  final bool isDark;
  final TextEditingController emailController;
  final List<GroupMemberItem> members;
  final VoidCallback onAddMember;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final labelColor =
        isDark
            ? Colors.white.withValues(alpha: 0.45)
            : const Color(0xFF888888);
    final hintColor =
        isDark
            ? Colors.white.withValues(alpha: 0.35)
            : const Color(0xFFAAAAAA);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GroupSectionLabel(text: 'Add members', color: labelColor),
        const SizedBox(height: 8),
        GroupInputField(
          isDark: isDark,
          controller: emailController,
          readOnly: readOnly,
          hint: 'Enter email address...',
          prefixIcon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          onSubmitted: (_) => onAddMember(),
          suffix: Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: readOnly ? null : onAddMember,
              borderRadius: BorderRadius.circular(10),
              child: const SizedBox(
                width: 36,
                height: 36,
                child: Icon(Icons.add_rounded, color: Colors.white, size: 22),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Press Enter email to add',
          style: TextStyle(color: hintColor, fontSize: 11),
        ),
        const SizedBox(height: 18),
        GroupMembersList(isDark: isDark, members: members),
      ],
    );
  }
}

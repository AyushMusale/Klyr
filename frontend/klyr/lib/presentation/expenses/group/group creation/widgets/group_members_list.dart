import 'package:flutter/material.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/widgets/group_member_tile.dart';

class GroupMembersList extends StatelessWidget {
  const GroupMembersList({
    super.key,
    required this.isDark,
    required this.members,
  });

  final bool isDark;
  final List<GroupMemberItem> members;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: members.length,
      itemBuilder: (context, index) {
        return GroupMemberTile(isDark: isDark, member: members[index]);
      },
    );
  }
}

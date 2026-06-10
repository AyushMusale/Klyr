class Group {
  final int? groupId;
  final String groupName;
  final String? createdBy;
  final List<String>? members;

  Group({required this.groupName, this.members, this.createdBy, this.groupId});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['group_id'],
      groupName: json['group_name'],
      createdBy: json['created_by'].toString(),
      members:
          (json['groupMembers'] as List<dynamic>?)
              ?.map((e) => e['user_email'] as String)
              .toList(),
    );
  }
}

class GroupMembers {
  final String email;
  final double shareAmount;
  final bool isSettled;
  GroupMembers({
    required this.email,
    required this.shareAmount,
    required this.isSettled,
  });

  factory GroupMembers.fromJson(Map<String, dynamic> json) {
    return GroupMembers(
      email: json['user_email'] as String,
      shareAmount: (json['share_amount'] as num).toDouble(),
      isSettled: json['is_settled'] as bool,
    );
  }
}

class GroupList {
  final List<Group> groups;
  GroupList({required this.groups});

  factory GroupList.fromJson(Map<String, dynamic> json) {
    return GroupList(
      groups:
          (json['groups'] as List<dynamic>)
              .map((item) => Group.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }
}

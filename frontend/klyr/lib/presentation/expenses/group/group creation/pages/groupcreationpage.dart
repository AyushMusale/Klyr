import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:klyr/data/model/group.dart';
import 'package:klyr/presentation/auth/bloc/authbloc.dart';
import 'package:klyr/presentation/auth/bloc/authevent.dart';
import 'package:klyr/presentation/expenses/group/group creation/bloc/group_bloc.dart';
import 'package:klyr/presentation/expenses/group/group creation/bloc/group_event.dart';
import 'package:klyr/presentation/expenses/group/group creation/bloc/group_state.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/widgets/group_add_members_section.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/widgets/group_member_tile.dart';
import 'package:klyr/presentation/expenses/group/group%20creation/widgets/group_name_section.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_submit_button.dart';
import 'package:klyr/theme/app_theme.dart';

class GroupCreationPage extends StatefulWidget {
  const GroupCreationPage({super.key});

  @override
  State<GroupCreationPage> createState() => _GroupCreationPageState();
}

class _GroupCreationPageState extends State<GroupCreationPage> {
  final _groupNameController = TextEditingController();
  final _emailController = TextEditingController();
  final List<String> _addedMembers = [];

  static const _creatorMember = GroupMemberItem(
    name: 'You',
    subtitle: 'Creator · always included',
    badge: 'Admin',
    avatarLabel: 'You',
  );

  @override
  void initState() {
    super.initState();
    _groupNameController.addListener(_onFieldsChanged);
  }

  @override
  void dispose() {
    _groupNameController
      ..removeListener(_onFieldsChanged)
      ..dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onFieldsChanged() => setState(() {});

  bool get _canCreate => _groupNameController.text.trim().isNotEmpty;

  List<GroupMemberItem> get _displayMembers => [
    _creatorMember,
    ..._addedMembers.map(
      (email) => GroupMemberItem(
        name: email,
        subtitle: 'Member',
        badge: 'Member',
      ),
    ),
  ];

  void _addMember() {
    final email = _emailController.text.trim().toLowerCase();
    if (email.isEmpty || !email.contains('@') || _addedMembers.contains(email)) {
      return;
    }
    setState(() {
      _addedMembers.add(email);
      _emailController.clear();
    });
  }

  void _submit() {
    if (!_canCreate) return;
    context.read<GroupBloc>().add(
      GroupCreationEvent(
        group: Group(
          groupName: _groupNameController.text.trim(),
          members: List<String>.from(_addedMembers),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = isDark ? AppColors.darkBackground : const Color(0xFFF4F4F4);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: pageBg,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
        ),
        title: Text(
          'Create Group',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            color:
                isDark
                    ? AppColors.darkBorder
                    : Colors.black.withValues(alpha: 0.06),
          ),
        ),
      ),
      backgroundColor: pageBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxW = constraints.maxWidth;
            final hPad = maxW > 600 ? (maxW - 480) / 2 : 20.0;

            return BlocConsumer<GroupBloc, GroupState>(
              listener: (context, state) {
                if (state is GroupUnauthState) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                  context.read<Authbloc>().add(LogoutEvent());
                } else if (state is GroupFailureState) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is GroupCreatedState) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                  context.pop();
                }
              },
              builder: (context, state) {
                final isLoading = state is GroupLoadingState;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(hPad, 20, hPad, 16),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 480),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GroupNameSection(
                                  isDark: isDark,
                                  controller: _groupNameController,
                                  readOnly: isLoading,
                                ),
                                const SizedBox(height: 22),
                                GroupAddMembersSection(
                                  isDark: isDark,
                                  emailController: _emailController,
                                  members: _displayMembers,
                                  onAddMember: _addMember,
                                  readOnly: isLoading,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ), 
                    Padding(
                      padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 16),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child:
                              isLoading
                                  ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                  : ExpenseSubmitButton(
                                    enabled:
                                        _canCreate &&
                                        state is! GroupLoadingState,
                                    isDark: isDark,
                                    text: 'Create Group',
                                    onPressed: _submit,
                                  ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:klyr/data/model/activity_items.dart';
import 'package:klyr/presentation/auth/bloc/authbloc.dart';
import 'package:klyr/presentation/auth/bloc/authevent.dart';
import 'package:klyr/presentation/expenses/group/group%20view/bloc/group_view_bloc.dart';
import 'package:klyr/presentation/expenses/group/group%20view/bloc/group_view_event.dart';
import 'package:klyr/presentation/expenses/group/group%20view/bloc/group_view_state.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_skeleton_list.dart';
import 'package:klyr/presentation/home/widgets/activity_list_item.dart';
import 'package:klyr/theme/app_theme.dart';

class ViewAllGroupsPage extends StatefulWidget {
  const ViewAllGroupsPage({super.key});

  @override
  State<ViewAllGroupsPage> createState() => _ViewAllGroupsPageState();
}

class _ViewAllGroupsPageState extends State<ViewAllGroupsPage> {
  List<ActivityItem> items = [];

  @override
  void initState() {
    context.read<GroupViewBloc>().add(GetGroupsViewEvent());
    super.initState();
  }

  Future<void> _onRefresh() async {
    context.read<GroupViewBloc>().add(GetGroupsViewEvent());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final pageBg =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    return BlocConsumer<GroupViewBloc, GroupViewState>(
      listener: (context, state) {
        if (state is GroupViewLoadedState) {
          setState(() {
            items =
                state.groupList.groups
                    .map(
                      (group) => ActivityItem(
                        id: group.groupId ?? 0,
                        title: group.groupName,
                        date: 'Members: ${group.members?.length ?? 0}',
                        amount: '',
                      ),
                    )
                    .toList();
          });
        }
        if (state is GroupViewUnauthState) {
          context.read<Authbloc>().add(LogoutEvent());
          context.pushReplacementNamed('authpage');
        }
      },
      builder: (context, state) {
        if (state is GroupViewLoadingState) {
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
                      color:
                          isDark ? AppColors.darkBorder : AppColors.lightBorder,
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
                'Groups',
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
            body: SafeArea(child: ExpenseSkeletonList()),
          );
        }

        if (state is GroupViewFailureState) {
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
                      color:
                          isDark ? AppColors.darkBorder : AppColors.lightBorder,
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
                'Groups',
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
            body: Center(child: Text(state.message)),
          );
        }

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
                    color:
                        isDark ? AppColors.darkBorder : AppColors.lightBorder,
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
              'Groups',
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
          body:
              items.isEmpty
                  ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No Groups',
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(150, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              context.pushNamed('creategrouppage');
                            },
                            child: const Text('Create Group'),
                          ),
                        ],
                      ),
                    ),
                  )
                  : RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: Colors.orangeAccent,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActivityListItem(
                            item: items[i],
                            fn: () {
                              context.pushNamed(
                                'grouppage',
                                pathParameters: {'id': items[i].id.toString()},
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed('creategrouppage');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

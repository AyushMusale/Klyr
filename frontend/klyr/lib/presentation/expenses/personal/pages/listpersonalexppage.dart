import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:klyr/data/model/activity_items.dart';
import 'package:klyr/presentation/expenses/personal/bloc/expense_bloc.dart';
import 'package:klyr/presentation/expenses/personal/bloc/expense_event.dart';
import 'package:klyr/presentation/expenses/personal/bloc/expense_state.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_skeleton_list.dart';
import 'package:klyr/presentation/home/widgets/activity_list_item.dart';
import 'package:klyr/theme/app_theme.dart';

class ShowAllPersonalexppage extends StatefulWidget {
  const ShowAllPersonalexppage({super.key});

  @override
  State<ShowAllPersonalexppage> createState() => _ShowAllPersonalexppageState();
}

class _ShowAllPersonalexppageState extends State<ShowAllPersonalexppage> {
  @override
  void initState() {
    context.read<ExpenseBloc>().add(GetExpenseEvent());
    super.initState();
  }

  Future<void> _onRefresh() async {
    context.read<ExpenseBloc>().add(GetExpenseEvent());
  }

  List<ActivityItem> items = [];
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    final pageBg =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    return BlocConsumer<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state is ExpenseLoadedState) {
          setState(() {
            items =
                state.personalExpense!.personalExpenselist!
                    .map((e) => ActivityItem.fromExpense(e))
                    .toList();
          });
        }
      },
      builder: (context, state) {
        if (state is ExpenseLoadingState) {
          return Scaffold(
            appBar: AppBar(title: Text("Personal Expense")),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const ExpenseSkeletonList(itemCount: 5),
              ),
            ),
          );
        }
        if (state is ExpenseFailureState) {
          return Scaffold(
            appBar: AppBar(title: Text("Personal Expense")),
            body: Center(child: Text("Somthing went wrong")),
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
              'personal expense',
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
          body: RefreshIndicator(
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
                      context.push('/showpersonalexpense/${items[i].id}');
                    },
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed('createpersonalexpensepage');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

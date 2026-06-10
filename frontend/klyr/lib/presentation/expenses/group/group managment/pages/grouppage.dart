import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/bloc/group_managment_bloc.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/bloc/group_managment_event.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/widgets/summary_bloc.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/widgets/tabs.dart';
import 'package:klyr/theme/app_theme.dart';

class Grouppage extends StatefulWidget {
  final String id;
  const Grouppage({super.key, required this.id});

  @override
  State<Grouppage> createState() => _GrouppageState();
}

class _GrouppageState extends State<Grouppage> {
  int selectedTab = 0;

  @override
  void initState() {
    context.read<GroupManagmentBloc>().add(GetGroupEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final pageBg =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
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
          'Title',
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;
          //final horizontal = maxWidth > 600 ? maxWidth * 0.15 : 16.0;

          final summaryWidth = (maxWidth - 50) / 3;
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SummaryBloc(
                        label: "Total Spent",
                        amount: "1300",
                        isDark: isDark,
                        height: maxHeight * 0.09,
                        width: summaryWidth,
                        amountColor: Colors.black,
                      ),
                      SizedBox(width: 10),
                      SummaryBloc(
                        label: "You Owe",
                        amount: "250",
                        height: maxHeight * 0.09,
                        isDark: isDark,
                        width: summaryWidth,
                        amountColor: Colors.red,
                      ),
                      SizedBox(width: 10),
                      SummaryBloc(
                        label: "Owed to you",
                        amount: "360",
                        isDark: isDark,
                        width: summaryWidth,
                        height: maxHeight * 0.09,
                        amountColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                _buildTabBar(),
                Expanded(
                  child: IndexedStack(
                    index: selectedTab,
                    children: const [
                      ExpensesTab(),
                      BalancesTab(),
                      MembersTab(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: maxHeight * 0.07,
                    width: maxWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pushNamed(
                          'groupcreateexpensepage',
                          pathParameters: {'id': widget.id},
                        );
                      },
                      child: Text("+ Add expense"),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    const labels = ['Expenses', 'Balances', 'Members'];
    return Row(
      children: List.generate(labels.length, (i) {
        final isActive = selectedTab == i;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedTab = i),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        isActive ? const Color(0xFFFF6B00) : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                labels[i],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                  color:
                      isActive
                          ? const Color(0xFFFF6B00)
                          : const Color(0xFFAAAAAA),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

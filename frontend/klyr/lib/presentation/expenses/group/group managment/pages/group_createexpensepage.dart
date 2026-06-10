import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klyr/data/localdb/profiledb.dart';
import 'package:klyr/data/model/expense_category.dart';
import 'package:klyr/data/model/group.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/bloc/group_managment_bloc.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/bloc/group_managment_event.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/bloc/group_mangment_state.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/widgets/expense_tabs.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/widgets/splitsummary_row.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_amount_card.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_category_grid.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_field_label.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_text_field.dart';
import 'package:klyr/theme/app_theme.dart';

class GroupCreateexpensepage extends StatefulWidget {
  final String id;
  const GroupCreateexpensepage({super.key, required this.id});

  @override
  State<GroupCreateexpensepage> createState() => _GroupCreateexpensepageState();
}

class _GroupCreateexpensepageState extends State<GroupCreateexpensepage> {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  Map<String, TextEditingController> _memberControllers = {};

  int _selectedCategoryIndex = 0;
  DateTime? _selectedDate;
  late final Group group;
  String paidBy = "";
  String currentUserEmail = "";
  int selectedTab = 0;

  @override
  void initState() {
    context.read<GroupManagmentBloc>().add(GetGroupEvent(id: widget.id));
    _initPaidBy();
    _amountController.addListener(
      () => setState(() {
        _onAmountChanged();
      }),
    );
    super.initState();
  }

  Future<void> _initPaidBy() async {
    final profile = await ProfileStorage.getProfile();
    final email = profile?['email'] as String? ?? '';
    setState(() {
      paidBy = email;
      currentUserEmail = email;
    });
  }

  void _onAmountChanged() {
    setState(() {});
    _updateEqualSplits();
  }

  void _updateEqualSplits() {
    if (_memberControllers.isEmpty) return;
    final total = double.tryParse(_amountController.text.trim()) ?? 0.0;
    final share = total / _memberControllers.length;
    for (final c in _memberControllers.values) {
      c.text = share.toStringAsFixed(2);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked == null) return;
    setState(() {
      _selectedDate = picked;
      _dateController.text =
          '${picked.day.toString().padLeft(2, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.year}';
    });
  }

  String getInitials(String email) {
    return email.substring(0, 2).toUpperCase();
  }

  void _initMemberControllers(List<String> members) {
    for (final c in _memberControllers.values) {
      c.dispose();
    }

    _memberControllers = {
      for (final email in members)
        email: TextEditingController(text: '0.00')
          ..addListener(() => setState(() {})),
    };
    _updateEqualSplits();
  }

  String _sum() {
    double sum = 0.00;
    for (final amount in _memberControllers.values) {
      sum += double.tryParse(amount.text.trim()) ?? 0.00;
    }
    return sum.toStringAsFixed(2);
  }

  @override
  void dispose() {
    for (final c in _memberControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final pageBg =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final labelColor = isDark ? AppColors.darkSubText : const Color(0xFF6B6B6B);
    final fieldBg =
        isDark ? AppColors.darkCard : const Color.fromARGB(255, 226, 223, 223);
    final fieldText = isDark ? Colors.white : AppColors.lightText;
    final fieldHint =
        isDark
            ? Colors.white.withValues(alpha: 0.45)
            : AppColors.lightSubText.withValues(alpha: 0.7);
    final amountCardBg =
        isDark
            ? AppColors.primary.withValues(alpha: 0.12)
            : const Color(0xFFFFF0E6);

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: pageBg,
      body: BlocConsumer<GroupManagmentBloc, GroupMangmentState>(
        listener: (context, state) {
          if (state is GroupMangmentLoadedState) {
            group = state.group;

            _initMemberControllers(group.members!);
          }
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final double maxWidth = constraints.maxWidth;
              final double maxHeight = constraints.maxHeight;
              final horizontal = maxWidth > 600 ? maxWidth * 0.15 : 16.0;
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          horizontal,
                          16,
                          horizontal,
                          16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ExpenseAmountCard(
                              controller: _amountController,
                              cardBg: amountCardBg,
                              fieldBg: fieldBg,
                              fieldText: fieldText,
                              fieldHint: fieldHint,
                            ),
                            const SizedBox(height: 20),
                            ExpenseFieldLabel(text: 'title', color: labelColor),
                            const SizedBox(height: 8),
                            ExpenseTextField(
                              controller: _titleController,
                              hint: 'e.g. Netflix subscription',
                              fieldBg: fieldBg,
                              fieldText: fieldText,
                              fieldHint: fieldHint,
                            ),
                            const SizedBox(height: 20),
                            ExpenseFieldLabel(
                              text: 'category',
                              color: labelColor,
                            ),
                            const SizedBox(height: 10),
                            ExpenseCategoryGrid(
                              categories: expenseCategories,
                              selectedIndex: _selectedCategoryIndex,
                              isDark: isDark,
                              onSelected:
                                  (i) => setState(
                                    () => _selectedCategoryIndex = i,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ExpenseFieldLabel(
                                        text: 'date',
                                        color: labelColor,
                                      ),
                                      const SizedBox(height: 8),
                                      ExpenseTextField(
                                        controller: _dateController,
                                        hint: 'dd-mm-yyyy',
                                        readOnly: true,
                                        onTap: _pickDate,
                                        fieldBg: fieldBg,
                                        fieldText: fieldText,
                                        fieldHint: fieldHint,
                                        suffix: Icon(
                                          Icons.calendar_today_outlined,
                                          size: 18,
                                          color: fieldHint,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                horizontal,
                                16,
                                horizontal,
                                16,
                              ),
                              child: Row(
                                children: [
                                  Text("Paid By"),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap:
                                        () => _showPaidBySheet(context, isDark),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        6,
                                        5,
                                        12,
                                        5,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            isDark
                                                ? const Color(0xFF111111)
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                            radius: 11,
                                            backgroundColor: const Color(
                                              0xFFCC5500,
                                            ),
                                            child: Text(
                                              getInitials(paidBy),
                                              style: const TextStyle(
                                                color: Color(0xFFFF8C3A),
                                                fontSize: 8,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            paidBy == currentUserEmail
                                                ? "You"
                                                : paidBy,
                                            style: TextStyle(
                                              color:
                                                  isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontSize: 13,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Color(0xFFAAAAAA),
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BuildExpenseTab(
                              isDark: isDark,
                              height: maxHeight * 0.05,
                              width: maxWidth,
                              selectedTab: selectedTab,
                              onEqual: () {
                                setState(() {
                                  selectedTab = 0;
                                });
                              },
                              onCustom: () {
                                setState(() {
                                  selectedTab = 1;
                                });
                              },
                            ),
                            SplitSummaryRow(
                              sum: _sum(),
                              total: _amountController.text.trim(),
                              isDark: isDark,
                            ),
                            IndexedStack(
                              index: selectedTab,
                              children: [
                                EqualTabs(
                                  members: _memberControllers,
                                  isDark: isDark,
                                  maxHeight: maxHeight,
                                  maxWidth: maxWidth,
                                  amount:
                                      double.tryParse(
                                        _amountController.text.trim(),
                                      ) ??
                                      0.00,
                                ),
                                CustomTabs(
                                  members: _memberControllers,
                                  isDark: isDark,
                                  maxHeight: maxHeight,
                                  maxWidth: maxWidth,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: (){}, child: Text("Submit"))
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showPaidBySheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF111111) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // handle
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF333333),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // title
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'WHO PAID?',
                  style: TextStyle(
                    color: Color(0xFFAAAAAA),
                    fontSize: 11,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
            // members list
            ...group.members!.map((email) {
              final isSelected = email == paidBy;
              return GestureDetector(
                onTap: () {
                  setState(() => paidBy = email);
                  Navigator.pop(context);
                },
                child: Container(
                  color:
                      isSelected
                          ? (isDark ? const Color(0xFF1A0A00) : Colors.white)
                          : Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: const Color(0xFFCC5500),
                        child: Text(
                          getInitials(email),
                          style: const TextStyle(
                            color: Color(0xFFFF8C3A),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              email,
                              style: TextStyle(
                                color:
                                    isSelected
                                        ? (isDark ? Colors.white : Colors.black)
                                        : const Color(0xFFAAAAAA),
                                fontSize: 13,
                              ),
                            ),
                            if (email == currentUserEmail) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1A0A00),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: const Color(0xFFCC5500),
                                  ),
                                ),
                                child: const Text(
                                  'you',
                                  style: TextStyle(
                                    color: Color(0xFFFF6B00),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (isSelected)
                        Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF6B00),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 13,
                          ),
                        )
                      else
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF2A2A2A)),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

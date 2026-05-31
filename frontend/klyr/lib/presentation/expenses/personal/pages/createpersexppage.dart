import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:klyr/presentation/auth/bloc/authbloc.dart';
import 'package:klyr/presentation/auth/bloc/authevent.dart';
import 'package:klyr/presentation/expenses/personal/bloc/expense_bloc.dart';
import 'package:klyr/presentation/expenses/personal/bloc/expense_event.dart';
import 'package:klyr/presentation/expenses/personal/bloc/expense_state.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_amount_card.dart';
import 'package:klyr/data/model/expense_category.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_category_grid.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_field_label.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_submit_button.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_text_field.dart';
import 'package:klyr/theme/app_theme.dart';

class CreatepersonalExpensepage extends StatefulWidget {
  const CreatepersonalExpensepage({super.key});

  @override
  State<CreatepersonalExpensepage> createState() =>
      _CreatepersonalExpensepageState();
}

class _CreatepersonalExpensepageState extends State<CreatepersonalExpensepage> {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();

  int _selectedCategoryIndex = 0;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    for (final c in [_amountController, _titleController, _dateController]) {
      c.addListener(_onFieldChanged);
    }
  }

  @override
  void dispose() {
    for (final c in [_amountController, _titleController, _dateController]) {
      c
        ..removeListener(_onFieldChanged)
        ..dispose();
    }
    super.dispose();
  }

  void _onFieldChanged() => setState(() {});

  bool get _canSubmit {
    final amount = double.tryParse(_amountController.text.trim());
    return amount != null &&
        amount > 0 &&
        _titleController.text.trim().isNotEmpty;
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

  void _submit() {
    if (!_canSubmit) return;
    context.read<ExpenseBloc>().add(
      CreateExpenseEvent(
        title: _titleController.text.trim(),
        amount: _amountController.text.trim(),
        currency: 'INR',
        categoryIndex: _selectedCategoryIndex,
        date: _selectedDate ?? DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

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
      backgroundColor: pageBg,
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
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
                        ExpenseFieldLabel(text: 'category', color: labelColor),
                        const SizedBox(height: 10),
                        ExpenseCategoryGrid(
                          categories: expenseCategories,
                          selectedIndex: _selectedCategoryIndex,
                          isDark: isDark,
                          onSelected:
                              (i) => setState(() => _selectedCategoryIndex = i),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      ],
                    ),
                  ),
                ),
                BlocConsumer<ExpenseBloc, ExpenseState>(
                  listener: (context, state) {
                    if (state is ExpenseUnauthState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                      context.read<Authbloc>().add(LogoutEvent());
                    } else if (state is ExpenseFailureState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is ExpenseCreatedState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                      context.pop();
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontal,
                        8,
                        horizontal,
                        16,
                      ),
                      child:
                          state is ExpenseLoadingState
                              ? const Center(child: CircularProgressIndicator())
                              : ExpenseSubmitButton(
                                enabled:
                                    _canSubmit && state is! ExpenseLoadingState,
                                isDark: isDark,
                                onPressed: _submit,
                              ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

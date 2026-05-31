import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_text_field.dart';
import 'package:klyr/theme/app_theme.dart';

class ExpenseAmountCard extends StatelessWidget {
  const ExpenseAmountCard({
    super.key,
    required this.controller,
    required this.cardBg,
    required this.fieldBg,
    required this.fieldText,
    required this.fieldHint,
    this.readOnly,
  });

  final TextEditingController controller;
  final Color cardBg;
  final Color fieldBg;
  final Color fieldText;
  final Color fieldHint;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'enter amount',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ExpenseTextField(
                  controller: controller,
                  hint: '0.00',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  readOnly: readOnly ?? false,
                  fieldBg: fieldBg,
                  fieldText: fieldText,
                  fieldHint: fieldHint,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

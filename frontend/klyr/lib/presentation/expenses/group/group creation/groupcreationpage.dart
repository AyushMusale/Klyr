import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:klyr/presentation/expenses/personal/widgets/expense_submit_button.dart';
import 'package:klyr/theme/app_theme.dart';

class GroupCreationPage extends StatelessWidget {
  const GroupCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = isDark ? AppColors.darkBackground : const Color(0xFFF4F4F4);
    final labelColor =
        isDark ? Colors.white.withValues(alpha: 0.45) : const Color(0xFF888888);
    final fieldBg = isDark ? AppColors.darkCard : Colors.white;
    final fieldBorder =
        isDark ? AppColors.darkBorder : Colors.black.withValues(alpha: 0.08);
    final fieldText = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final fieldHint =
        isDark ? Colors.white.withValues(alpha: 0.35) : const Color(0xFFB0B0B0);
    final iconColor =
        isDark ? Colors.white.withValues(alpha: 0.4) : const Color(0xFFAAAAAA);
    final hintColor =
        isDark ? Colors.white.withValues(alpha: 0.35) : const Color(0xFFAAAAAA);
    final titleColor = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final subtitleColor =
        isDark ? Colors.white.withValues(alpha: 0.5) : const Color(0xFF888888);
    final badgeBg =
        isDark
            ? Colors.white.withValues(alpha: 0.08)
            : AppColors.primary.withValues(alpha: 0.12);

    InputDecoration fieldDecoration({
      required String hint,
      required IconData prefixIcon,
      Widget? suffix,
    }) {
      return InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: fieldHint, fontSize: 15),
        filled: true,
        fillColor: fieldBg,
        prefixIcon: Icon(prefixIcon, size: 20, color: iconColor),
        suffixIcon:
            suffix == null
                ? null
                : Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: suffix,
                ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: fieldBorder),
        ),
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
                            Text(
                              'GROUP NAME',
                              style: TextStyle(
                                color: labelColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              style: TextStyle(color: fieldText, fontSize: 15),
                              cursorColor: AppColors.primary,
                              decoration: fieldDecoration(
                                hint: 'e.g. Goa Trip, Flatmates...',
                                prefixIcon: Icons.groups_outlined,
                              ),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              'ADD MEMBERS',
                              style: TextStyle(
                                color: labelColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: fieldText, fontSize: 15),
                              cursorColor: AppColors.primary,
                              decoration: fieldDecoration(
                                hint: 'Enter email address...',
                                prefixIcon: Icons.mail_outline_rounded,
                                suffix: Material(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                  child: const SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: Colors.white,
                                      size: 22,
                                    ),
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: fieldBorder),
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 22,
                                    backgroundColor: AppColors.primary,
                                    child: Text(
                                      'You',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'You',
                                          style: TextStyle(
                                            color: titleColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Creator · always included',
                                          style: TextStyle(
                                            color: subtitleColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: badgeBg,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'Admin',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                      child: ExpenseSubmitButton(
                        enabled: true,
                        isDark: isDark,
                        text: 'Create Group',
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

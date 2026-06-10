import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:klyr/presentation/expenses/navigation/widgets/navigation_selection_card.dart';

class ExpenseNavigationPage extends StatelessWidget {
  const ExpenseNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg =
        isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : const Color(0xFFF4F4F4);
    return Scaffold(
      backgroundColor: pageBg,
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final hPad = w > 600 ? w * 0.12 : 22.0;

              final containerW = (w - hPad * 2).clamp(260.0, 420.0);

              final gap = 14.0;
              final topCardW = ((containerW - 48 - gap) / 2).clamp(
                110.0,
                160.0,
              );
              final cardH = (topCardW * 1.05).clamp(120.0, 170.0);
              final bottomCardW = (topCardW).clamp(120.0, 170.0);

              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 44),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: topCardW,
                          height: cardH,
                          child: SelectionCard(
                            onTap: () {
                              context.pushNamed('viewallgroupspage');
                            },
                            isDark: isDark,
                            icon: Icons.groups_outlined,
                            label: "Group",
                          ),
                        ),
                        SizedBox(width: gap),
                        SizedBox(
                          width: topCardW,
                          height: cardH,
                          child: SelectionCard(
                            onTap: () {
                              context.pushNamed('personalexepensepage');
                            },
                            isDark: isDark,
                            icon: Icons.person_outline_rounded,
                            label: "Personal",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: bottomCardW,
                        height: cardH,
                        child: SelectionCard(
                          onTap: () {},
                          isDark: isDark,
                          icon: Icons.person_pin_circle_outlined,
                          label: "Individual",
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

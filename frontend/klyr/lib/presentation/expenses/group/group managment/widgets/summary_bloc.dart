import 'package:flutter/material.dart';

class SummaryBloc extends StatelessWidget {
  final String label;
  final String amount;
  final double width;
  final bool isDark;
  final Color amountColor;
  final double height;
  const SummaryBloc({
    super.key,
    required this.label,
    required this.amount,
    required this.width,
    required this.height,
    required this.isDark,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey : Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            "\$ $amount",
            style: TextStyle(
              color: amountColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

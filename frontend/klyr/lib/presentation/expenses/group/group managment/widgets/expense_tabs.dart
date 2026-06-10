import 'package:flutter/material.dart';
import 'package:klyr/theme/app_theme.dart';

class BuildExpenseTab extends StatelessWidget {
  final bool isDark;
  final double width;
  final double height;
  final int selectedTab;
  final GestureTapCallback onEqual;
  final GestureTapCallback onCustom;
  const BuildExpenseTab({
    super.key,
    required this.isDark,
    required this.height,
    required this.width,
    required this.selectedTab,
    required this.onEqual,
    required this.onCustom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onEqual,
            child: Container(
              width: width * 0.3,
              decoration: BoxDecoration(
                color: selectedTab == 0 ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Equal",
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onCustom,
            child: Container(
              width: width * 0.3,
              decoration: BoxDecoration(
                color: selectedTab == 1 ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Custom",
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShareAmountTile extends StatelessWidget {
  final bool isDark;
  final double maxHeight;
  final double maxWidth;
  final String initials;
  final String email;
  final TextEditingController controller;
  final bool readOnly;
  final double value;
  const ShareAmountTile({
    super.key,
    required this.isDark,
    required this.maxHeight,
    required this.maxWidth,
    required this.initials,
    required this.email,
    required this.controller,
    this.readOnly = true,
    this.value = 0.00,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: maxHeight * 0.05,
      width: maxWidth,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: const Color(0xFFCC5500),
            child: Text(
              initials,
              style: const TextStyle(
                color: Color(0xFFFF8C3A),
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              email,
              style: TextStyle(
                color: isDark ? AppColors.primary : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: maxWidth * 0.2,
            height: maxHeight * 0.044,
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),

              decoration: InputDecoration(
                fillColor: isDark ? Colors.grey : Colors.grey.shade200,
                filled: true,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: value.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EqualTabs extends StatelessWidget {
  final Map<String, TextEditingController> members;
  final bool isDark;
  final double maxHeight;
  final double maxWidth;
  final double amount;
  const EqualTabs({
    super.key,
    required this.members,
    required this.isDark,
    required this.maxHeight,
    required this.maxWidth,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final emails = members.keys.toList();

    return Column(
      children: List.generate(emails.length, (index) {
        final email = emails[index];
        return Padding(
          padding:EdgeInsets.only(bottom: 10),
          child: ShareAmountTile(
            isDark: isDark,
            maxHeight: maxHeight,
            maxWidth: maxWidth,
            initials:
                email.length >= 2 ? email.substring(0, 2).toUpperCase() : '??',
            email: email,
            controller: members[email]!,
            readOnly: true,
            value: amount / members.length,
          ),
        );
      }),
    );
  }
}

class CustomTabs extends StatelessWidget {
  final Map<String, TextEditingController> members;
  final bool isDark;
  final double maxHeight;
  final double maxWidth;
  const CustomTabs({
    super.key,
    required this.members,
    required this.isDark,
    required this.maxHeight,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final emails = members.keys.toList();

    return Column(
      children: List.generate(emails.length, (index) {
        final email = emails[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ShareAmountTile(
            isDark: isDark,
            maxHeight: maxHeight,
            maxWidth: maxWidth,
            initials:
                email.length >= 2 ? email.substring(0, 2).toUpperCase() : '??',
            email: email,
            controller: members[email]!,
            readOnly: false,
          ),
        );
      }),
    );
  }
}

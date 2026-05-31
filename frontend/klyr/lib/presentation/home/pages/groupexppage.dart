import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:klyr/presentation/home/widgets/activity_list_item.dart';

class Groupexppage extends StatefulWidget {
  final List items;
  const Groupexppage({super.key, required this.items});

  @override
  State<Groupexppage> createState() => _GroupexppageState();
}

class _GroupexppageState extends State<Groupexppage> {
  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Center(child: Text("No Expense added"));
    } else {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.items.length,
        itemBuilder: (context, i) {
          return ActivityListItem(
            item: widget.items[i],
            fn: () {
              context.push('/showpersonalexpense/${widget.items[i].id}');
            },
          );
        },
      );
    }
  }
}

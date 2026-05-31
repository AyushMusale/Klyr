import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:klyr/presentation/home/widgets/activity_list_item.dart';

class Personalexppage extends StatefulWidget {
  final List items;
  const Personalexppage({super.key, required this.items});

  @override
  State<Personalexppage> createState() => _PersonalexppageState();
}

class _PersonalexppageState extends State<Personalexppage> {
  @override
  Widget build(BuildContext context) {
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

import 'package:flutter/material.dart';

class ExpensesTab extends StatelessWidget {
  //final List<GroupExpense> expense;
  const ExpensesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (builder, context){
      return Text("No exoense yet");
    });
  }
}

class BalancesTab extends StatelessWidget {
  const BalancesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class MembersTab extends StatelessWidget {
  const MembersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
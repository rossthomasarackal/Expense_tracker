import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';


class ExpensesItems extends StatelessWidget {
 const ExpensesItems(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(child:  Padding(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(expense.title, style:Theme.of(context).textTheme.titleLarge,),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(expense.amount.toStringAsFixed(2)),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcon[expense.category]),
                  const SizedBox(width: 5),
                  Text(expense.formattedDate),
                ],
              )
            ],
          ),
        ],
      ),
    ),) ;
  }
}

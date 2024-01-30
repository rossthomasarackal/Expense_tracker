import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses =[
    Expense(title: 'Film', amount: 200, date: DateTime.now(), category:Category.entertainment ),
    Expense(title: 'Dress', amount: 1000, date: DateTime.now(), category: Category.shopping),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context, builder:(ctx){
      return  NewExpense(onAddExpense: addExpenses,);
    });
  }

  void addExpenses(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
    Navigator.pop(context);
  }
  void removeExpenses(Expense expense){
    final expenseIndex= _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration:const  Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: (){
                setState(() {
                  _registeredExpenses.insert(expenseIndex, expense);
                });
              },
            ),
            content: const Text('Expense Deleted')));
  }
  @override
  Widget build(context){
    //print(MediaQuery.of(context).size.width);
    final width=MediaQuery.of(context).size.width;

    Widget mainContent= const Center(
      child: Text('No expenses found. Try adding some'),);
    if(_registeredExpenses.isNotEmpty){
    mainContent= ExpensesList(expenses: _registeredExpenses, onRemoveExpenses: removeExpenses);
    }
    return  Scaffold(
      appBar: AppBar(
        title: const Text(' Expense Tracker '),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),


      body: width>600 ?
      Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ) :
       Row( children: [
         Expanded(child: Chart(expenses: _registeredExpenses)),
         Expanded(child: mainContent),
       ],
       ),
    );
  }
}
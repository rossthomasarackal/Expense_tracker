import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController= TextEditingController();
  final amountController= TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.shopping;


  void presentDatePicker() async {
    final now= DateTime.now();
    final firstDate= DateTime(now.year-1, now.month,now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate= pickedDate;
    });
  }

  void submitExpenseData(){
    final enteredAmount= double.tryParse(amountController.text);
    final amountIsInvalid= enteredAmount==null || enteredAmount<=0;
    if(titleController.text.trim().isEmpty || amountIsInvalid || selectedDate==null){
      showDialog(context: context, builder: (ctx)=>
          AlertDialog(
            title: const Text('Invalid  Input'),
            content: const Text(' please enter the input') ,
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(ctx);
              }, child: const Text('Okay')),
            ],
          )
      );
      return ;
    }

    widget.onAddExpense(
        Expense(
            title: titleController.text,
            amount: enteredAmount,
            date: selectedDate!,
            category: selectedCategory));


  }

  @override
  void dispose(){
    super.dispose();
    titleController.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(padding:const  EdgeInsets.fromLTRB(16,48,16,16) ,
    child: Column(
        children: [
          TextField(
            controller: titleController ,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),),

          Row(
            children: [
               Expanded(
                child: TextField(
                  controller: amountController ,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(prefixText: '\$ ',label: Text('Amount')),),
              ),
              const SizedBox(width: 10,),
               Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text( selectedDate==null ? 'No Date Selected' : formatter.format(selectedDate!)),
                    IconButton(onPressed: (){ presentDatePicker();}, icon:const Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ],
          ),


          const SizedBox(height: 10),
          Row(
            children: [
              DropdownButton(
                value: selectedCategory,
                  items: Category.values.map(
                      (Category) => DropdownMenuItem(
                          value: Category,
                          child: Text(Category.name.toUpperCase()))).toList(),
                  onChanged: (value){
                if(value==null){
                  return;
                }
             setState(() {
               selectedCategory=value;
             });
              }),
              const Spacer(),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('Cancel')),
              ElevatedButton(onPressed: (){
                submitExpenseData();
                print(titleController.text);
                print(amountController.text);
              }, child: const Text('Save Expense')),
            ],
          )
        ],
    ),
    );
  }
}

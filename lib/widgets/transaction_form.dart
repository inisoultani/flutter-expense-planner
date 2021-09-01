import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleInputController = TextEditingController();
  final amountInputController = TextEditingController();
  final Function createNewTransaction;

  TransactionForm({required this.createNewTransaction});

  void submitData() {
    
    var title = titleInputController.text;
    var amount = double.parse(amountInputController.text);

    if (title.isEmpty || amount <= 0) {
      print('empty title : $title or small amount : $amount');
      return;
    }

    this.createNewTransaction(title, amount);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            TextField(
              controller: titleInputController,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => this.submitData(),
            ),
            TextField(
              controller: amountInputController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => this.submitData(),
            ),
            FlatButton(
              onPressed: () => this.submitData(),
              child: Text('Submit Transaction'),
              textColor: Colors.teal,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

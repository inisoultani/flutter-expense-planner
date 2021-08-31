import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleInputController = TextEditingController();
  final amountInputController = TextEditingController();
  final Function createNewTransaction;

  TransactionForm({required this.createNewTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            TextField(
              controller: titleInputController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: amountInputController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            FlatButton(
              onPressed: () => this.createNewTransaction(
                titleInputController.text,
                double.parse(amountInputController.text)
              ),
              child: Text('Submit Transaction'),
              textColor: Colors.teal,
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_flat_button.dart';
import 'dart:io';

class TransactionForm extends StatefulWidget {
  final Function createNewTransaction;

  TransactionForm({required this.createNewTransaction});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleInputController = TextEditingController();
  final amountInputController = TextEditingController();
  DateTime? _pickedDate;

  void _submitData() {
    var title = titleInputController.text;
    var amount = double.parse(amountInputController.text);

    if (title.isEmpty || amount <= 0 || _pickedDate == null) {
      print(
          'empty title : $title or small amount : $amount or empty date : $_pickedDate');
      return;
    }

    this.widget.createNewTransaction(title, amount, _pickedDate);

    // close bottom sheet automatically when done submit
    Navigator.of(context).pop();
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 7)),
            lastDate: DateTime.now().add(Duration(days: 7)))
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        this._pickedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: titleInputController,
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => this._submitData(),
              ),
              TextField(
                controller: amountInputController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => this._submitData(),
              ),
              Row(
                children: [
                  Text(this._pickedDate == null
                      ? 'No date choosed'
                      : 'Choosed Date : ${DateFormat.yMEd().add_jms().format(this._pickedDate!)}'),
                  AdaptiveButton(text: 'Choose Date', handler: this._presentDatePicker)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              ElevatedButton(
                onPressed: () => this._submitData(),
                child: Text('Submit Transaction'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30),
        ),
      ),
    );
  }
}

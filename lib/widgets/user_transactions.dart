import 'package:flutter/material.dart';
import './transaction_list.dart';
import './transaction_form.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  UserTransactionsState createState() => UserTransactionsState();
}

class UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      amount: 21.22,
      title: 'grocery',
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      amount: 10.21,
      title: 'pharmacy',
      date: DateTime.now(),
    )
  ];


  void _createNewTransaction(String title, double amount) {
    setState(() {
      _userTransactions.add(Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        title: title,
        amount: amount,
      ));
    });
  }


void openModalBottomSheetNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return TransactionForm(createNewTransaction: this._createNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          child: Container(
            child: Text('Card Widget'),
            width: double.infinity,
            height: 100,
          ),
          elevation: 1,
          color: Colors.teal[50],
        ),
        // TransactionForm(createNewTransaction: this._createNewTransaction,),
        TransactionList(userTransactions: this._userTransactions,),
      ],
    );
  }
}

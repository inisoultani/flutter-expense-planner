import 'package:flutter/material.dart';
import './transaction_list.dart';
import './transaction_form.dart';
import '../models/transaction.dart';
import '../widgets/chart.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  UserTransactionsState createState() => UserTransactionsState();
}

class UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   amount: 21.22,
    //   title: 'grocery',
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   amount: 10.21,
    //   title: 'pharmacy',
    //   date: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransaction {
    return this._userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void createNewTransaction(String title, double amount, DateTime trxDateTime) {
    setState(() {
      _userTransactions.add(Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: trxDateTime != null ? trxDateTime : DateTime.now(),
        title: title,
        amount: amount,
      ));
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void openModalBottomSheetNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return TransactionForm(
              createNewTransaction: this.createNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Chart(
          recentTransactions: this._recentTransaction,
        ),
        TransactionList(
          userTransactions: this._userTransactions,
          deleteTransaction: this._deleteTransaction,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import './transaction_list.dart';
import './transaction_form.dart';
import '../models/transaction.dart';
import '../widgets/chart.dart';

class UserTransactions extends StatefulWidget {
  final double appBarHeight = 0.0;
  const UserTransactions({Key? key, double? appBarHeight}) : super(key: key);

  @override
  UserTransactionsState createState() => UserTransactionsState();
}

class UserTransactionsState extends State<UserTransactions> {
  bool _showChart = true;
  final List<Transaction> _userTransactions = [];

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

  Widget landscapeLayout(double bottomNavbarHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Show Chart', style: Theme.of(context).textTheme.title,),
            Card(
              child: Switch(
                value: this._showChart,
                onChanged: (val) {
                  setState(() {
                    this._showChart = val;
                  });
              }),
            )
          ],
        ),
        this._showChart
            ? Container(
                height:
                    (MediaQuery.of(context).size.height - widget.appBarHeight) *
                        0.5,
                child: Chart(
                  recentTransactions: this._recentTransaction,
                ),
              )
            : Container(
                height: (MediaQuery.of(context).size.height -
                        widget.appBarHeight -
                        bottomNavbarHeight) *
                    0.79,
                child: TransactionList(
                  userTransactions: this._userTransactions,
                  deleteTransaction: this._deleteTransaction,
                ),
              ),
      ],
    );
  }

  Widget potraitLayout(double bottomNavbarHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height:
              (MediaQuery.of(context).size.height - widget.appBarHeight) * 0.21,
          child: Chart(
            recentTransactions: this._recentTransaction,
          ),
        ),
        Container(
          height: (MediaQuery.of(context).size.height -
                  widget.appBarHeight -
                  bottomNavbarHeight) *
              0.79,
          child: TransactionList(
            userTransactions: this._userTransactions,
            deleteTransaction: this._deleteTransaction,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double bottomNavbarHeight = 175;
    return isLandscape
        ? landscapeLayout(bottomNavbarHeight)
        : potraitLayout(bottomNavbarHeight);
  }
}

import 'package:flutter/material.dart';
import 'widgets/user_transactions.dart';

import './widgets/transaction_list.dart';
import './widgets//transaction_form.dart';
import '../models/transaction.dart';

void main() => runApp(ExpensePlannerApp());

class ExpensePlannerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.tealAccent[400],
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.teal[400]
          )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final userTransactionsGlobalKey = GlobalKey<UserTransactionsState>();

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
          return TransactionForm(createNewTransaction: userTransactionsGlobalKey.currentState!.createNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: [
          IconButton(
            onPressed: () => this.openModalBottomSheetNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: UserTransactions(key: userTransactionsGlobalKey,),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => userTransactionsGlobalKey.currentState!.openModalBottomSheetNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings))
        ],
      ),
    );
  }
}

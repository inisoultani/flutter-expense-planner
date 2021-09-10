import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'widgets/user_transactions.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import './widgets//transaction_form.dart';
import '../models/transaction.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(ExpensePlannerApp());
}

class ExpensePlannerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //return !Platform.isIOS ? buildMaterialApp() : buildCupertinoApp();
    return buildMaterialApp();
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.tealAccent[400],
        fontFamily: 'Quicksand',
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.teal[400]),
            button: TextStyle(color: Colors.white)),
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
              focusColor: Colors.red,
              buttonColor: Colors.red,
              height: 30,
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

  CupertinoApp buildCupertinoApp() {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(

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
          return TransactionForm(
              createNewTransaction:
                  userTransactionsGlobalKey.currentState!.createNewTransaction);
        });
  }

  CupertinoPageScaffold iosDeviceScaffold(Widget child) {
    return CupertinoPageScaffold(
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = !Platform.isIOS ?  AppBar(
      title: Text('Flutter App'),
      actions: [
        IconButton(
          onPressed: () => this.openModalBottomSheetNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    )  as  PreferredSizeWidget
    :
    CupertinoNavigationBar(
      middle: Text('Flutter App'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => this.openModalBottomSheetNewTransaction(context),
          )
        ],),
    );

    var pageBody = SafeArea(child: SingleChildScrollView(
        child: UserTransactions(
          key: userTransactionsGlobalKey,
          appBarHeight:
              appBar.preferredSize.height + MediaQuery.of(context).padding.top,
        ),
      )
    );

    return  !Platform.isIOS ? 
    Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButton: !Platform.isIOS
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => userTransactionsGlobalKey.currentState!
                  .openModalBottomSheetNewTransaction(context),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: !Platform.isIOS
          ? BottomNavigationBar(
              items: [
                BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
                BottomNavigationBarItem(
                    label: 'Settings', icon: Icon(Icons.settings))
              ],
            )
          : Container(
              height: 0,
            ),
    )
    :
    CupertinoPageScaffold(
      navigationBar: appBar as ObstructingPreferredSizeWidget,
      child: pageBody,
    );
  }
}

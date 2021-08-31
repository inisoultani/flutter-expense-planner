import 'package:flutter/material.dart';
import 'widgets/user_transactions.dart';

void main() => runApp(ExpensePlannerApp());

class ExpensePlannerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: SingleChildScrollView(child: UserTransactions()),
    );
  }
}

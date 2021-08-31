import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';

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
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      amount: 21.22,
      title: 'grocery',
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      amount: 10.01,
      title: 'pharmacy',
      date: DateTime.now(),
    )
  ];

  List<Card> renderTransactionCards() {
    return transactions
        .map((transaction) => Card(
              child: Row(
                children: [
                  Container(
                    child: Text(
                      '\$${transaction.amount.toString()}',
                      style: TextStyle(
                          color: Colors.teal[50],
                          fontSize: 25,
                          fontWeight: FontWeight.w800),
                    ),
                    width: 110,
                    height: 40,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.teal[400],
                        border: Border.all(color: Colors.teal, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          transaction.title,
                          style: TextStyle(
                            color: Colors.teal[400],
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 5),
                      ),
                      Text(
                        DateFormat.yMEd().add_jms().format(transaction.date),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
              color: Colors.grey[50],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Container(
                  child: Text('Card Row Widget'),
                  height: 20,
                  width: 150,
                  alignment: Alignment.center,
                ),
                elevation: 1,
                color: Colors.greenAccent,
              ),
              Card(
                child: Container(
                  child: Text('Card Row Widget'),
                  height: 40,
                  width: 150,
                  alignment: Alignment.center,
                ),
                elevation: 1,
                color: Colors.greenAccent,
              ),
            ],
          ),
          Card(
            child: Container(
              child: Text('Card Widget'),
              width: double.infinity,
              height: 100,
            ),
            elevation: 1,
            color: Colors.greenAccent,
          ),
          Column(
            children: [
              ...renderTransactionCards(),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

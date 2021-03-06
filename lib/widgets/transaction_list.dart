import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(
      {required this.userTransactions, required this.deleteTransaction});

  List<_TransactionCard> renderTransactionCards() {
    return userTransactions
        .map((transaction) => _TransactionCard(
              key: ValueKey(transaction.id),
              transaction: transaction,
              deleteTransaction: deleteTransaction,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return this.userTransactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'No transaction added yet.',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: ColorFiltered(
                      child: Image.asset('assets/images/waiting-hourglass.png'),
                      colorFilter:
                          ColorFilter.mode(Colors.teal, BlendMode.srcATop)),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            );
          })
        // : ListView.builder(
        //     itemCount: this.userTransactions.length,
        //     itemBuilder: (context, idx) {
        //       print('idx : $idx');
        //       // return _TransactionCard(
        //       //   transaction: this.userTransactions[idx],
        //       // );
        //       return _ListTileCard(
        //         transaction: this.userTransactions[idx],
        //         deleteTransaction: this.deleteTransaction,
        //       );
        //     },
        //   );
        : ListView(
            children: [...this.renderTransactionCards()],
          );
  }
}

class _TransactionCard extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  _TransactionCard(
      {Key? key, required this.transaction, required this.deleteTransaction})
      : super(key: key);

  @override
  __TransactionCardState createState() => __TransactionCardState();
}

class __TransactionCardState extends State<_TransactionCard> {
  final availableColors = [
    Colors.brown,
    Colors.red,
    Colors.lightBlue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.pink,
  ];

  late Color _numberColor;

  @override
  void initState() {
    super.initState();
    _numberColor = availableColors[Random().nextInt(7)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.only(right: 4, left: 4),
                child: Text(
                  '\$${widget.transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: _numberColor,
                      fontSize:
                          widget.transaction.amount.toStringAsFixed(2).length >
                                  6
                              ? 18
                              : 25,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            width: 110,
            height: 40,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.teal, width: 2),
                borderRadius: BorderRadius.circular(5)),
          ),
          Column(
            children: [
              Container(
                child: Text(
                  widget.transaction.title,
                  style: Theme.of(context).textTheme.headline6,
                  // style: TextStyle(
                  //   color: Colors.teal[400],
                  //   fontSize: 17,
                  //   fontWeight: FontWeight.w700,
                  // ),
                ),
                margin: EdgeInsets.only(bottom: 5),
              ),
              Text(
                DateFormat.yMEd().add_jms().format(widget.transaction.date),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    this.widget.deleteTransaction(widget.transaction.id),
              )
            ],
          )
        ],
      ),
      color: Colors.grey[50],
    );
  }
}

class _ListTileCard extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  _ListTileCard({required this.transaction, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  '\$${this.transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.teal[50],
                      fontSize: 25,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat.yMEd().add_jms().format(transaction.date),
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: MediaQuery.of(context).size.width > 360
              ? TextButton.icon(
                  onPressed: () => this.deleteTransaction(transaction.id),
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).errorColor,
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => this.deleteTransaction(transaction.id),
                )),
    );
  }
}

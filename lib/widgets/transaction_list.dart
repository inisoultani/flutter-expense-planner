import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class _TransactionCard extends StatelessWidget {
  final Transaction transaction;

  _TransactionCard({required this.transaction});

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
                  '\$${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.teal[50],
                      fontSize: transaction.amount.toStringAsFixed(2).length > 6 ? 18 : 25,
                      fontWeight: FontWeight.w800),
                ),
              ),
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
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList({required this.userTransactions});

  List<_TransactionCard> renderTransactionCards() {
    return userTransactions
        .map((transaction) => _TransactionCard(
              transaction: transaction,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.43,
      child: this.userTransactions.isEmpty ?
        Column(
          children: [
            Text(
              'No transaction added yet.',
              style: Theme.of(context).textTheme.headline6,
            ),
            ColorFiltered(
              child: Image.asset('assets/images/waiting-hourglass.png'),
              colorFilter: ColorFilter.mode(Colors.teal, BlendMode.srcATop)
            )
           
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        ) 
        :
        ListView.builder(
          itemCount: this.userTransactions.length,
          itemBuilder: (context, idx) {
            print('idx : $idx');
            return _TransactionCard(
              transaction: this.userTransactions[idx],
            );
          },
        ),
    );
  }
}

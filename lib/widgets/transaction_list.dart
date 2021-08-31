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
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList({required this.userTransactions});

  List<_TransactionCard> renderTransactionCards() {
    return userTransactions
        .map((transaction) => _TransactionCard(transaction: transaction,))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.505,
      child: ListView(
        children: [
          Column(
            children: [
              ...this.renderTransactionCards(),
            ],
          ),
        ],
      ),
    );
  }
}

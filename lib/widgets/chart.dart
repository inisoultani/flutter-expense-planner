import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({required this.recentTransactions});

  List<Map<String, Object>> get groupTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (int x = 0; x < this.recentTransactions.length; x++) {
        if (this.recentTransactions[x].date.day == weekDay.day &&
            this.recentTransactions[x].date.month == weekDay.month &&
            this.recentTransactions[x].date.year == weekDay.year) {
          totalSum += this.recentTransactions[x].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    });
  }

  List<Column> renderCharts() {
    return this.groupTransactions.map((group) {
      return Column(
        children: [
          Text(
            'Day'
          ),
          Text(
            '${group['day']}'
          ),
          Text(
            'Total'
          ),
          Text(
             '${group['amount']}'
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        child: Row(
          children: [...renderCharts()],
        ),
        width: double.infinity,
        height: 120,
      ),
      color: Colors.teal[50],
    );
  }
}

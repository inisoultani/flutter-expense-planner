import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

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
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransactions.fold(
        0.0,
        (previousValue, element) =>
            previousValue + double.parse(element['amount'].toString()));
  }

  List<Column> renderCharts() {
    return this.groupTransactions.map((data) {
      return Column(
        children: [
          Text('Day'),
          Text('${data['day']}'),
          Text('Total'),
          Text('${data['amount']}'),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );
    }).toList();
  }

  List<Flexible> renderChartsBar() {
    return this.groupTransactions.map((data) {
      print(
          'amount : ${data['amount'].toString()}, total spending : $totalSpending, result : ${double.parse(data['amount'].toString()) / totalSpending}');
      return Flexible(
        fit: FlexFit.tight,
        child: ChartBar(
          label: data['day'].toString(),
          spendingAmount: double.parse(data['amount'].toString()),
          spendingPctTotal:
             totalSpending > 0.0 ? double.parse(data['amount'].toString()) / totalSpending : totalSpending,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      color: Colors.teal[50],
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [...renderChartsBar()],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        width: double.infinity,
        height: 120,
      ),
    );
  }
}

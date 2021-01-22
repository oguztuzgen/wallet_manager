import 'package:wallet_manager/model/expense.dart';
import 'package:wallet_manager/views/charts/expense_pie_chart.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  List<Expense> transactions;
    
    @override
    _GraphScreenState createState() => _GraphScreenState();

    GraphScreen({Key key, @required this.transactions}) : super(key: key);
}

class _GraphScreenState extends State<GraphScreen> {
  // state variables-

  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty ? Center(
      child: Text("much empty such wow"),
    ) : ExpensePieChart(transactions: widget.transactions);
  }
}
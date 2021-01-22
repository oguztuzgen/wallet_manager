import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartTest extends StatefulWidget {
  @override
  _ChartTestState createState() => _ChartTestState();
}

class _ChartTestState extends State<ChartTest> {
  List<charts.Series<Expense, String>> _seriesPieData;
  _prepareData() {
    var data = [
      Expense(description: 'Paid rent', percentage: 2.0, time: DateTime.now(), category: 'Necessary', color: Colors.amber),
      Expense(description: 'Eat hamburger', percentage: 12.0, time: DateTime.now(), category: 'Necessary', color: Colors.green),
      Expense(description: 'Bought drinks', percentage: 15.0, time: DateTime.now(), category: 'Necessary', color: Colors.blue),
      Expense(description: 'Bought books', percentage: 25.0, time: DateTime.now(), category: 'Necessary', color: Colors.red),
    ];

    _seriesPieData.add(
      charts.Series(
        data:  data,
        domainFn: (Expense expense, _) => expense.description,
        measureFn: (Expense expense, _) => expense.percentage,
        colorFn: (Expense expense, _) => charts.ColorUtil.fromDartColor(expense.color),
        id: 'Daily expenses',
        labelAccessorFn: (Expense row, _) => '${row.percentage}',
        displayName: 'Cool'
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesPieData = List<charts.Series<Expense, String>>();
    _prepareData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Git gud"),
        centerTitle: true,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: charts.PieChart(
              _seriesPieData,
              animate: true,
              animationDuration: Duration(seconds: 1),
            )
          ),
        ]
      ),
    );
  }
}


class Expense {
  String description;
  double percentage;
  DateTime time;
  String category;
  Color color;

  Expense ({this.description, this.percentage, this.time, 
  this.category, this.color});
}
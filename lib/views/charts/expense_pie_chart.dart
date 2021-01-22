import 'package:wallet_manager/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:random_color/random_color.dart';


class ExpensePieChart extends StatefulWidget {
  List<Expense> transactions;

  @override
  _ExpensePieChartState createState() => _ExpensePieChartState();

  ExpensePieChart({Key key, @required this.transactions}) : super(key: key);

}

class _ExpensePieChartState extends State<ExpensePieChart> {
  // TODO ADD FILTERS AND TIME SPAN
  List<charts.Series<Expense, String>> _seriesPieData;
  _prepareData() {
    RandomColor _randomColor = RandomColor();
    List<Expense> data = List<Expense>();
    _seriesPieData = new List<charts.Series<Expense, String>>();

    print("\nBefore set unique");
    print(widget.transactions);
    _setTransactionListCategoryUnique(); // unique categories
    print("\nAfter set unique");
    print(widget.transactions);
    widget.transactions.forEach((element) {
      data.add(element);
    });
    
    _seriesPieData.add(charts.Series(
      id: 'Expenses in a',
      data: data,
      // TODO CATEGORIES ARE NOT UNIQUE RIGHT NOW PROCESS THE DATA BEFORE ADDING
      domainFn: (Expense transaction, _) => transaction.category,
      measureFn: (Expense transaction, _) => transaction.amount,
      colorFn: (Expense transaction, _) => charts.ColorUtil.fromDartColor
      (_randomColor.randomColor(colorHue: ColorHue.blue)), // Random blue color
    ));
  }

  void _setTransactionListCategoryUnique() {
    print("\nIn set unique");
    List<Expense> _newList = List<Expense>();

    for (int i = 0; i < widget.transactions.length; i++) {
      int _result = _containsWithCategory(_newList, widget.transactions[i].category);
      print("Result $_result");
      if (_result < 0)
        _newList.add(widget.transactions[i]);
      else {
        _newList[_result] = Expense(
          amount: _newList[_result].amount + widget.transactions[i].amount,
          category: _newList[_result].category,
          dateTime: _newList[_result].dateTime,
          description: _newList[_result].description
        );
      }
    }
    print(_newList);
    widget.transactions = _newList;
  }

  // returns false if does not contain the category
  // returns the index if it contains the category
  dynamic _containsWithCategory(List<Expense> list, String category) {
    list.forEach((element) {
      if (element.category == category) {
        return _indexOf(list, element);
      }
    });

    return -1;
  }

  int _indexOf(List<Expense> list, Expense item) {
    for (int i = 0; i < list.length; i++ )
      if (
           list[i].amount == item.amount
        && list[i].category == item.category
        && list[i].dateTime == item.dateTime
        && list[i].description == item.description
      )
        return i;
    return -1;
  }

  @override
  void initState() {
    super.initState();
    _prepareData();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
        child: Container(
          child: charts.PieChart(
            _seriesPieData,
            animate: true,
            animationDuration: Duration(seconds: 1),
            behaviors: [
              new charts.DatumLegend(
                outsideJustification: charts.OutsideJustification.endDrawArea,
                horizontalFirst: false,
                desiredMaxRows: 2,
                cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
              )
            ],
          ),
        ),
      ),
      ]
    );
  }
}
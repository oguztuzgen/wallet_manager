import 'package:wallet_manager/model/expense.dart';
import 'package:wallet_manager/views/home_tabs/graph_screen.dart';
import 'package:wallet_manager/views/home_tabs/transaction_list_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

void _navigateAuth(BuildContext context) {
  SimpleDialog dialog = SimpleDialog(
    title: Text('Sign out'),
    children: [
      Center(child: Text("Are you sure you would like to sign out?")),
      Row(
        children: [
          FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/auth');
            },
            child: Text("Yes")
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            child: Text("No")
          )
        ],
      )
    ],
  );

  showDialog(context: context, builder: (context) {
    return dialog;
  },);
}

class _HomeState extends State<Home> {
  static List<Expense> transactions = <Expense>[];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Wallet Manager"),
          actions: [
            IconButton(icon: Icon(Icons.exit_to_app,), onPressed:() => _navigateAuth(context),)
          ],
          bottom: TabBar(tabs: [
            Tab(
              text: "List",
            ),
            Tab(
              text: "Charts",
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            TransactionList(transactions: transactions),
            GraphScreen(transactions: transactions,),
          ],
        ),
      ),
    );
  }
}
import 'package:wallet_manager/db/user_db.dart';
import 'package:wallet_manager/views/loading.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_manager/views/home.dart';
import 'package:wallet_manager/views/authentication/auth_screen.dart';
import 'package:wallet_manager/views/transactionscreen.dart';
import 'package:flutter/material.dart';

void main() async {
  UserDB _userDB = UserDB();
  _userDB.database.then((value) { Database _database = value; });

  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/auth': (context) => AuthenticationScreen(),
        '/home': (context) => Home(),
        '/editadd': (context) => EditAddTransaction()
      },
      home: Home() // ! Debug change Loading()
    );
  }
}
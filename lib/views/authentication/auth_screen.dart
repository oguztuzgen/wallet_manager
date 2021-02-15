import 'package:firebase_core/firebase_core.dart';
import 'package:wallet_manager/views/authentication/signin.dart';
import 'package:wallet_manager/views/authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:wallet_manager/views/authentication/toast.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp().then((value) => print("Firebase initialized...") );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Expense Tracker"),
          bottom: TabBar(tabs: [
            Tab(
              text: "Log in",
            ),
            Tab(
              text: "Register",
            ),
          ]),
        ),
        body: TabBarView(children: [
          Login(),
          Register()
        ]),
      )
    );
  }
}

/// GARBAGE

// NOT USED
void _displayErrorDialog(BuildContext context, String title, String text) {
 AlertDialog dialog = AlertDialog(
   title: Text(title),
   content: SingleChildScrollView(
     child: ListBody(
       children: <Widget>[
         Text(text),
       ],
     ),
   ),
   actions: <Widget>[
     FlatButton(
       child: Text('OK'),
       onPressed: () {
         Navigator.of(context).pop();
       },
     ),
   ],
 );
 showDialog(context: context, builder: (context) {
   return dialog;
 },);
}


// NOT USED
void _exceptionMessage(BuildContext context, String exceptionStr) {
   if (exceptionStr == 'ERROR_INVALID_EMAIL')
     displayErrorToast(context, "Invalid email");// , "The email you entered is not valid.");
   else if (exceptionStr == 'ERROR_USER_DISABLED')
     displayErrorToast(context, 'Account disabled');// , 'Your account has been disabled');
   else if (exceptionStr == 'ERROR_USER_NOT_FOUND')
     displayErrorToast(context, 'Account not found'); // , 'You haven\'t created an account yet.');
   else if (exceptionStr == 'ERROR_WRONG_PASSWORD')
     displayErrorToast(context, 'Password Incorrect'); // , 'You have entered an incorrect password');
 }
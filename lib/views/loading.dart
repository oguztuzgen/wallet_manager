import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    setupExpenseTracker();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Text("Loading...",
        style: TextStyle(
          color: Colors.grey[150]
        ),
      ),
    );
  }
    
  void setupExpenseTracker() async {
    await new Future.delayed(const Duration(seconds: 1), () => "1");
    Navigator.pushReplacementNamed(context, '/auth');
  }
}

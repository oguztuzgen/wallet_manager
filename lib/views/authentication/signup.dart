import 'package:wallet_manager/services/auth.dart';
import 'package:wallet_manager/views/authentication/toast.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // final instances
  final _formKey = GlobalKey<FormState>();
  final AuthMethods _authMethods = new AuthMethods();

  // state variables
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _reenterPassController = new TextEditingController();

  Future<dynamic> _registerEmailPassword() async {
    if (_formKey.currentState.validate()) {
      dynamic result = await _authMethods.registerEmailPassword(
        _emailController.text, _passController.text);
      if (result != null) {
        Navigator.pushReplacementNamed(context, '/home');
        print('register successful');
      } else {
        displayErrorToast(context, result[1]);
      }
    }
  }

  Future<dynamic> _registerGoogle() {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email"
                ),
                validator: (value) {
                  if (value.isEmpty) 
                    return 'Email is required';
                  else 
                    return null;
                },
              ),
              TextFormField(
                obscureText: true,
                controller: _passController,
                decoration: InputDecoration(
                  hintText: "Password"
                ),
                validator: (value) {
                  if (value.isEmpty) 
                    return 'Password is required';
                  else if (value.length < 8)
                    return 'Required password length is 8 characters';
                  else 
                    return null;
                },
              ),
              TextFormField(
                obscureText: true,
                controller: _reenterPassController,
                decoration: InputDecoration(
                  hintText: "Re-enter Password"
                ),
                validator: (value) {
                  if (value.isEmpty) 
                    return 'Re-enter password';
                  else if (value != _passController.text)
                    return 'Passwords do not match';
                  else 
                    return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: _registerEmailPassword,
                    child: Text("Register")
                  ),
                  FlatButton(
                    onPressed: _registerGoogle,
                    child: Text("Register with Google"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
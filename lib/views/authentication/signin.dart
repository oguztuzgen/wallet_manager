import 'package:wallet_manager/services/auth.dart';
import 'package:wallet_manager/styles/text_style.dart';
import 'package:wallet_manager/views/authentication/toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final instances
  final _formKey = GlobalKey<FormState>();
  final AuthMethods _authMethods = new AuthMethods();

  // state variables
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  void enterResetEmail(BuildContext context) async {
    BuildContext con = context; // safe guard for popping the auth screen off
    final _resetFormKey = GlobalKey<FormState>();
    TextEditingController _controller = TextEditingController();
    SimpleDialog dialog = SimpleDialog(
      title: Text("Reset password"),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
          child: Form(
            key: _resetFormKey,
            child: Center(
              child: Column(
                children: [
                  Text("Enter your email to recover your account"),
                  SizedBox(
                    height: 7.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _controller,  
                      decoration: InputDecoration(  
                        hintText: "Validation email"
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter an email';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      if (_resetFormKey.currentState.validate()) {
                        dynamic result = await _authMethods.resetPassword(_controller.text);
                        dynamic exceptionStr = result.code; // Display a dialog accordingly
                        displayErrorToast(context, exceptionStr);
                        if (context != con)
                          Navigator.pop(context);
                      }
                    }, 
                    child: Text("Send")
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => dialog);
  }

  Future<dynamic> _logInEmailPassword() async {
    if (_formKey.currentState.validate()) { // ensure the form is fully entered
      // attempt login with user
      dynamic result = await _authMethods.signInEmailPassword(_emailController.text, _passController.text);
      if (result[0] != null) { // check if sign in is successful
        Navigator.pushReplacementNamed(context, '/home'); // TODO remove the arrow top left
        print("success.");
      } else {
        dynamic exceptionStr = result[1].code; // Display a dialog accordingly
        displayErrorToast(context, exceptionStr);
      }
    }
  }

  Future<dynamic> _logInGoogle() async {
    try {
      // TODO MAKE GOOGLE LOGIN NAVIGATE TO MAIN AS WELL
      print('google sign in success');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
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
                  else 
                    return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: _logInEmailPassword,
                    child: Text("Log in")
                  ),
                  FlatButton(onPressed: _logInGoogle, child: Text("Log in with Google"))
                ],
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      style: softStyle,
                      text: 'If you don\'t remember your password '
                    ),
                    TextSpan(
                        text: 'Reset password',
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            enterResetEmail(context);
                          }
                    )
                  ],
               ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
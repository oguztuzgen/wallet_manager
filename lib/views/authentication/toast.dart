import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void displayErrorToast(BuildContext context, String exceptionStr) {
  FToast fToast;
  fToast = FToast();
  fToast.init(context);
  Widget toast;

  dynamic _showToast(String exceptionMsg) {
     toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey[300],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(exceptionMsg),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  if (exceptionStr == 'ERROR_INVALID_EMAIL')
      _showToast("Invalid email");
    else if (exceptionStr == 'ERROR_USER_DISABLED')
      _showToast('Account disabled');
    else if (exceptionStr == 'ERROR_USER_NOT_FOUND')
      _showToast('Account not found');
    else if (exceptionStr == 'ERROR_WRONG_PASSWORD')
      _showToast('Password Incorrect');
}
import 'package:flutter/material.dart';

Widget CategoryPopup(BuildContext context) => Container(
  height: 280,
  decoration: BoxDecoration(
    color:  Colors.white,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  child: Column(
    children: <Widget>[
      SizedBox(height: 24),
      Text(
        "Enter new category name".toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
          child: TextFormField(
            maxLines: 1,
            autofocus: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Text Form Field 1',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          )
      ),
      Container(
        width: 150.0,
        height: 1.0,
        color: Colors.grey[400],
      ),
      Padding(
          padding: EdgeInsets.only(top: 10, right: 15, left: 15),
          child: TextFormField(
            maxLines: 1,
            autofocus: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Text Form Field 2',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          )
      ),
      SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 8),
          RaisedButton(
            color: Colors.white,
            child: Text(
              "Save".toUpperCase(),
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
            onPressed: () {
              print('Update the user info');
              // return Navigator.of(context).pop(true);
            },
          )
        ],
      ),
    ],
  ),
);

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_manager/db/db_manager.dart';
import 'package:wallet_manager/model/category.dart';
import 'package:wallet_manager/views/popups/category_screen.dart';

class EditAddTransaction extends StatefulWidget {
  @override
  _EditAddTransactionState createState() => _EditAddTransactionState();
}

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element e1) {
    e1.markNeedsBuild();
    e1.visitChildren(rebuild);
  }

  (context as Element).visitChildren((rebuild));
}

class _EditAddTransactionState extends State<EditAddTransaction> {
  UserDB _userDB = UserDB();
  final _formatDMY = new DateFormat('dd-MM-yyyy');
  final _formatHm = new DateFormat('HH.mm');
  final _formKey = GlobalKey<FormState>();
  
  // state variables
  List<WMCategory> categories;
  Map _transaction = {};
  TextEditingController descriptionController 
    = TextEditingController();
  TextEditingController amountController 
    = TextEditingController();
  TextEditingController categoryController 
    = TextEditingController();
  DateTime _currentDateTime;
  bool setValues = false;
  String _selectedCategory = "";

  @override
  void initState() {
    Database _db;
    _userDB.database.then((value) {
      print('DB - Initialized');
      _db = value;
    });

    // _userDB.initializeDatabase().then((value) {
    //   print('DB - Initialized');
    // });

    _userDB.getCategories().then((value) => {
      categories = value
    });

    // TODO _selectedCategory = categories.isEmpty ? "Add" : categories[0];
    super.initState();
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItemList(List<WMCategory> fromList) {
    if (fromList == null) {
      List<DropdownMenuItem<String>> result
        = new List<DropdownMenuItem<String>>.empty(growable: true);
      result.add(
          DropdownMenuItem(
              value: "Add", child: Text("Add", style: TextStyle(color: Colors.black)),
              onTap: () {_displayCategoryDialog(); print("Pressed"); }  // TODO _userDB.insertCategory(input); } ,
          ));
      setState(() {});

      return result;
    }

    List<DropdownMenuItem<dynamic>> result
      = new List<DropdownMenuItem<dynamic>>.empty(growable: true);
    for (WMCategory s in fromList) {
      result.add(DropdownMenuItem(
        value: s.category,
        child: Text(s.category),
        onTap: () => _selectedCategory = s.category,
      ));
    }

    result.add(
      DropdownMenuItem(
          value: "Add", child: Text("Add", style: TextStyle(color: Colors.black),),
        onTap: () => _displayCategoryDialog()  // TODO _userDB.insertCategory(input); } ,
      )
    );
    setState(() {});
    return result;
  }

  Future<void> _pickDate(BuildContext context) async {
    final _selected = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context, 
      initialDate: _transaction['dateTime'], 
      firstDate: DateTime(2011, 1), 
      lastDate: DateTime(2120, 8)
    );

    if (_selected != null) {
      TimeOfDay _hours = TimeOfDay.fromDateTime(_currentDateTime);
      _currentDateTime = _selected.add(Duration(hours: _hours.hour, minutes: _hours.minute));
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay _selected = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.fromDateTime(_transaction['dateTime']),
    );

    if (_selected != null) {
        _currentDateTime = DateTime(_currentDateTime.year, 
        _currentDateTime.month, _currentDateTime.day, 
        _selected.hour, _selected.minute
      );
    }
  }

  void setTextFieldValues(BuildContext context) {
    if (!setValues) {
      descriptionController.text = _transaction['description'];
      amountController.text = _transaction['amount'].toString();
      categoryController.text = _transaction['category'];
      _currentDateTime = _transaction['dateTime'];
      setValues = true;
    }  
  }

  @override
  Widget build(BuildContext context) {
    _transaction = ModalRoute.of(context).settings.arguments;
    print("Build ${_transaction['dateTime']}");
    setTextFieldValues(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expense Tracker",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.grey[200],
            fontFamily: 'Oxygen',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Description'
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please enter a description';
                      else
                      return null;
                    },
                    controller: descriptionController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Amount'
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please enter the amount';
                      else
                      return null;
                    },
                    controller: amountController,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Text("Pick a date"),
                            RaisedButton(
                              onPressed: () async {
                                  await _pickDate(context);
                                setState(() {});
                              },
                              child: Text("${_formatDMY.format(_currentDateTime)}"),
                            )
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          children: [
                            Text("Pick a time"),
                            RaisedButton(
                              onPressed: () async {
                                await _pickTime(context);
                                setState(() {});
                              },
                              child: Text("${_formatHm.format(_currentDateTime)}"),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  DropdownButton(
                    items: _buildDropdownMenuItemList(categories),
                    // value: _selectedCategory,
                    onChanged: (String newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                    },

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Navigator.pop(context, {
              'description' : descriptionController.text,
              'amount' :  double.parse(amountController.text),
              'dateTime' : _currentDateTime,
              'category' : categoryController.text
            });
          }
        },
        child: Text("submit"),
        backgroundColor: Colors.red[600],
      ),
    );
  }

  _displayCategoryDialog() {
    showDialog(
        context: context,
      child: Dialog(shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.circular(50),
      ),
      elevation: 6,
      backgroundColor: Colors.black26,
      child:  CategoryPopup(context),),
      // builder: (context) {
      //     return Dialog (
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(50),
      //       ),
      //       elevation: 6,
      //       backgroundColor: Colors.transparent,
      //       child: CategoryPopup(context),
      //     );
      // }
    );
  }
}
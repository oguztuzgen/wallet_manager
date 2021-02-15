import 'package:flutter/material.dart';
import 'package:wallet_manager/model/expense.dart';

class TransactionList extends StatefulWidget {
  List<Expense> transactions;

  @override
  _TransactionListState createState() => _TransactionListState();

  TransactionList({Key key, @required this.transactions}) : super(key: key);
}
  
class _TransactionListState extends State<TransactionList> {
  void _addNewTransaction() {
    widget.transactions.add(Expense());
    _editSelectedTransaction(context, widget.transactions.length - 1);
  }

  void _editSelectedTransaction
  (BuildContext context, int index) async {
    dynamic result = await Navigator.pushNamed(
      context, '/editAdd', arguments: {
        'description' : widget.transactions[index].description,
        'amount' : widget.transactions[index].amount,
        'dateTime' : widget.transactions[index].dateTime,
        'category' : widget.transactions[index].category
      }
    );
  
    setState(() {
      widget.transactions[index] = Expense(
        description: result['description'], 
        amount: result['amount'], 
        dateTime: result['dateTime'], 
        category: result['category']
      );
    });
  }

  void rebuildAllChildren(BuildContext context) {
      void rebuild(Element e1) {
        e1.markNeedsBuild();
        e1.visitChildren(rebuild);
      }

      (context as Element).visitChildren((rebuild));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         child: Column(
           children: [
             Expanded(
               child: ListView.builder(
                 padding:
                     const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                 itemCount: widget.transactions.length,
                 itemBuilder: (BuildContext context, int index) {
                   return Container(
                     height: 50,
                     margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                     color: Colors.blue,
                     child: Center(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(
                             padding: EdgeInsets.only(left: 10),
                             child: Text(
                               '${widget.transactions[index].description}',
                               style: TextStyle(
                                 fontSize: 14,
                                 color: Colors.white,
                               ),
                             ),
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               Container(
                                 alignment: Alignment.centerLeft,
                                 height: 30,
                                 width: 30,
                                 child: Text('${widget.transactions[index].amount}'),
                               ),
                               Center(
                                 child: SizedBox(
                                   height: 50,
                                   width: 50,
                                   child: FlatButton(
                                     // TODO resize these buttons ui looks ass
                                     onPressed: () {
                                       _editSelectedTransaction(context, index);
                                       setState(() {});
                                     }, 
                                     child: Center(child: Icon(Icons.edit)),
                                   ),
                                 ),
                               ),
                               Center(
                                 child: SizedBox(
                                   height: 50,
                                   width: 50,
                                   child: FlatButton(
                                     onPressed: () {
                                       widget.transactions.removeAt(index);
                                       setState(() {});
                                     },
                                     child: Center(child: Icon(Icons.delete),)
                                   ),
                                 ),
                               ),
                             ],
                           )
                         ],
                       ),
                     ),
                   );
                 },
               ),
             ),
           ],
         ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline),
        onPressed: _addNewTransaction
      ),
    );
  }
}
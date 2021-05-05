import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget._addNewTransaction(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      //returns future
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          elevation: 2,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: _amountController,
                  onSubmitted: (_) => _submitData(),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        //move it to right
                        child: Text(
                          _selectedDate == null
                              ? 'No Date Chosen!'
                              : 'Selected Date: ${DateFormat.yMd().format(_selectedDate)}',
                        ),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _presentDatePicker,
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _submitData,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text('Add Transaction'),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

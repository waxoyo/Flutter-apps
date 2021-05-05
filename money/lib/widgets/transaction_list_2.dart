import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money/models/transaction.dart';
import '../models/transaction.dart';

class TransactionList2 extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList2(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,//overwritten by expanded
      child: _transactions.isEmpty
          ? Column(children: [
              Text(
                'No Transactions added yet',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 300,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ])
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: FittedBox(
                          child: Text('\$${_transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      _transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat('dd-MMM, yyyy')
                        .format(_transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        _deleteTransaction(_transactions[index].id);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

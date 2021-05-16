import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionWid extends StatelessWidget {
  const TransactionWid({
    Key key,
    @required Transaction this.transaction,
    @required Function this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
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
              child: Text('\$${transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(DateFormat('dd-MMM, yyyy')
            .format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 390
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: () {
                  deleteTransaction(transaction.id);
                },
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  deleteTransaction(transaction.id);
                },
              ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:money/models/transaction.dart';
import '../models/transaction.dart';
import './transaction_wid.dart';

class TransactionList2 extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList2(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(children: [
              Text(
                'No Transactions added yet',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: constraints.maxHeight * 0.7,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ]);
          })
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              return TransactionWid(transaction: _transactions[index], deleteTransaction: _deleteTransaction);
            },
          );
  }
}

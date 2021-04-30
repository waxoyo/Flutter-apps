import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Function resetFunction;
  Result(this.resetFunction);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Cool'),
          TextButton(
            onPressed: resetFunction,
            child: Text('Restart'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}

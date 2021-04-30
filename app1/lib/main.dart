import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

// void main(){
//   runApp(MyApp());
// }
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = [
    {
      'questionText': 'Fav Color?',
      'answers': ['Black', 'Green', 'White', 'Red']
    },
    {
      'questionText': 'Fav Animal',
      'answers': ['Sheep', 'Lion', 'Dog', 'Cat']
    },
    {
      'questionText': 'Fav Person',
      'answers': ['I', 'You', 'He', 'She']
    },
  ];

  var _questionIndex = 0;

  void _resetQuiz(){
    setState((){
      _questionIndex = 0;
    });
  }

  void _answerQuestion() {
    setState(() {
      _questionIndex++;
    });

    if (_questionIndex < _questions.length) {
      print('We have more questions');
    }
  }

  @override
  Widget build(BuildContext contex) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(_answerQuestion,_questions,_questionIndex)
            : Result(_resetQuiz)
      ),
    );
  }
}

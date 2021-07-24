import 'package:flutter/material.dart';
import 'text_question.dart';
import 'button_answer.dart';

void main() {
  runApp(MyApp());
}

enum Answer {
  A,
  B,
  C,
  D,
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _question = const [
    {
      'questionText': 'What\'s your favourite color?',
      'answer': ['Black', 'Blue', 'Green', 'Red'],
    },
    {
      'questionText': 'What\'s your favourite food?',
      'answer': ['Bread', 'Rice', 'Pizza', 'Hamburger'],
    },
  ];
  var _answer = 'A';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Q & A'),
        ),
        body: Column(
          children: [
            TextQuestion(_question[0]['questionText'] as String),
            ButtonAnswer(
              Answer.A,
              (_question[0]['answer'] as List<String>)[0],
            ),
            ButtonAnswer(
              Answer.B,
              (_question[0]['answer'] as List<String>)[1],
            ),
            ButtonAnswer(
              Answer.C,
              (_question[0]['answer'] as List<String>)[2],
            ),
            ButtonAnswer(
              Answer.D,
              (_question[0]['answer'] as List<String>)[3],
            ),
            Text(_answer),
          ],
        ),
      ),
    );
  }
}

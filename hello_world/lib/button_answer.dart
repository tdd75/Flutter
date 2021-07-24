import 'package:flutter/material.dart';
import 'main.dart';

class ButtonAnswer extends StatelessWidget {
  final Answer index;
  final String content;

  ButtonAnswer(this.index, this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.greenAccent,
        ),
        onPressed: () => print('$index'),
        child: Text(
          '${index.toString().split('.').last}. $content',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

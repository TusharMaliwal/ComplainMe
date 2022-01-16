import 'package:flutter/material.dart';
import 'package:complain_me/utilities/constants.dart';

class MyComplainsScreen extends StatefulWidget {
  @override
  _MyComplainsScreenState createState() => _MyComplainsScreenState();

  final Widget iconButton;
  MyComplainsScreen({required this.iconButton});
}

class _MyComplainsScreenState extends State<MyComplainsScreen>{
  @override
  Widget build(BuildContext context) {
    return const Text.rich(
  TextSpan(
    text: 'Hello', // default text style
    children: <TextSpan>[
      TextSpan(text: ' beautiful ', style: TextStyle(fontStyle: FontStyle.italic)),
      TextSpan(text: 'world', style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  ),
);
  }

}

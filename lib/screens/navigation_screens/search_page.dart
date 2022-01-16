import 'package:flutter/material.dart';
import 'package:complain_me/utilities/constants.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();

  final Widget iconButton;
  SearchPage({required this.iconButton});
}

class _SearchPageState extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return const Text.rich(
  TextSpan(
    text: 'Hello', // default text style
    children: <TextSpan>[
      TextSpan(text: ' SearchPage ', style: TextStyle(fontStyle: FontStyle.italic)),
      TextSpan(text: 'world', style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  ),
);
  }

}

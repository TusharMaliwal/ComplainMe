import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:complain_me/components/alert_box.dart';
import 'package:complain_me/components/custom_text_input.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:complain_me/utilities/user_api.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UpdateContactScreen extends StatefulWidget {
  @override
  _UpdateContactScreenState createState() => _UpdateContactScreenState();

  final Widget iconButton;
  UpdateContactScreen({required this.iconButton});
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text.rich(
  TextSpan(
    text: 'Hello', // default text style
    children: <TextSpan>[
      TextSpan(text: ' Update Contact Screen ', style: TextStyle(fontStyle: FontStyle.italic)),
      TextSpan(text: 'world', style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  ),
);
  }
}

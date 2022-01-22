import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:complain_me/components/alert_box.dart';
import 'package:complain_me/models/beef.dart';
import 'package:complain_me/models/complain.dart';


class ComplainScreen extends StatefulWidget {
  @override
  _ComplainScreenState createState() => _ComplainScreenState();

  final Complain complain;
  final Beef ?specificBeef;
  ComplainScreen({required this.complain,this.specificBeef});
}

class _ComplainScreenState extends State<ComplainScreen>
    with TickerProviderStateMixin {
  late AnimationController _colorAnimationController;
  late AnimationController _textAnimationController;
  late Animation _colorTween, _iconColorTween;
  late Animation<Offset> _transTween;
  late bool emptyCart = true;
  late Widget addedToCartBar;
  late Widget specificDishToDisplay;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

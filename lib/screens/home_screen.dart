import 'package:complain_me/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();

  final int currentIndex;
  HomeScreen({required this.currentIndex});
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double rotationAngle = 0;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context){
    return Container(
      child:const Center(
        child: Text("Home Screen!",
        textDirection:TextDirection.ltr,
        style: TextStyle(color:Colors.black, fontSize: 30),)
      ),
      decoration: const BoxDecoration(color: Colors.white),
    );
  }
}
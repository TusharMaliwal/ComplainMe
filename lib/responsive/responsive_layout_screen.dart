import 'package:flutter/material.dart';
import 'package:complain_me/utilities/global_variables.dart';


class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({ 
    Key? key ,
    required this.mobileScreenLayout,
    required this.webScreenLayout
    }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth>webScreenSize){
          return widget.webScreenLayout;
        }
        return widget.mobileScreenLayout;
      },
    );
  }
}
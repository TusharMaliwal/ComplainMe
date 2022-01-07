import 'package:complain_me/utilities/user_api.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  static final String id = 'menu_screen';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool _loading = false;
  UserApi userApi = UserApi.instance;

  @override
  Widget build(BuildContext context){
    return Container(
      child:const Center(
        child: Text("Menu Screen!",
        textDirection:TextDirection.ltr,
        style: TextStyle(color:Colors.black, fontSize: 30),)
      ),
      decoration: const BoxDecoration(color: Colors.white),
    );
  }
}

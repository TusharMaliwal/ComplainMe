import 'package:complain_me/utilities/user_api.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  static final String id = 'details_screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
  final String phoneNumber, name;
  DetailsScreen({required this.name, required this.phoneNumber});
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool _loading = false;
  UserApi userApi = UserApi.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
          child: Text(
        "Details Screen!",
        textDirection: TextDirection.ltr,
        style: TextStyle(color: Colors.black, fontSize: 30),
      )),
      decoration: const BoxDecoration(color: Colors.white),
    );
  }
}

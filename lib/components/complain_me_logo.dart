import 'package:flutter/material.dart';
import 'package:complain_me/utilities/constants.dart';

class ComplainMeLogo extends StatelessWidget {
  const ComplainMeLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image(
          image: AssetImage(
            'images/logo.jpg',
          ),
          width: 100,
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'ComplainMe',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'GT Eesti',
            color: kColorBlack,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}

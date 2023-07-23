import 'package:complain_me/components/app_background.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: kColorLight,
      child: Stack(
        children: const [
          AppBackground(),
          Center(
            child: CircularProgressIndicator(
              color: kColorPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

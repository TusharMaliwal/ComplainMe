import 'package:complain_me/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  final Function onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      selectedItemColor: kColorPrimaryDark,
      unselectedItemColor: kColorGrey,
      onTap: (int index) {
        onTap(index);
      }, // new
      currentIndex: currentIndex,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
      ),
      backgroundColor: Colors.transparent,
      selectedIconTheme: const IconThemeData(
        size: 30,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.circlePlus),
          label: "Post",
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.earthAsia),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.circleUser),
          label: "Profile",
        )
      ],
    );
  }
}

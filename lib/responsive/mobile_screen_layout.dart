import 'package:complain_me/screens/add_post_screen.dart';
import 'package:complain_me/screens/feed_screen.dart';
import 'package:complain_me/screens/search_screen.dart';
import 'package:complain_me/utilities/user_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:complain_me/utilities/constants.dart';

import '../screens/profile_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;
  UserApi userApi  = UserApi.instance;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          FeedScreen(),
          SearchScreen(),
          AddPostScreen(),
          Text('notify'),
          ProfileScreen(username: userApi.username!),
        ],
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: kColorDark,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? kColorPrimary : kColorLight,
            ),
            label: '',
            backgroundColor: kColorPrimary,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? kColorPrimary : kColorLight,
            ),
            label: '',
            backgroundColor: kColorPrimary,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _page == 2 ? kColorPrimary : kColorLight,
            ),
            label: '',
            backgroundColor: kColorPrimary,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? kColorPrimary : kColorLight,
            ),
            label: '',
            backgroundColor: kColorPrimary,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? kColorPrimary : kColorLight,
            ),
            label: '',
            backgroundColor: kColorPrimary,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:complain_me/components/drawer_item.dart';
import 'package:complain_me/screens/home_screen.dart';
import 'package:complain_me/services/local_storage.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:complain_me/utilities/user_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'login_screen.dart';

class MenuScreen extends StatefulWidget {
  static final String id = 'menu_screen';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentPageIndex = 0;
  bool _loading = false;
  UserApi userApi = UserApi.instance;

  Future<void> logoutUser() async {
    await LocalStorage.removeLoginInfo();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  Future<void> getLocation() async {
    final query =
        "${userApi.houseName}, ${userApi.streetName}, ${userApi.cityName}, ${userApi.stateName} ${userApi.postalCode}, ${userApi.countryName}";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");
    userApi.latitude = first.coordinates.latitude;
    userApi.longitude = first.coordinates.longitude;
  }

  _selectedItem(int index) {
    setState(() {
      _currentPageIndex = index;
      HomeScreen(
        currentIndex: _currentPageIndex,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ComplainMe")),
      body: Center(
        child: HomeScreen(
          currentIndex: _currentPageIndex,
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    userApi.name!,
                    style: kLabelStyle,
                  ),
                  Text(userApi.email!,
                      style: TextStyle(
                        fontFamily: 'GT Eesti',
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      )),
                ],
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                setState(() {
                  _currentPageIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My Complaints'),
              onTap: () {
                setState(() {
                  _currentPageIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My Address'),
              onTap: () {
                setState(() {
                  _currentPageIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Update Contact'),
              onTap: () {
                setState(() {
                  _currentPageIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                setState(() {
                  _currentPageIndex = 4;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                setState(() {
                  _currentPageIndex = 5;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                setState(() async {
                  setState(() {
                    _loading = true;
                  });
                  await logoutUser();
                  setState(() {
                    _loading = false;
                  });
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:complain_me/screens/login_screen.dart';
import 'package:complain_me/screens/registration_screen.dart';
import 'package:complain_me/screens/splashscreen.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'ComplainMe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kColorYellow,
        accentColor: kColorRed,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}

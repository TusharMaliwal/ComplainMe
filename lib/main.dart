import 'package:complain_me/screens/details_screen.dart';
import 'package:complain_me/screens/details_screen2.dart';
import 'package:complain_me/screens/login_screen.dart';
import 'package:complain_me/screens/menu_screen.dart';
import 'package:complain_me/screens/otp_screen.dart';
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
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kColorRed),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        OtpScreen.id:(context) => OtpScreen(),
        DetailsScreen.id:(context) => DetailsScreen(),
        MenuScreen.id:(context) => MenuScreen(),
      },
    );
  }
}

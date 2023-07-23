import 'package:complain_me/screens/login_screen.dart';
import 'package:complain_me/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:complain_me/responsive/mobile_screen_layout.dart';
import 'package:complain_me/responsive/responsive_layout_screen.dart';
import 'package:complain_me/responsive/web_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complain Me',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'CarosSoft',
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return LoginScreen();
        },
      ),
    );
  }
}

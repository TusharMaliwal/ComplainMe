// ignore_for_file: unnecessary_null_comparison

import 'package:complain_me/responsive/mobile_screen_layout.dart';
import 'package:complain_me/responsive/responsive_layout_screen.dart';
import 'package:complain_me/responsive/web_screen_layout.dart';
import 'package:complain_me/services/auth_service.dart';
import 'package:complain_me/utilities/app_error.dart';
import 'package:complain_me/services/local_storage.dart';
import 'package:flutter/material.dart';

import 'package:complain_me/components/alert_box.dart';
import 'package:complain_me/components/custom_text_input.dart';
import 'package:complain_me/components/complain_me_logo.dart';
import 'package:complain_me/screens/registration_screen.dart';

import 'package:complain_me/utilities/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void navigateToSignup() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RegistrationScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              ComplainMeLogo(),
              SizedBox(
                height: 60,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CustomTextInput(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'Your Email',
                        icon: Icons.person_outline,
                        isPasswordField: false,
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CustomTextInput(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Your Password',
                        icon: Icons.lock_outline,
                        isPasswordField: true,
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          //TODO: CODE
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontFamily: 'GT Eesti',
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          if (_emailController.text != null &&
                              _passwordController.text != null &&
                              _emailController.text != "" &&
                              _passwordController.text != "") {
                            await loginUser();
                          } else {
                            AlertBox.showErrorDialog(
                                context,
                                AppError(400,
                                    'Please fill up the required fields.'));
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        padding: EdgeInsets.all(25),
                        color: kColorYellow,
                        child: Text(
                          'Log In  ',
                          style: TextStyle(
                            fontFamily: 'GT Eesti',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontFamily: 'GT Eesti',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          GestureDetector(
                            onTap: navigateToSignup,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontFamily: 'GT Eesti',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: kColorRed),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    try {
      String res = await AuthService.loginUser(
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text,
      );
      if (res == "Success") {
        LocalStorage.saveLoginInfo( email:_emailController.text.trim().toLowerCase(),statusCode:"YES");
        await AuthService().getUserDetails(email:_emailController.text.trim().toLowerCase());
        AlertBox.showSuccessDialog(context, res);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout()),
          ),
        );
      } else {
        AlertBox.showErrorDialog(
          context,
          AppError(400, res),
        );
      }
    } on AppError catch (e) {
      await AlertBox.showErrorDialog(
        context,
        AppError(
          400,
          e.message,
        ),
      );
    }
  }
}

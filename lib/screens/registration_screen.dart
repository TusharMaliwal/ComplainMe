// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:complain_me/components/alert_box.dart';
import 'package:complain_me/components/custom_text_input.dart';
import 'package:complain_me/components/complain_me_logo.dart';
import 'package:complain_me/screens/login_screen.dart';
import 'package:complain_me/services/local_storage.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static final String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController cnfPassword = new TextEditingController();
  bool _loading = false;

  Future<void> registerUser() async {
    final http.Response response =
        await http.post(Uri.parse(kRegisterUrl), body: {
      "email": email.text,
      "password": password.text,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Connection established
      var data = jsonDecode(response.body.toString());
      if (data.toString() == "User exists") {
        AlertBox.showErrorBox(context, 'This email is already in use.');
      } else if (data.toString() == "User registered") {
        // Successful registration

        await AlertBox.showSuccessBox(
            context,
            'Your account has been registered. Please verify your email address to continue.',
            'Registration Successful');
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    } else {
      // Connection failed
      AlertBox.showErrorBox(context,
          'Error establishing connection with the server.\nError Code ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      color: Colors.white,
      opacity: .5,
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  ComplainMeLogo(),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Material(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CustomTextInput(
                            controller: email,
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
                            controller: password,
                            label: 'Create Password',
                            hint: 'Create a Password',
                            icon: Icons.lock_outline,
                            isPasswordField: true,
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          CustomTextInput(
                            controller: cnfPassword,
                            label: 'Confirm Password',
                            hint: 'Confirm your Password',
                            icon: Icons.lock_outline,
                            isPasswordField: true,
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          MaterialButton(
                            onPressed: () async {
                              setState(() {
                                _loading = true;
                              });
                              if (password.text != null &&
                                  email.text != null &&
                                  password.text != "" &&
                                  email.text != "") {
                                if (cnfPassword.text == password.text) {
                                  await registerUser();
                                } else if (RegExp( // checking for a valid email
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email.text)) {
                                  AlertBox.showErrorBox(
                                      context, "Enter A valid Email");
                                } else {
                                  AlertBox.showErrorBox(context,
                                      'The confirmation password did not match with the chosen one.');
                                }
                              } else {
                                AlertBox.showErrorBox(
                                    context, 'Please fill up all the fields.');
                              }
                              setState(() {
                                _loading = false;
                              });
                            },
                            padding: EdgeInsets.all(25),
                            color: kColorYellow,
                            child: Text(
                              'Sign Up  >',
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
                                'Already have an account?',
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
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, LoginScreen.id);
                                },
                                child: Text(
                                  'Sign In',
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
        ),
      ),
    );
  }
}

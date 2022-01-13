import 'dart:convert';

//dart file for inputting phoneNumber verification
import 'package:complain_me/screens/details_screen2.dart';
import 'package:flutter/material.dart';
import 'package:complain_me/components/alert_box.dart';
import 'package:complain_me/components/custom_text_input.dart';
import 'package:complain_me/components/complain_me_logo.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  static final String id = 'otp_screen';

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _loading = false;
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController otp = new TextEditingController();

  Future<void> sendOTP() async {
    setState(() {
      _loading = true;
    });
    final http.Response response =
        await http.post(Uri.parse(kSendOtpUrl), body: {
      'mobile': phoneNumber.text,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      if (data.toString() == 'ERROR') {
        setState(() {
          _loading = false;
        });
        AlertBox.showErrorBox(context,
            'An error occurred. We are sorry, the verification cannot be completed.');
      } else {
        setState(() {
          _loading = false;
        });
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("Phone Verification"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'We have sent you an OTP on the entered phone number, please verify the OTP to continue.'),
                TextField(
                  controller: otp,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Done"),
                textColor: Colors.white,
                color: kColorYellow,
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  if (otp.text != null && otp.text != "") {
                    if (otp.text == data['OTP']) {
                      //verifying otp
                      validate();
                    } else {
                      AlertBox.showErrorBox(context,
                          'The otp entered is incorrect.Please Enter a Correct One');
                    }
                  } else {
                    AlertBox.showErrorBox(
                        context, 'Please fill up the required fields');
                  }
                  setState(() {
                    _loading = false;
                  });
                },
              )
            ],
          ),
        );
      }
    } else {
      setState(() {
        _loading = false;
      });
      AlertBox.showErrorBox(context,
          'Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}');
    }
  }

  Future<void> validate() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final http.Response response =
        await http.post(Uri.parse(kValidateUrl), body: {
      'email': prefs.getString('login_email'),
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      if (data.toString() == 'Success') {
        setState(() {
          _loading = false;
        });
/*         Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(
                    ))); */
      } else {
        setState(() {
          _loading = false;
        });
        AlertBox.showErrorBox(context,
            'An error occurred. We are sorry, the verification cannot be completed.');
      }
    } else {
      setState(() {
        _loading = false;
      });
      AlertBox.showErrorBox(context,
          'Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}');
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
                    height: 60,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Material(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
/*                           CustomTextInput(
                            controller: name,
                            label: 'Name',
                            hint: 'Name',
                            icon: Icons.person_outline,
                            isPasswordField: false,
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 25,
                          ), */
                          CustomTextInput(
                            controller: phoneNumber,
                            label: 'Contact',
                            hint: 'Your Contact Number (10 digits)',
                            icon: Icons.phone,
                            isPasswordField: false,
                            textInputType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          MaterialButton(
                            onPressed: () async {
                              setState(() {
                                _loading = true;
                              });
                              if (phoneNumber.text != null &&
                                  phoneNumber.text != "") {
                                sendOTP();
                              } else {
                                AlertBox.showErrorBox(context,
                                    'Please fill up the required fields');
                              }
                              setState(() {
                                _loading = false;
                              });
                            },
                            padding: EdgeInsets.all(25),
                            color: kColorYellow,
                            child: Text(
                              'Continue  >',
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

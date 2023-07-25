import 'package:complain_me/responsive/mobile_screen_layout.dart';
import 'package:complain_me/responsive/responsive_layout_screen.dart';
import 'package:complain_me/responsive/web_screen_layout.dart';
import 'package:complain_me/utilities/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:complain_me/components/alert_box.dart';
import 'package:complain_me/components/custom_text_input.dart';
import 'package:complain_me/components/complain_me_logo.dart';
import 'package:complain_me/screens/login_screen.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:complain_me/utilities/app_error.dart';
import 'package:image_picker/image_picker.dart';
import 'package:complain_me/models/user_model.dart';
import 'package:complain_me/services/local_storage.dart';

import '../services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  Future<void> selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  Future<void> registerUser(User user) async {
    try {
      String res = await AuthService.signupUser(user);
      print(res);
      if (res == "SUCCESS") {
        LocalStorage.saveLoginInfo(
            email: _emailController.text.trim().toLowerCase(),
            statusCode: "YES");
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
        AppError(400, e.message),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginScreen(),
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
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),
              //Profile Picture Show
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              _image != null
                                  ? CircleAvatar(
                                      radius: 56,
                                      backgroundImage: MemoryImage(_image!),
                                    )
                                  : const CircleAvatar(
                                      radius: 56,
                                      backgroundImage: NetworkImage(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVr0nG5xu2A9nK0Ub-93V8rjF8GonraFe4v4JZTF8&s'),
                                    ),
                              Positioned(
                                bottom: -10,
                                left: 80,
                                child: IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                              ),
                            ],
                          ),
                          ComplainMeLogo(),
                        ],
                      ),

                      CustomTextInput(
                        controller: _firstNameController,
                        label: 'FirstName',
                        hint: 'First Name',
                        icon: Icons.person_outline,
                        isPasswordField: false,
                        textInputType: TextInputType.text,
                      ),
                      CustomTextInput(
                        controller: _lastNameController,
                        label: 'LastName',
                        hint: 'Last Name',
                        icon: Icons.person_outline,
                        isPasswordField: false,
                        textInputType: TextInputType.text,
                      ),
                      CustomTextInput(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'Your Email',
                        icon: Icons.person_outline,
                        isPasswordField: false,
                        textInputType: TextInputType.emailAddress,
                      ),
                      CustomTextInput(
                        controller: _passwordController,
                        label: 'Create Password',
                        hint: 'Create a Password',
                        icon: Icons.lock_outline,
                        isPasswordField: true,
                        textInputType: TextInputType.text,
                      ),

                      CustomTextInput(
                        controller: _usernameController,
                        label: 'Username',
                        hint: 'Your Username',
                        icon: Icons.person_outline,
                        isPasswordField: false,
                        textInputType: TextInputType.text,
                      ),

                      CustomTextInput(
                        controller: _bioController,
                        label: 'Bio',
                        hint: 'Write about Yourself',
                        icon: Icons.person_outline,
                        isPasswordField: false,
                        textInputType: TextInputType.text,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          if (_passwordController.text != "" &&
                              _emailController.text != "") {
                            if (RegExp(// checking for a valid email
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(_emailController.text)) {
                              await registerUser(User(
                                username: _usernameController.text,
                                password: _passwordController.text,
                                bio: _bioController.text,
                                image: _image,
                                lastName: _lastNameController.text,
                                firstName: _firstNameController.text,
                                email: _emailController.text,
                              ));
                            } else {
                              AlertBox.showErrorDialog(context,
                                  AppError(400, "Enter A valid Email"));
                            }
                          } else {
                            AlertBox.showErrorDialog(
                                context,
                                AppError(
                                    400, 'Please fill up all the fields.'));
                          }
                          setState(() {
                            _isLoading = false;
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
                      //Transition to login
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
                            onTap: navigateToLogin,
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
    );
  }
}

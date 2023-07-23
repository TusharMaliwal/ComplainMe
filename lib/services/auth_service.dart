import 'dart:convert';

import 'package:complain_me/models/user_model.dart';
import 'package:complain_me/services/local_storage.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

    Future<void> getUserDetails()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse(kLoadUserDetailsUrl);

    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'email': prefs.getString('login_email')!,
    });

    var streamedresponse = await request.send();
    var response = await http.Response.fromStream(streamedresponse);
    var data  = jsonDecode(response.body.toString());
    await LocalStorage.saveUserDetails(username:data[0]['username'],image:data[0]['image']);

  }

  static Future<String> signupUser(User user) async {
    var url = Uri.parse(kRegisterUrl);

    var request = http.MultipartRequest('POST', url);

    var requestHeaders = {
      'Content-Type': 'multipart/form-data',
    };

    request.files.add(http.MultipartFile(
      'file',
      Stream.value(List<int>.from(user.image!)),
      user.image!.length,
      filename: user.username!,
    ));

    request.headers.addAll(requestHeaders);
    request.fields.addAll({
      'bio': user.bio!,
      'firstName': user.firstName!,
      'lastName': user.lastName!,
      'email': user.email!,
      'password': user.password!,
      'username': user.username!,
    });

    var streamedresponse = await request.send();
    var response = await http.Response.fromStream(streamedresponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var message = jsonDecode(response.body.toString());
      return message;
    }
    return "No connection";
  }

  static Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse(kLoginUrl);
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'email': email,
      'password': password,
    });

    var streamedresponse = await request.send();
    var response = await http.Response.fromStream(streamedresponse);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var message = await  jsonDecode(response.body);
      
      return message;
    }
    return "No connection";
  }


}

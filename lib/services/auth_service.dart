import 'dart:convert';

import 'package:complain_me/models/user_model.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:complain_me/utilities/user_api.dart';
import 'package:http/http.dart' as http;
class AuthService {

    Future<void> getUserDetails({required String email})async{
    UserApi userApi = UserApi.instance;
    var url = Uri.parse(kLoadUserDetailsUrl);
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'email': email,
    });

    var streamedresponse = await request.send();
    var response = await http.Response.fromStream(streamedresponse);
    var data  = jsonDecode(response.body.toString());
    userApi.lname = data[0]['lname'];
    userApi.fname = data[0]['fname'];
    userApi.email = data[0]['email'];
    userApi.username = data[0]['username'];
    userApi.bio = data[0]['bio'];
    userApi.profImage = data[0]['profImage'];
  }


  static Future<String> signupUser(User user) async {
    UserApi userApi = UserApi.instance;
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
    userApi.lname = user.lastName!;
    userApi.fname = user.firstName;
    userApi.email = user.email!;
    userApi.username = user.username!;
    userApi.bio = user.bio!;
    userApi.profImage = user.username!;

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

  signOut() {}


}

import 'dart:convert';

import 'package:complain_me/utilities/constants.dart';
import 'package:http/http.dart' as http;

class UserService {
  //Load post data of a specific username
  getUserPostData(String username) async {
    try {
      var url = Uri.parse(kLoadUserPostsUrl);
      var request = http.MultipartRequest('POST', url);

      var requestHeaders = {
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(requestHeaders);
      request.fields.addAll({
        'username': username,
      });
      var streamedresponse = await request.send();
      var response = await http.Response.fromStream(streamedresponse);
      var data = jsonDecode(response.body.toString());
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

//get user details+user followinf and followers data
  getUserData(String username) async {
    try {
      var url = Uri.parse(kLoadUserDataUrl);
      var request = http.MultipartRequest('POST', url);

      var requestHeaders = {
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(requestHeaders);
      request.fields.addAll({
        'username': username,
      });
      var streamedresponse = await request.send();
      var response = await http.Response.fromStream(streamedresponse);
      var data = jsonDecode(response.body.toString());
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

  //follo
  followUser(String followers, String following) async {
    try {
      var url = Uri.parse(kfollowUserUrl);
      var request = http.MultipartRequest('POST', url);

      var requestHeaders = {
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(requestHeaders);
      request.fields.addAll({
        'followers': followers,
        'following': following,
      });
      var streamedresponse = await request.send();
      var response = await http.Response.fromStream(streamedresponse);
      var data = jsonDecode(response.body.toString());
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

  getUser(String username) async{
    try {
      var url = Uri.parse(kSearchUserUrl);
      var request = http.MultipartRequest('POST', url);

      var requestHeaders = {
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(requestHeaders);
      request.fields.addAll({
        'username':username,
      });
      var streamedresponse = await request.send();
      var response = await http.Response.fromStream(streamedresponse);
      var data = jsonDecode(response.body.toString());
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

  unfollowUser(String followers, String following) async {
    try {
      var url = Uri.parse(kunfollowUserUrl);
      var request = http.MultipartRequest('POST', url);

      var requestHeaders = {
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(requestHeaders);
      request.fields.addAll({
        'followers': followers,
        'following': following,
      });
      var streamedresponse = await request.send();
      var response = await http.Response.fromStream(streamedresponse);
      var data = jsonDecode(response.body.toString());
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

   getTotalPost(String username) async{
    try {
      var url = Uri.parse(kgetTotalPostsUrl);
      var request = http.MultipartRequest('POST', url);

      var requestHeaders = {
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(requestHeaders);
      request.fields.addAll({
        'username': username,
      });
      var streamedresponse = await request.send();
      var response = await http.Response.fromStream(streamedresponse);
      var data = jsonDecode(response.body.toString());
      return data;
    } catch (e) {
      print(e.toString());
    }
  }
}

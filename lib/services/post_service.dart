import 'dart:convert';

import 'package:complain_me/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:complain_me/models/post_model.dart';

class PostService {
  Future<String> uploadPost(
    Post post,
  ) async {
    String res = 'Some Error Occurred';
    try {
      var url = Uri.parse(kUploadPostUrl);

      var request = http.MultipartRequest('POST', url);

      var requestHeaders = {
        'Content-Type': 'multipart/form-data',
      };
      request.files.add(http.MultipartFile(
        'file',
        Stream.value(List<int>.from(post.postImage!)), 
        post.postImage!.length,
        filename: post.username!//+ post.datePublished!,
      ));
      
      request.headers.addAll(requestHeaders);
      request.fields.addAll({
        'description': post.description!,
        //'tags': post.tags!,
        'datePublished': post.datePublished!,
        //'likes': post.likes!,
        'username': post.username!,
      });

      var streamedresponse = await request.send();
      var response = await http.Response.fromStream(streamedresponse);
      //print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var message = jsonDecode(response.body.toString());
        return message;
      }
      return "No connection";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(
    String postID,
    String username,
    List likes,
  ) async {
    try {
      var url;
      //remove Like
      if (likes.contains(username)) {
        likes.remove(username);
        url = Uri.parse(kRemovePostLikeUrl);
      } else {
        //like
        likes.add(username);
        url = Uri.parse(kLikePostUrl);
      }
      var requestHeaders = {
        'Content-Type': 'application/json',
      };

      var requestBody = jsonEncode({
        'username': username,
        'postID': postID,
      });

      await http.post(
        url,
        headers: requestHeaders,
        body: requestBody,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postID) async {
    try {
      var url = Uri.parse(kDeletePostUrl);

      var requestHeaders = {
        'Content-Type': 'application/json',
      };

      var requestBody = jsonEncode({
        'postID': postID,
      });

      await http.post(
        url,
        headers: requestHeaders,
        body: requestBody,
      );
    } catch (e) {
      print(e.toString());
    }
  }

   getPosts() async {
    try {
      var url = Uri.parse(kLoadPostUrl);
      var response = await http.get(url);
      var data  = jsonDecode(response.body.toString());
      return data;
    } catch (e) {
      print(e.toString());
    }
  }
}

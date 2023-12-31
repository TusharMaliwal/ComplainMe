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
        filename: post.username!+ post.datePublished!,
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
        url = Uri.parse(kRemovePostLikeUrl);
      } else {
        //like
        url = Uri.parse(kLikePostUrl);
      }
      var request = http.MultipartRequest('POST', url);

      var requestHeaders = {
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(requestHeaders);
      request.fields.addAll({
        'username': username,
        'postID': postID,
      });
      var streamedresponse = await request.send();
      var response = await http.Response.fromStream(streamedresponse);
      print(jsonDecode(response.body.toString()));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postID) async {
    try {
      var url = Uri.parse(kDeletePostUrl);

      var request = http.MultipartRequest('POST', url);

      var requestHeaders = {
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(requestHeaders);
      request.fields.addAll({
        'postID': postID,
      });
      await request.send();
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

  getComments(String postID) async{
    try {
      var url = Uri.parse(kLoadCommentsUrl);
      var request = http.MultipartRequest('POST', url);

      var requestHeaders = {
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(requestHeaders);
      request.fields.addAll({
        'postID': postID,
      });
      var streamedresponse = await request.send();
      var response = await http.Response.fromStream(streamedresponse);
      var data  = jsonDecode(response.body.toString());
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

  postComment(String postID, String text, String username) async{
    try {
      var url = Uri.parse(kPostCommentUrl);
      var request = http.MultipartRequest('POST', url);

      var requestHeaders = {
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(requestHeaders);
      request.fields.addAll({
        'postID': postID,
        'comment':text,
        'username':username,
      });
      await request.send();
    } catch (e) {
      print(e.toString());
    }
  }
}



import 'dart:typed_data';

class Post {

  final String? username;
  final Uint8List? profileImage;
  final String? description;
  final Uint8List? postImage;
  final List<String>? tags;
  final int? commentsCount;
  final String? datePublished;
  final likes;

  Post( {

    this.username,
    this.profileImage,
    this.description,
    this.postImage,
    this.tags,

    this.datePublished,
    this.commentsCount = 0,
    this.likes,
  });

  // TODO: Update this
  static Post fromJson(data) {
    return Post(
      description: data['description'],
      datePublished: data['datePublished'],
      username: data['userId']['username'],
      postImage: data['image'],
      profileImage: data['userId']['image'],
      commentsCount: data['commentCount'],
      likes: data['likes'],
      tags: List.generate(
        data['tags'].length,
        (index) => data['tags'][index]['name'],
      ),
    );
  }

  // TODO: Update this
  Map<String,dynamic>toJson()=>{
    'description':description,
    'username': username,
    'postImage': postImage,
    'datePublished': datePublished,
    'profileImage': profileImage,
    'likes': likes,
  };
  
}

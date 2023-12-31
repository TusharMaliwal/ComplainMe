import 'dart:typed_data';

class User {
  //late String? id;
  late String? username;
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? password;
  late Uint8List? image;
  late String? bio;

  User({
    //this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.image,
    this.bio,
  });

  static User fromJson(data) {
    return User(
      //id: data['_id'],
      bio: data['bio'],
      email: data['email'],
      username: data['username'],
      image: data['image'],
      firstName: data['firstName'],
      lastName: data['lastName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'bio': bio,
        'username': username,
        'image': image,
        'email': email,
        'lastName': lastName,
        'firstName': firstName,
      };
}

// This class will be used to store all the user data, which will be available globally within the app

class UserApi {

  UserApi._privateConstructor();

  static final UserApi _instance = UserApi._privateConstructor();
  static UserApi get instance => _instance;

  String? email;
  String? lname;
  String? fname;
  String? username;

  String? profImage;
  String? bio;

  UserApi({ required this.email, required this.fname,required this.lname,required this.username,required this.profImage,required this.bio,});

}
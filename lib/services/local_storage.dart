import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _preferences;
  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveLoginInfo(
      {required String statusCode, required String email}) async {
    await _preferences.setString('login_status', statusCode);
    await _preferences.setString('login_email', email);
  }

  static Future<void> removeLoginInfo() async {
    await _preferences.setString('login_status', 'NO');
    await _preferences.setString('login_email', 'No');
  }

  static Future<void> saveUserDetails({required String username,required String image})async{
    await _preferences.setString('username',username);
    await _preferences.setString('profileImage', image);
    //await _preferences.set
  }

}

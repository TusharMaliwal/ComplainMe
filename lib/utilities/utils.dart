import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagepicker = ImagePicker();

  XFile? _file = await _imagepicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No Image Selected");
}

getProfileImage() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('profileImage') as Uint8List;
  }

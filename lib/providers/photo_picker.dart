import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoPicker {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (image == null) return null;
    final imageFromPath = File(image.path);
    return imageFromPath;
  }
}

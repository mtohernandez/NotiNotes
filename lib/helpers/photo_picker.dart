import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'dart:io';

class PhotoPicker {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage(ImageSource source) async {
    final imageFile = await _picker.pickImage(source: source);
    if (imageFile == null) return null;
    File storedImage = File(imageFile.path);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await storedImage.copy('${appDir.path}/$fileName');
    final imageFromPath = savedImage;
    return imageFromPath;
  }

  static Future<void> removeImage(File image) async {
    await image.delete();
  }
}

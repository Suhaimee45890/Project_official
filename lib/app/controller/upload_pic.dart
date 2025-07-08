import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class UploadImg {
  final ImagePicker imagePicker = ImagePicker();

  Future<String> pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      return "No Image";
    } else {
      return pickedFile.path;
    }
  }

  Future<File> resizeImage(String imagePath, {int maxWidth = 800}) async {
    final originalFile = File(imagePath);
    final bytes = await originalFile.readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) throw Exception("Cannot decode image");

    // Resize → ลดขนาดแต่รักษาอัตราส่วน
    final resized = img.copyResize(image, width: maxWidth);

    // บันทึกไฟล์ใหม่ชั่วคราว
    final tempDir = await getTemporaryDirectory();
    final resizedPath = "${tempDir.path}/${tempDir.path.split("/").last}";
    final resizedFile = File(resizedPath)
      ..writeAsBytesSync(img.encodeJpg(resized, quality: 85));

    return resizedFile;
  }

  Future<String> uploadToCld(String imagePath) async {
    final File imgFile = await resizeImage(imagePath);
    final imgData = FormData.fromMap({
      "upload_preset": "allhallal_app",
      "file": await MultipartFile.fromFile(imgFile.path),
    });
    try {
      final res = await Dio().post(
        "https://api.cloudinary.com/v1_1/dzd7lt1ck/image/upload",
        data: imgData,
      );
      if (res.statusCode == 200) {
        return res.data["secure_url"];
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}

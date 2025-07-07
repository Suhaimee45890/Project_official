import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadImg {
  final ImagePicker imagePicker = ImagePicker();
  final sendApi = GetConnect();

  Future<String> pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      return "No Image";
    } else {
      return pickedFile.path;
    }
  }

  Future<String> uploadToCld(String imagePath) async {
    final File? imgFile = File(imagePath);
    if (imgFile == null) {
      Get.snackbar("error", "cannot find img file");
      return "No img";
    } else {
      final cldUrl = "https://api.cloudinary.com/v1_1/dzd7lt1ck/image/upload";
      final imgData = MultipartFile(
        imgFile,
        filename: imagePath.split("/").last,
      );
      try {
        Response res = await sendApi.post(
          cldUrl,
          FormData({"upload_preset": "AllHalal", "file": imgData}),
        );
        print(res.body);
        return res.body["secure_url"];
      } catch (e) {
        print(e);
        Get.snackbar("error", "cannot upload");
        return "";
      } finally {
        Get.snackbar("secess", "uploaded");
      }
    }
  }
}

import 'package:get_storage/get_storage.dart';

class Storage {
  final storageBox = GetStorage();

  void saveData(
    String uid,
    String email,
    String name,
    String lastName,
    String birthday,
  ) {
    storageBox.write("userId", uid);
    storageBox.write("email", email);
    storageBox.write("name", name);
    storageBox.write("lastname", lastName);
    storageBox.write("birthday", birthday);
    storageBox.write("isLogin", true);
  }

  String readData() {
    return storageBox.read("userId");
  }

  Map<String, String> readAllData() {
    return {
      "userId": storageBox.read("userId") ?? "id Not found",
      "email": storageBox.read("email") ?? "email not found",
      "name": storageBox.read("name") ?? "name not found",
      "lastname": storageBox.read("lastname") ?? "last name not found",
      "birthday": storageBox.read("birthday") ?? "birthday not found",
    };
  }

  bool isLogin() {
    return storageBox.read('isLogin') ?? false;
  }

  bool isAlert() {
    return storageBox.read("isAlert") ?? false;
  }

  void setNoti() {
    storageBox.write("isAlert", true);
  }

  void nonNoti() {
    storageBox.write("isAlert", false);
  }

  // ✅ เพิ่มสำหรับ key-value เดี่ยว เช่น imageUrl
  void saveSingleData(String key, String value) {
    storageBox.write(key, value);
  }

  String? readSingleData(String key) {
    return storageBox.read(key);
  }
}

import 'package:get_storage/get_storage.dart';

class Storage {
  final storageBox = GetStorage();

  saveData(
    String uid,
    String email,
    String name,
    String lastName,
    String birthday,
  ) {
    storageBox.write("userId", uid);
    storageBox.write("userId", email);
    storageBox.write("userId", name);
    storageBox.write("userId", lastName);
    storageBox.write("userId", birthday);
    storageBox.write("isLogin", true);

    // storageBox.read("userId", uid);
    // storageBox.read("userId", email);
    // storageBox.read("userId", name);
    // storageBox.read("userId", lastName);
    // storageBox.read("userId", birthday);
    // storageBox.read("isLogin", true);
  }

  String readData() {
    return storageBox.read("userId");
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
}

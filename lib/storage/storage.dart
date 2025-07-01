import 'package:get_storage/get_storage.dart';

class Storage {
  final storageBox = GetStorage();

  saveData(String value) {
    storageBox.write("userId", value);
    storageBox.write("isLogin", true);
  }

  String readData() {
    return storageBox.read("userId");
  }

  bool isLogin() {
    return storageBox.read('isLogin') ?? false;
  }
}

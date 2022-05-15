import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parking/screens/auth/login/loginPage.dart';

import '../../models/end_user.dart';

class RememberController extends GetxController {
  RememberAdmin(EndUser user) {
    var storage = GetStorage();
    token(1);
    storage.write("user", {
      'email': user.email,
      'name': user.username,
      'phone': user.phone,
      'lastname': user.lastname,
      'id': user.uid,
      'email': user.email
    });
  }

  RememberClient(EndUser user) {
    var storage = GetStorage();
    token(2);
    storage.write("user", {
      'email': user.email,
      'name': user.username,
      'phone': user.phone,
      'lastname': user.lastname,
      'id': user.uid,
      'email': user.email,
      'car': user.registration,
    });
  }

  token(int index) {
    var storage = GetStorage();
    storage.write("auth", 1);
    storage.write("type_auth", index);
  }

  Logout() async {
    var storage = GetStorage();
    storage.write("auth", 0);
    storage.remove("user");
    Get.to(Login());
  }

  check() {
    var storage = GetStorage();
    storage.write("seen", 1);
  }
}

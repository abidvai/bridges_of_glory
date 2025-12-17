import 'package:bridges_of_glory/views/auth/signup/controller/signup_Controller.dart';
import 'package:get/get.dart';

import '../../views/auth/login/controller/login_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupController(), permanent: true);
    Get.put(LoginController(), permanent: true);
  }
}

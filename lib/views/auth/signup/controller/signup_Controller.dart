import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  RxString selectedUser = RxString('');
  RxBool isCheck = RxBool(false);
  String otp = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rewritePasswordController = TextEditingController();

  RxInt seconds = RxInt(60);
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value == 0) {
        timer.cancel();
      } else {
        seconds.value--;
      }
    });
  }
}

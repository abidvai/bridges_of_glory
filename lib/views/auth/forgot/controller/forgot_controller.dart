

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rewritePasswordController = TextEditingController();

  String otp = '';
}
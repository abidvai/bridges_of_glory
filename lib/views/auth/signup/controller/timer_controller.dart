import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  var seconds = 60.obs;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value == 0) {
        timer.cancel();
      } else {
        seconds.value--;
      }
    });
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}

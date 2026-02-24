import 'package:bridges_of_glory/core/common_widgets/custom_toast.dart';
import 'package:bridges_of_glory/service/payment/payment_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final PaymentService _paymentService = PaymentService();
  TextEditingController noticeController = TextEditingController();
  var selectedPayment = ''.obs;
  RxBool isLoading = RxBool(false);
  RxBool isLoading2 = RxBool(false);

  Future<String?> payment(
    int projectId,
    String projectName,
    String supportType,
    double amount,
  ) async {
    isLoading.value = true;

    if (selectedPayment.value == 'paypal') {
      final response = await _paymentService.papalPay(
        projectId,
        projectName,
        supportType,
        amount,
      );
      if (response.data != null) {
        isLoading.value = false;
        return response.data!.approvalUrl;
      } else {
        isLoading.value = false;
        return null;
      }
    } else if (selectedPayment.value == 'stripe') {
      final response = await _paymentService.stripePay(
        projectId,
        projectName,
        supportType,
        amount,
      );
      if (response.data != null) {
        isLoading.value = false;
        return response.data!.checkoutUrl;
      } else {
        print(response.error);
      }
    }
    return null;
  }

  Future<bool> sendEmailPay(int projectId, String message) async {
    isLoading2.value = true;
    final response = await _paymentService.sentMail(projectId, message);

    if (response.data == true) {
      isLoading2.value = false;
      showCustomToast(
        text:
            'Email sent successfully to admin. Please wait for admin response. Thank you',
        toastType: ToastTypesInfo(ToastTypes.success),
      );

      return true;
    } else {
      isLoading2.value = false;
      showCustomToast(text: 'Something went wrong 404. please try again.');

      return false;
    }
  }
}

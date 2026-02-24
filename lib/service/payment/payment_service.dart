import 'package:bridges_of_glory/model/donation_pay_model.dart';
import 'package:bridges_of_glory/model/paypal_pay_model.dart';
import 'package:bridges_of_glory/utils/api_response.dart';
import 'package:bridges_of_glory/utils/custom_http.dart';

class PaymentService {
  Future<ApiResponse<bool>> fetchOtp(String userId) async {
    try {
      final response = await CustomHttp.post(
        endpoint: 'auth/resend-verification-code',
        showFloatingError: false,
        needAuth: false,
        body: {'user_id': userId},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return ApiResponse.success(true);
      } else {
        final error = response.error!;
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<bool>> submitOtp(String userId, String otp) async {
    try {
      final response = await CustomHttp.post(
        endpoint: 'auth/resend-verification-code',
        showFloatingError: false,
        needAuth: true,
        body: {'user_id': userId, 'verification_code': otp},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return ApiResponse.success(true);
      } else {
        final error = response.error!;
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<StripePayModel>> stripePay(
    int projectId,
    String projectName,
    String supportType,
    double amount,
  ) async {
    try {
      final response = await CustomHttp.post(
        endpoint: 'donation/stripe/create-donation-checkout-session',
        showFloatingError: false,
        needAuth: true,
        body: {
          'project_id': projectId,
          'project_name': projectName,
          'support_type': supportType,
          'price_usd': amount,
        },
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final StripePayModel data = StripePayModel.fromJson(response.data);
        return ApiResponse.success(data);
      } else {
        final error = response.error!;
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<PaypalPayModel>> papalPay(
    int projectId,
    String projectName,
    String supportType,
    double amount,
  ) async {
    try {
      final response = await CustomHttp.post(
        endpoint: 'donation/paypal/create-checkout',
        showFloatingError: false,
        needAuth: true,
        body: {
          'project_id': projectId,
          'project_name': projectName,
          'support_type': supportType,
          'price_usd': amount,
        },
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final PaypalPayModel data = PaypalPayModel.fromJson(response.data);
        return ApiResponse.success(data);
      } else {
        final error = response.error!;
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<bool>> sentMail(int projectId, String message) async {
    try {
      final response = await CustomHttp.post(
        endpoint: 'donation/send-email',
        showFloatingError: false,
        needAuth: true,
        body: {'project_id': projectId, 'message': message},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return ApiResponse.success(true);
      } else {
        final error = response.error!;
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}

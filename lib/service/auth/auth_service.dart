import 'dart:convert';

import 'package:bridges_of_glory/utils/api_response.dart';
import 'package:bridges_of_glory/utils/custom_http.dart';

import '../../model/login_model.dart';
import '../../utils/helper/app_helper.dart';

class AuthService {

  /// ------------------------------------ signup ---------------------------------------- ///
  Future<ApiResponse<bool>> signup(
    String name,
    String email,
    String password,
    String confirmPassword,
    bool isTermAgreed,
  ) async {
    try {
      final response = await CustomHttp.post(
        endpoint: '/auth/sign-up',
        body: {
          'full_name': name,
          'email_address': email,
          'password': password,
          'confirm_password': confirmPassword,
          'terms_agreed': isTermAgreed,
        },
        needAuth: false
      );

      if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 203) {
        await AppHelper.instance.setUserId(response.data['user_id']);
        return ApiResponse.success(true);
      } else {
        final json = jsonDecode(response.error!);
        final errorMessage = json['email_address'];

        return ApiResponse.error(errorMessage!);
      }
    } catch (e) {
      print(e.toString());
      return ApiResponse.error('Something went wrong 404');
    }
  }

  /// ------------------------- signup Email verification --------------------------------- ///
  Future<ApiResponse<LoginModel>> verifyEmailSign(
      String verificationCode,
      String userId,
      ) async {
    final response = await CustomHttp.post(
      endpoint: 'auth/verify-email',
      body: {'user_id': userId, 'verification_code': verificationCode},
      needAuth: false,
      showFloatingError: false,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' ----------------------- >  ${response.data['access_token']}');


      await AppHelper.instance.setAccessToken(response.data['access_token']);
      await AppHelper.instance.setRefToken(response.data['refresh_token']);
      await AppHelper.instance.setTokenValidity(response.data['access_token_valid_till']);
      await AppHelper.instance.setRole(response.data['role']);

      final token = await AppHelper.instance.getAccessToken();
      print(' ====================================> ${token}');

      final loginModel = LoginModel.fromJson(response.data);
      return ApiResponse.success(loginModel);
    } else {
      final json = jsonDecode(response.error!);
      final errorMessage = json['message'];

      return ApiResponse.error(errorMessage!);
    }
  }

  /// ------------------------- signIn   --------------------------------- ///
  Future<ApiResponse<LoginModel>> signIn(String email, String password) async {
    final response = await CustomHttp.post(
      endpoint: 'auth/sign-in',
      body: {'email_address': email, 'password': password},
      needAuth: false,
      showFloatingError: false,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      AppHelper.instance.setAccessToken(response.data['access_token']);
      AppHelper.instance.setRefToken(response.data['refresh_token']);
      AppHelper.instance.setTokenValidity(response.data['access_token_valid_till']);
      AppHelper.instance.setUserId(response.data['user_id']);
      AppHelper.instance.setAuthRole(response.data['role']);


      final loginModel = LoginModel.fromJson(response.data);
      return ApiResponse.success(loginModel);
    } else {
      try {
        if (response.data != null && response.data.isNotEmpty) {
          final json = jsonDecode(response.error!);
          final errorMessage = json['message'];

          return ApiResponse.error(errorMessage!);
        }
      } catch (e) {
        print("Failed to parse error JSON: $e");
      }
    }

    return ApiResponse.error('Email and password is not matched!');
  }

  /// ------------------ Refresh token ------------------------------- ///
  Future<void> getRefAccessToken() async {
    final refToken = await AppHelper.instance.getRefToken();
    final response = await CustomHttp.post(
      endpoint: 'auth/refresh',
      needAuth: false,
      body: {'refresh_token': refToken},
    );

    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 204) {
      await AppHelper.instance.setAccessToken('access_token');
    } else {
      print(response.statusCode);
    }
  }

  /// ------------------------- forget password or reset password   --------------------------------- ///
  Future<ApiResponse<bool>> forgetPassEmail(String email) async {
    final response = await CustomHttp.post(
      endpoint: 'auth/forgot-password',
      body: {'email_address': email},
      needAuth: false,
      showFloatingError: false,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      await AppHelper.instance.setUserId(response.data['user_id']);

      return ApiResponse.success(true);
    } else {
      final decoded = jsonDecode(response.error ?? 'something went wrong');
      String emailError = decoded['message'] ?? 'Unknown error';

      return ApiResponse.error(emailError);
    }
  }

  /// ------------------------- forget password Email OTP verification --------------------------------- ///
  Future<ApiResponse<bool>> resetPassEmailVerify(
      String verificationCode,
      int userId,
      ) async {
    final response = await CustomHttp.post(
      endpoint: 'auth/verify-reset-code',
      body: {'user_id': userId, 'verification_code': verificationCode},
      needAuth: false,
      showFloatingError: false,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      AppHelper.instance.setSecretKey(response.data['secret_key']);
      return ApiResponse(success: true, data: true);
    } else {
      final json = jsonDecode(response.error!);
      final errorMessage = json['message'];

      return ApiResponse.error(errorMessage!);
    }
  }

  /// ------------------------- reset Password --------------------------------- ///
  Future<ApiResponse<bool>> resetPass(
      int userId,
      String secretKey,
      String newPassword,
      ) async {
    final response = await CustomHttp.post(
      endpoint: 'auth/reset-password',
      body: {
        'user_id': userId,
        'secret_key': secretKey,
        'new_password': newPassword,
      },
      needAuth: false,
      showFloatingError: false,
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return ApiResponse(data: true, success: true);
    } else {
      final decoded = jsonDecode(response.error ?? 'something went wrong');
      String emailError = decoded['message'] ?? 'Unknown error';

      return ApiResponse.error(emailError);
    }
  }
}

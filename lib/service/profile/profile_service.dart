import 'dart:convert';

import 'package:bridges_of_glory/utils/custom_http.dart';

import '../../utils/api_response.dart';

class ProfileService {
  /// ----------------------------- Change password -------------------------------- ///
  Future<ApiResponse<bool>> changePassword(
    String toke,
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      final response = await CustomHttp.post(
        endpoint: 'auth/change-password',
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        },
        needAuth: true,
        showFloatingError: false
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {

        return ApiResponse.success(true);
      } else {
        final json = jsonDecode(response.error!);
        final errorMessage = json['message'];

        return ApiResponse.error(errorMessage!);
      }
    } catch (e) {
      print(e.toString());
      return ApiResponse.error('Something went wrong 404');
    }
  }
}

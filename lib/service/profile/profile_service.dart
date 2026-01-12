import 'dart:convert';
import 'dart:io';

import 'package:bridges_of_glory/model/privacy_model.dart';
import 'package:bridges_of_glory/model/profile_info_model.dart';
import 'package:bridges_of_glory/utils/custom_http.dart';
import 'package:http/http.dart' as http;
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
        showFloatingError: false,
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

  /// ------------------------------- fetch profile info ------------------------------------- ///
  Future<ApiResponse<ProfileInfoModel>> fetchUserInfo() async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'settings/personal-info/me',
        needAuth: true,
        showFloatingError: false,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final json = response.data;

        final userInfo = ProfileInfoModel.fromJson(json);

        return ApiResponse.success(userInfo);
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

  /// ------------------------------- fetch privacy ------------------------------------- ///
  Future<ApiResponse<List<PrivacyModel>>> fetchPrivacy() async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'settings/user/privacy-policy',
        needAuth: true,
        showFloatingError: false,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final List<dynamic> json = response.data;

        List<PrivacyModel> privacy = json
            .map((e) => PrivacyModel.fromJson(e))
            .toList();

        return ApiResponse.success(privacy);
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

  /// ------------------------------- update image ------------------------------------- ///
  Future<ApiResponse<ProfileInfoModel>> updateProfilePic(File image) async {
    try {
      File imageFile = File(image.path);

      var multipartFile = await http.MultipartFile.fromPath(
        'avatar',
        imageFile.path,
      );

      final response = await CustomHttp.multipart(
        endpoint: 'settings/personal-info/me',
        method: CommonCustomMethods.PUT,
        files: [multipartFile],
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final json = response.data;

        final userInfo = ProfileInfoModel.fromJson(json);

        return ApiResponse.success(userInfo);
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

  /// ------------------------------- update name ------------------------------------- ///
  Future<ApiResponse<ProfileInfoModel>> updateName(String name) async {
    try {
      final response = await CustomHttp.put(
        endpoint: 'settings/personal-info/me',
        needAuth: true,
        showFloatingError: false,
        body: {'full_name': name},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final json = response.data;

        final userInfo = ProfileInfoModel.fromJson(json);

        return ApiResponse.success(userInfo);
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

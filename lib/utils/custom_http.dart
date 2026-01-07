import 'dart:convert';

import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_credential/app_credential.dart';
import '../core/common_widgets/custom_toast.dart';
import 'has_internet.dart';
import 'helper/app_helper.dart';

class CustomHttpResult {
  final dynamic data;
  final int statusCode;
  final String? error;

  const CustomHttpResult({this.data, required this.statusCode, this.error});
}

enum CommonCustomMethods { POST, PUT, PATCH, DELETE }

class CustomHttp {
  static Future<CustomHttpResult> get({
    required String endpoint,
    bool showFloatingError = true,
    bool needAuth = false,
    Map<String, String>? headers,
    Map<String, dynamic>? queries,
  }) async {
    if (!await hasInternet(showError: true)) {
      return CustomHttpResult(
        statusCode: -1,
        error: 'No internet connection found!',
      );
    }

    try {
      Map<String, String> _headers = {'Content-Type': 'application/json'};

      if (needAuth) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        int? accessTokenValidTill = localStorage.getInt(
          'access_token_valid_till',
        );

        print(accessTokenValidTill);

        if (accessTokenValidTill == null ||
            accessTokenValidTill < DateTime.now().millisecondsSinceEpoch) {
          if (!await setNewAccessToken()) {
            // Get.offAllNamed(AppRoutes.splashScreen);
            return CustomHttpResult(
              statusCode: 401,
              error: 'Session expired, Please sign in again!',
            );
          }
        }

        String? accessToken = localStorage.getString('access_token');
        _headers['Authorization'] = 'Bearer $accessToken';

        final cookie = localStorage.getString('cookie');
        if (cookie != null) {
          _headers['Cookie'] = cookie;
        }
      }

      if (headers != null) {
        _headers.addAll(headers);
      }

      var url = '${AppCredentials.domain}/api/v1/$endpoint';

      if (queries != null) {
        url += '?';

        queries.forEach((key, value) {
          if (value.runtimeType == List) {
            for (var i = 0; i < value.length; i++) {
              url += '$key=${value[i]}&';
            }
          } else {
            url += '$key=$value&';
          }
        });
        url = url.substring(0, url.length - 1);
      }

      final uri = Uri.parse(url);

      debugPrint('');
      debugPrint('<===== GET REQUEST =====>');
      debugPrint('url: $url');
      debugPrint('headers: $_headers');
      debugPrint('');

      final response = await http.get(uri, headers: _headers);
      return handleResponse(response, showFloatingError);
    } catch (e) {
      debugPrint('');
      debugPrint('<===== GET REQUEST =====>');
      debugPrint('url: $endpoint');
      debugPrint('error: ${e.toString()}');
      debugPrint('');
      return CustomHttpResult(statusCode: -2, error: e.toString());
    }
  }

  static Future<CustomHttpResult> post({
    required String endpoint,
    Map<String, String>? headers,
    dynamic body,
    bool showFloatingError = true,
    bool needAuth = true,
  }) async {
    return await commonRequests(
      endpoint: endpoint,
      headers: headers,
      body: body,
      showFloatingError: showFloatingError,
      needAuth: needAuth,
      method: CommonCustomMethods.POST,
    );
  }

  static Future<CustomHttpResult> patch({
    required String endpoint,
    Map<String, String>? headers,
    dynamic body,
    bool showFloatingError = true,
    bool needAuth = true,
  }) async {
    return await commonRequests(
      endpoint: endpoint,
      headers: headers,
      body: body,
      showFloatingError: showFloatingError,
      needAuth: needAuth,
      method: CommonCustomMethods.PATCH,
    );
  }

  static Future<CustomHttpResult> put({
    required String endpoint,
    Map<String, String>? headers,
    dynamic body,
    bool showFloatingError = true,
    bool needAuth = true,
  }) async {
    return await commonRequests(
      endpoint: endpoint,
      headers: headers,
      body: body,
      showFloatingError: showFloatingError,
      needAuth: needAuth,
      method: CommonCustomMethods.PUT,
    );
  }

  static Future<CustomHttpResult> delete({
    required String endpoint,
    Map<String, String>? headers,
    dynamic body,
    bool showFloatingError = true,
    bool needAuth = true,
  }) async {
    return await commonRequests(
      endpoint: endpoint,
      headers: headers,
      body: body,
      showFloatingError: showFloatingError,
      needAuth: needAuth,
      method: CommonCustomMethods.DELETE,
    );
  }

  static Future<CustomHttpResult> multipart({
    required String endpoint,
    required CommonCustomMethods method,
    Map<String, String>? headers,
    Map<String, String> fields = const {},
    List<http.MultipartFile> files = const [],
  }) async {
    final url = '${AppCredentials.domain}/api/v1/$endpoint';
    final uri = Uri.parse(url);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('access_token');

    var request = http.MultipartRequest(method.name, uri);
    Map<String, String> _headers = {'Authorization': 'Bearer $token'};
    _headers.addAll(headers ?? {});

    request.headers.addAll(_headers);
    fields.forEach((key, value) => request.fields[key] = value);
    files.forEach((file) => request.files.add(file));

    debugPrint('');
    debugPrint('<===== ${method.name} REQUEST =====>');
    debugPrint('url: $url');
    debugPrint('headers: $_headers');
    debugPrint('');

    try {
      // Send request
      var response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();

        // Uint8List encodedJson = Uint8List.fromList(body.codeUnits);
        return CustomHttpResult(
          statusCode: response.statusCode,
          data: jsonDecode(body)['data'],
        );
      } else {
        return CustomHttpResult(
          statusCode: response.statusCode,
          error: await response.stream.bytesToString(),
        );
      }
    } catch (e) {
      debugPrint('');
      debugPrint('<===== ${method.name} REQUEST =====>');
      debugPrint('url: $endpoint');
      debugPrint('error: ${e.toString()}');
      debugPrint('');
      return CustomHttpResult(statusCode: -2, error: e.toString());
    }
  }

  static Future<CustomHttpResult> commonRequests({
    required String endpoint,
    Map<String, String>? headers,
    dynamic body,
    bool showFloatingError = true,
    bool needAuth = true,
    required CommonCustomMethods method,
    bool retry = true,
  }) async {
    if (!await hasInternet(showError: true)) {
      return CustomHttpResult(
        statusCode: -1,
        error: 'No internet connection found!',
      );
    }

    try {
      Map<String, String> _headers = {'Content-Type': 'application/json'};
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      // -------------------- Handle Auth --------------------
      if (needAuth) {
        int? accessTokenValidTill = localStorage.getInt('access_token_valid_till');


        if (accessTokenValidTill == null ||
            accessTokenValidTill < DateTime.now().millisecondsSinceEpoch) {
          bool refreshed = await setNewAccessToken();
          if (!refreshed) {
            // Token cannot be refreshed
            return CustomHttpResult(
              statusCode: 401,
              error: 'Session expired, Please sign in again!',
            );
          }
        }

        String? accessToken = await AppHelper.instance.getAccessToken();
        if (accessToken != null) {
          _headers['Authorization'] = 'Bearer $accessToken';
        }

        final cookie = localStorage.getString('cookie');
        if (cookie != null) {
          _headers['Cookie'] = cookie;
        }
      }

      if (headers != null) {
        _headers.addAll(headers);
      }

      final url = '${AppCredentials.domain}/api/v1/$endpoint';
      final uri = Uri.parse(url);

      debugPrint('');
      debugPrint('<===== ${method.name} REQUEST =====>');
      debugPrint('url: $url');
      debugPrint('headers: $_headers');
      debugPrint('body: ${jsonEncode(body ?? {})}');
      debugPrint('');

      late http.Response response;

      // -------------------- Send Request --------------------
      if (method == CommonCustomMethods.POST) {
        response = await http.post(
          uri,
          body: jsonEncode(body ?? {}),
          headers: _headers,
          encoding: Encoding.getByName('utf-8'),
        );
      } else if (method == CommonCustomMethods.PUT) {
        response = await http.put(
          uri,
          body: jsonEncode(body ?? {}),
          headers: _headers,
          encoding: Encoding.getByName('utf-8'),
        );
      } else if (method == CommonCustomMethods.PATCH) {
        response = await http.patch(
          uri,
          body: jsonEncode(body ?? {}),
          headers: _headers,
          encoding: Encoding.getByName('utf-8'),
        );
      } else if (method == CommonCustomMethods.DELETE) {
        response = await http.delete(
          uri,
          body: jsonEncode(body ?? {}),
          headers: _headers,
          encoding: Encoding.getByName('utf-8'),
        );
      }

      // -------------------- Handle Set-Cookie --------------------
      if (response.headers['set-cookie'] != null) {
        String cookie = response.headers['set-cookie']!;
        localStorage.setString('cookie', cookie);
      }

      // -------------------- Auto Refresh & Retry --------------------
      if (response.statusCode == 401 && retry) {
        bool refreshed = await setNewAccessToken();
        if (refreshed) {
          // Retry the same request once
          return commonRequests(
            endpoint: endpoint,
            headers: headers,
            body: body,
            showFloatingError: showFloatingError,
            needAuth: needAuth,
            method: method,
            retry: false, // prevent infinite loop
          );
        }
      }

      // -------------------- Handle Response --------------------
      return handleResponse(response, showFloatingError);

    } catch (e) {
      debugPrint('<===== ${method.name} REQUEST ERROR =====>');
      debugPrint('url: $endpoint');
      debugPrint('error: ${e.toString()}');
      debugPrint('');
      return CustomHttpResult(statusCode: -2, error: e.toString());
    }
  }


  static Future<bool> setNewAccessToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? refreshToken = await AppHelper.instance.getRefToken();
    String? userId = await AppHelper.instance.getUserId();

    if (refreshToken == null || userId == null) {
      await localStorage.clear();
      return false;
    }

    var response = await http.post(
      Uri.parse('${AppCredentials.domain}/api/v1/auth/refresh'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      localStorage.setString('access_token', data['accessToken']);
      localStorage.setString(
        'access_token_valid_till',
        data['decodedData']['exp'],
      );
      return true;
    } else {
      await localStorage.clear();
      return false;
    }
  }

  static CustomHttpResult handleResponse(
    http.Response response,
    bool showFloatingError,
  ) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Uint8List encodedJson = Uint8List.fromList(response.body.codeUnits);
      return CustomHttpResult(
        statusCode: response.statusCode,
        data: jsonDecode(response.body),
      );
    } else {
      debugPrint('<============ Response ===========>');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('');
      late String message;
      try {
        final body = jsonDecode(response.body);
        message = body['errors'][0];
      } catch (e) {
        message = response.body.toString();

        // if (response.statusCode == 404) {
        //   message = 'End point not found!';
        // } else if (response.statusCode == 400) {
        //   message = response.body.toString();
        // } else {
        //   message = "Something went wrong ...";
        // }
      }

      if (showFloatingError) {
        showCustomToast(text: message);
      }

      return CustomHttpResult(statusCode: response.statusCode, error: message);
    }
  }
}

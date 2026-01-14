import 'dart:convert';

import 'package:bridges_of_glory/model/book_details_model.dart';
import 'package:bridges_of_glory/model/book_list_model.dart';
import 'package:bridges_of_glory/utils/api_response.dart';
import 'package:bridges_of_glory/utils/custom_http.dart';

class LibraryService {
  Future<ApiResponse<BookListModel>> fetchBookList() async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'books/list',
        needAuth: true,
        showFloatingError: false,
      );

      if (response.statusCode == 200 || response.statusCode == 201 ||
          response.statusCode == 204) {
        final json = response.data;
        final data = BookListModel.fromJson(json);

        return ApiResponse.success(data);
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

  Future<ApiResponse<BookDetailsModel>> fetchBookDetailsPdf(int bookId, String lan) async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'books/user/details/$bookId?lang=$lan',
        needAuth: true,
        showFloatingError: false,
      );

      if (response.statusCode == 200 || response.statusCode == 201 ||
          response.statusCode == 204) {
        final json = response.data;
        final data = BookDetailsModel.fromJson(json);

        return ApiResponse.success(data);
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
  //
}

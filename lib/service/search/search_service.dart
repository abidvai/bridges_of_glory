import 'dart:convert';

import 'package:bridges_of_glory/model/project_model.dart';
import 'package:bridges_of_glory/utils/api_response.dart';
import 'package:bridges_of_glory/utils/custom_http.dart';

class SearchService {
  Future<ApiResponse<List<ProjectModel>>> search(
  {int? categoryID,
    required String searchText,}
  ) async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'projects/home?category_id=${categoryID?.toString() ?? ''}&search=$searchText',
        needAuth: true,
        showFloatingError: false,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final List<dynamic> json = response.data;

        final List<ProjectModel> project = json
            .map((e) => ProjectModel.fromJson(e))
            .toList();

        return ApiResponse.success(project);
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

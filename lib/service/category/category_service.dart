import 'dart:convert';
import 'package:bridges_of_glory/model/category_model.dart';
import 'package:bridges_of_glory/model/category_wise_project_model.dart';
import 'package:bridges_of_glory/utils/api_response.dart';
import 'package:bridges_of_glory/utils/custom_http.dart';
import 'package:bridges_of_glory/views/donation/home/category_wise_project_screen.dart';

class CategoryService {
  Future<ApiResponse<List<CategoryModel>>> fetchCategory() async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'projects/categories',
        needAuth: true,
        showFloatingError: false,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final List<dynamic> json = response.data;

        final List<CategoryModel> categoryList = json
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        return ApiResponse.success(categoryList);
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

  Future<ApiResponse<List<CategoryWiseprojectModel>>> fetchCategoryWiseProject(int id) async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'projects/home?category_id=$id',
        needAuth: true,
        showFloatingError: false,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final List<dynamic> json = response.data;

        final List<CategoryWiseprojectModel> categoryProjectList = json
            .map((e) => CategoryWiseprojectModel.fromJson(e))
            .toList();

        return ApiResponse.success(categoryProjectList);
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

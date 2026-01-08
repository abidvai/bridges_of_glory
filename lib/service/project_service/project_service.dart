import 'dart:convert';

import 'package:bridges_of_glory/model/project_model.dart';
import 'package:bridges_of_glory/utils/api_response.dart';
import 'package:bridges_of_glory/utils/custom_http.dart';

import '../../model/project_detail_model.dart';

class ProjectService {

  /// ------------------------------------------- project ---------------------------------------- ///
  Future<ApiResponse<List<ProjectModel>>> fetchProject(
    int id,
  ) async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'projects/list?program_id=$id',
        showFloatingError: false,
        needAuth: true,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final List<dynamic> jsonData = response.data;

        final List<ProjectModel> kingdomProjectList = jsonData
            .map((e) => ProjectModel.fromJson(e))
            .toList();

        return ApiResponse.success(kingdomProjectList);
      } else {
        final decoded = jsonDecode(response.error ?? 'something went wrong');
        String emailError = decoded['message'] ?? 'Unknown error';

        return ApiResponse.error(emailError);
      }
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(
        'Something went wrong..404. when fetching kingdom of project',
      );
    }
  }

  /// ------------------------------------------- project detail ---------------------------------------- ///
  Future<ApiResponse<ProjectDetailsModel>> fetchProjectDetail(
      int id,
      ) async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'projects/details/$id',
        showFloatingError: false,
        needAuth: true,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final dynamic jsonData = response.data;

        final ProjectDetailsModel kingdomProjectList =  ProjectDetailsModel.fromJson(jsonData);

        return ApiResponse.success(kingdomProjectList);
      } else {
        final decoded = jsonDecode(response.error ?? 'something went wrong');
        String emailError = decoded['message'] ?? 'Unknown error';

        return ApiResponse.error(emailError);
      }
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(
        'Something went wrong..404. when fetching kingdom of project',
      );
    }
  }
}


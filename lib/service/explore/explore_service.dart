import 'dart:convert';

import 'package:bridges_of_glory/model/explore_details_model.dart';
import 'package:bridges_of_glory/model/explore_model.dart';
import 'package:bridges_of_glory/utils/api_response.dart';
import 'package:bridges_of_glory/utils/custom_http.dart';

class ExploreService {
  Future<ApiResponse<List<ExploreModel>>> getExplore() async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'projects/explore',
        needAuth: true,
        showFloatingError: false,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final List<dynamic> jsonData = response.data;
        final List<ExploreModel> exploreMenu = jsonData
            .map((e) => ExploreModel.fromJson(e))
            .toList();

        return ApiResponse.success(exploreMenu);
      } else {
        final decoded = jsonDecode(response.error ?? 'something went wrong');
        String emailError = decoded['message'] ?? 'Unknown error';

        return ApiResponse.error(emailError);
      }
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(
        'Something went wrong..404. Getting explore menu',
      );
    }
  }

  Future<ApiResponse<ExploreDetailsModel>> getExploreDetails(int id) async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'projects/explore-details/$id',
        needAuth: true,
        showFloatingError: false,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final dynamic jsonData = response.data;
        final ExploreDetailsModel exploreMenu = ExploreDetailsModel.fromJson(
          jsonData,
        );

        return ApiResponse.success(exploreMenu);
      } else {
        final decoded = jsonDecode(response.error ?? 'something went wrong');
        String emailError = decoded['message'] ?? 'Unknown error';

        return ApiResponse.error(emailError);
      }
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(
        'Something went wrong..404. When Getting explore menu',
      );
    }
  }
}

import 'dart:convert';
import '../../utils/custom_http.dart';

class ProjectViewCountService {
  Future<void> postView(int projectId) async {
    try {
      final response = await CustomHttp.get(
        endpoint: 'projects/views-count/$projectId',
        needAuth: true,
        showFloatingError: false,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
      } else {
        final json = jsonDecode(response.error!);
        final errorMessage = json['message'];
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

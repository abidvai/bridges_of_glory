import 'package:bridges_of_glory/core/common_widgets/custom_toast.dart';
import 'package:bridges_of_glory/model/explore_details_model.dart';
import 'package:bridges_of_glory/model/explore_model.dart';
import 'package:bridges_of_glory/service/explore/explore_service.dart';
import 'package:get/get.dart';
import '../../../../model/project_model.dart';
import '../../../../service/project_service/project_service.dart';

class ExploreController extends GetxController {
  final ExploreService _exploreService = ExploreService();
  final RxList<ExploreModel> exploreMenu = <ExploreModel>[].obs;
  final Rxn<ExploreDetailsModel> exploreDetail = Rxn(null);
  RxBool isLoading = RxBool(false);


  Future<void> getExploreMenu() async {
    isLoading.value = true;
    final response = await _exploreService.getExplore();

    if (response.data != null) {
      isLoading.value = false;
      exploreMenu.assignAll(response.data!);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'error fetching data');
    }
  }

  Future<void> getExploreDetails(int id) async {
    isLoading.value = true;
    final response = await _exploreService.getExploreDetails(id);

    if (response.data != null) {
      isLoading.value = false;
      exploreDetail.value = response.data!;
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'error fetching data');
    }
  }


  @override
  void onInit() {
    super.onInit();
    getExploreMenu();
  }
}

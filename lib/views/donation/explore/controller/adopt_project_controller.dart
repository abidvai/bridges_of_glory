import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../../../model/project_model.dart';
import '../../../../model/showing_card_model.dart';
import '../../../../service/project_service/project_service.dart';

class AdoptProjectController extends GetxController {
  final int id;

  AdoptProjectController({required this.id});

  RxList<ProjectModel> villageProjectList = <ProjectModel>[].obs;
  final ProjectService _projectService = ProjectService();

  List<String> menuList = ['All', 'Chicken', 'Cow', 'Goat', 'pig', 'Business'];

  RxString selected = RxString('All');
  TextEditingController searchController = TextEditingController();
  RxBool isLoading = RxBool(false);

  final items = <ShowingCardModel>[
    ShowingCardModel(
      image: 'Assets.images.chickenFarm',
      title: 'Kirembe Perk View',
      location: 'Tanzania',
      familyCount: 24,
      buttonTitle: 'Chicken Project',
    ),
    ShowingCardModel(
      image: 'Assets.images.chickenFarm',
      title: 'Buthungi Village',
      location: 'Kenya',
      familyCount: 24,
      buttonTitle: 'Cow Farm',
    ),
    ShowingCardModel(
      image: 'Assets.images.chickenFarm',
      title: 'Mihunga Village',
      location: 'Zambia',
      familyCount: 24,
      buttonTitle: 'Goat Farm',
    ),
    ShowingCardModel(
      image: 'Assets.images.chickenFarm',
      title: 'Kihasa Village',
      location: 'Tanzania',
      familyCount: 24,
      buttonTitle: 'Pig Herd',
    ),
    ShowingCardModel(
      image: 'Assets.images.chickenFarm',
      title: 'Kasama Town',
      location: 'Tanzania',
      familyCount: 24,
      buttonTitle: 'Goat Farm',
    ),
  ];

  Future<void> fetchVillageProject(int id) async {
    isLoading.value = true;
    final response = await _projectService.fetchProject(id);

    if (response.data != null) {
      isLoading.value = false;
      villageProjectList.assignAll(response.data!);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404.');
    }
  }

  @override
  void onInit() {
    fetchVillageProject(id);
    super.onInit();
  }
}

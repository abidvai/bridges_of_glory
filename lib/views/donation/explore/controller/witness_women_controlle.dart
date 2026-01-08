import 'package:bridges_of_glory/model/project_detail_model.dart';
import 'package:get/get.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../../../model/project_model.dart';
import '../../../../model/showing_card_model.dart';
import '../../../../service/project_service/project_service.dart';

class WitnessWomenController extends GetxController {
  final int id;

  WitnessWomenController({required this.id});


  List<String> menuList = ['All', 'Chicken', 'Cow', 'Goat', 'pig', 'Business'];
  RxBool isLoading = RxBool(false);
  final ProjectService _projectService = ProjectService();
  RxList<ProjectModel> witnessProjectList = <ProjectModel>[].obs;
  Rxn<ProjectDetailsModel> witnessProjectDetailsList = Rxn(null);



  RxString selected = RxString('All');

  final items = <ShowingCardModel>[
    ShowingCardModel(
      image: 'Assets.images.chickenFarm',
      title: 'Mwati Village',
      location: 'Tanzania',
      familyCount: 24,
      buttonTitle: 'Chicken Project',
    ),
    ShowingCardModel(
      image: 'Assets.images.chickenFarm',
      title: 'Kitui Hills',
      location: 'Kenya',
      familyCount: 24,
      buttonTitle: 'Cow Farm',
    ),
    ShowingCardModel(
      image: 'Assets.images.chickenFarm',
      title: 'Kasama Town',
      location: 'Zambia',
      familyCount: 24,
      buttonTitle: 'Goat Farm',
    ),
    ShowingCardModel(
      image: 'Assets.images.chickenFarm',
      title: 'Kasama Town',
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

  Future<void> fetchWitnessProject(int id) async {
    isLoading.value = true;
    final response = await _projectService.fetchProject(id);

    if (response.data != null) {
      isLoading.value = false;
      witnessProjectList.assignAll(response.data!);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404.');
    }
  }


  // Fetch details for a single project
  Future<void> fetchProjectDetails(int projectId) async {
    isLoading.value = true;
    final response = await _projectService.fetchProjectDetail(projectId);

    if (response.data != null) {
      witnessProjectDetailsList.value = response.data!;
    } else {
      showCustomToast(text: response.error ?? 'Failed to load project details');
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    fetchWitnessProject(id);
    super.onInit();
  }

}
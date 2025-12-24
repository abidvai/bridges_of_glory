import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' hide LatLng;

class CreateController extends GetxController {
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  RxString selectedLocationText = ''.obs;
  Rx<LatLng?> selectedLatLng = Rx<LatLng?>(null);

  var selectedImage = Rxn<AssetEntity>(null);

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> pickImage(BuildContext context) async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
      ),
    );
    if (result != null && result.isNotEmpty) {
      selectedImage.value = result.first;
      update();
    }
  }

  TextEditingController category = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController pastor = TextEditingController();
  TextEditingController sponsorName = TextEditingController();
  TextEditingController establish = TextEditingController();
  TextEditingController chickens = TextEditingController();
  TextEditingController stories = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    category.clear();
    title.clear();
    pastor.clear();
    sponsorName.clear();
    establish.clear();
    chickens.clear();
    stories.clear();
    pastor.clear();
    description.clear();
    selectedLocationText.value = '';
  }
}

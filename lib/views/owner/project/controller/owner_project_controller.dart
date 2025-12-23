import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../model/showing_card_model.dart';

class OwnerProjectController extends GetxController {

  TextEditingController searchController = TextEditingController();

  List<String> menuList = ['All', 'Chicken', 'Cow', 'Goat', 'pig', 'Business'];
  RxInt pastorSupport = RxInt(100);
  RxInt liveStockSupport = RxInt(100);
  RxInt churchSupport = RxInt(100);
  RxString selected = RxString('All');

  final items = <ShowingCardModel>[
    ShowingCardModel(
      image: Assets.images.chickenFarm,
      title: 'Mwati Village',
      location: 'Tanzania',
      familyCount: 24,
      buttonTitle: 'Chicken Project',
    ),
    ShowingCardModel(
      image: Assets.images.cowFarm,
      title: 'Kitui Hills',
      location: 'Kenya',
      familyCount: 24,
      buttonTitle: 'Cow Farm',
    ),
    ShowingCardModel(
      image: Assets.images.goatFarm,
      title: 'Kasama Town',
      location: 'Zambia',
      familyCount: 24,
      buttonTitle: 'Goat Farm',
    ),
    ShowingCardModel(
      image: Assets.images.pigFarm,
      title: 'Kasama Town',
      location: 'Tanzania',
      familyCount: 24,
      buttonTitle: 'Pig Herd',
    ),
    ShowingCardModel(
      image: Assets.images.cooking,
      title: 'Kasama Town',
      location: 'Tanzania',
      familyCount: 24,
      buttonTitle: 'Goat Farm',
    ),
  ];
}

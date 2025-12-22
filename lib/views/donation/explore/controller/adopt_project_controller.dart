import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../model/showing_card_model.dart';

class AdoptProjectController extends GetxController {
  List<String> menuList = ['All', 'Chicken', 'Cow', 'Goat', 'pig', 'Business'];

  RxString selected = RxString('All');
  TextEditingController searchController = TextEditingController();

  final items = <ShowingCardModel>[
    ShowingCardModel(
      image: Assets.images.project,
      title: 'Kirembe Perk View',
      location: 'Tanzania',
      familyCount: 24,
      buttonTitle: 'Chicken Project',
    ),
    ShowingCardModel(
      image: Assets.images.project,
      title: 'Buthungi Village',
      location: 'Kenya',
      familyCount: 24,
      buttonTitle: 'Cow Farm',
    ),
    ShowingCardModel(
      image: Assets.images.project,
      title: 'Mihunga Village',
      location: 'Zambia',
      familyCount: 24,
      buttonTitle: 'Goat Farm',
    ),
    ShowingCardModel(
      image: Assets.images.project,
      title: 'Kihasa Village',
      location: 'Tanzania',
      familyCount: 24,
      buttonTitle: 'Pig Herd',
    ),
    ShowingCardModel(
      image: Assets.images.project,
      title: 'Kasama Town',
      location: 'Tanzania',
      familyCount: 24,
      buttonTitle: 'Goat Farm',
    ),
  ];
}

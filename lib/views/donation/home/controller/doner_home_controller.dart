import 'package:bridges_of_glory/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../model/CategoryModel.dart';
import '../../../../model/showing_card_model.dart';

class DonerHomeController extends GetxController {

  TextEditingController searchController = TextEditingController();
  
  final categoryList = [
    CategoryModel(Assets.images.chicken, 'Chicken'),
    CategoryModel(Assets.images.cow, 'Cow'),
    CategoryModel(Assets.images.goat, 'Goat'),
    CategoryModel(Assets.images.pig, 'pig'),
    CategoryModel(Assets.images.chicken, 'Chicken'),
    CategoryModel(Assets.images.leader, 'Business'),
  ];

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
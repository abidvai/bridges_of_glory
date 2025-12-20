
import '../gen/assets.gen.dart';

class ShowingCardModel {
  final String title;
  final String location;
  final int familyCount;
  final String buttonTitle;
  final AssetGenImage image;

  ShowingCardModel({
    required this.title,
    required this.location,
    required this.familyCount,
    required this.buttonTitle,
    required this.image,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';

class ExploreMenu extends StatelessWidget {
  final AssetGenImage image;
  final VoidCallback onTap;

  const ExploreMenu({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(width: 100.w, height: 99.h, child: image.image()),
    );
  }
}

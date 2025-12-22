import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(text: 'Kirembe Perk View'),
      body: Column(
        children: [
          Container(
            width: 335.w,
            height: 331.h,
            color: AppColors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Assets.images.park.image(
                  height: 164.h,
                  width: 335.w,
                  fit: BoxFit.cover,
                ),
                Text('Chicken Project by WWW'),
                Text('Location: Lower Kasese, Kasese District Uganda'),
                Text('Pastor: Alvin'),
                Text('Sponsor: Eric Lumika'),
                Text('Established: 8/11/24'),
                Text('Chickens: 30'),
                // Container(width: 335.w, height: 170.h, color: AppColors.red),
              ],
            ),
          ),
          // Stack(children: [Assets.images.park.image()]),
        ],
      ),
    );
  }
}

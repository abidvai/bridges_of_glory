import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';
import '../../views/donation/explore/adopt_detail_screen.dart';
import 'detail_info_text.dart';

class DetailTopCard extends StatelessWidget {
  final AssetGenImage image;
  final String title;
  final String location;
  final String pastor;
  final String sponsor;
  final String establish;
  final String chicken;

  const DetailTopCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.pastor,
    required this.sponsor,
    required this.chicken,
    required this.establish,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195.h + 180.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: image.image(height: 164.h, width: 335.w, fit: BoxFit.cover),
          ),


          Positioned(
            top: 140,
            right: 0,
            left: 0,
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: 335.w,
                height: 240.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    width: 0.5,
                    color: AppColors.border.withValues(alpha: 0.4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 2.h),
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(height: 8.h),
                    DetailInfoText(title: 'Location', value: location),
                    SizedBox(height: 8.h),
                    DetailInfoText(title: 'Pastor', value: pastor),
                    SizedBox(height: 8.h),
                    DetailInfoText(title: 'Sponsor', value: sponsor),
                    SizedBox(height: 8.h),
                    DetailInfoText(title: 'Established', value: establish),
                    SizedBox(height: 8.h),
                    DetailInfoText(title: 'Chickens', value: chicken),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

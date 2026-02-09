import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../gen/assets.gen.dart';
import '../../utils/constant/color.dart';

class ShowingCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final int familyCount;
  final String buttonTitle;
  final VoidCallback onTap;

  const ShowingCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.familyCount,
    required this.buttonTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          // width: 336.w,
          // height: 148.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.surface,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: image,
                        width: 104.w,
                        // height: 110.h,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(image),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 8.w),
                        Text(
                          location,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.groups),
                        SizedBox(width: 8.w),
                        Text(
                          '$familyCount families',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ), // smaller padding
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ), // more rounded like a tag
                        color: AppColors.red.withOpacity(0.2),
                      ),
                      child: Text(
                        '$buttonTitle Farm',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

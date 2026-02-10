import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'detail_info_text.dart';

class DetailTopCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String pastor;
  final String sponsor;
  final DateTime establish;
  final String category;

  const DetailTopCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.pastor,
    required this.sponsor,
    required this.category,
    required this.establish,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image Section
        Container(
          width: double.infinity,
          height: 200.h,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
            child: CachedNetworkImage(
              imageUrl: image,
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey[400],
                  size: 40.w,
                ),
              ),
            ),
          ),
        ),

        // Details Card (attached below image)
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 20.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
            ),
            border: Border.all(
              width: 0.5,
              color: AppColors.border.withOpacity(0.4),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: _buildCardContent(),
        ),
      ],
    );
  }

  Widget _buildCardContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: isTablet ? 20.sp : 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: isTablet ? 20.h : 16.h),

            // Content Grid
            if (isTablet)
              _buildTabletLayout()
            else
              _buildMobileLayout(),
          ],
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailInfoText(title: 'Location', value: location),
        SizedBox(height: 12.h),
        DetailInfoText(title: 'Pastor', value: pastor),
        SizedBox(height: 12.h),
        DetailInfoText(title: 'Sponsor', value: sponsor),
        SizedBox(height: 12.h),
        DetailInfoText(
            title: 'Established',
            value: '${establish.year}'
        ),
        SizedBox(height: 12.h),
        DetailInfoText(title: 'Category', value: category),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        // First Row
        Row(
          children: [
            Expanded(
              child: DetailInfoText(title: 'Location', value: location),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: DetailInfoText(title: 'Pastor', value: pastor),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Second Row
        Row(
          children: [
            Expanded(
              child: DetailInfoText(title: 'Sponsor', value: sponsor),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: DetailInfoText(
                  title: 'Established',
                  value: '${establish.year}'
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Third Row
        DetailInfoText(title: 'Category', value: category),
      ],
    );
  }
}
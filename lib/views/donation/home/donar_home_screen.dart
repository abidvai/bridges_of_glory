import 'package:bridges_of_glory/core/common_widgets/custom_text_field.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/donation/home/controller/doner_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/common_widgets/category_card.dart';
import '../../../core/common_widgets/showing_card.dart';
import '../../../core/common_widgets/title_row.dart';
import '../../../gen/assets.gen.dart';

class DonerHomeScreen extends StatelessWidget {
  DonerHomeScreen({super.key});

  final DonerHomeController donerHomeController = Get.put(
    DonerHomeController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location', style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 7.h),
                Row(
                  children: [
                    Icon(Iconsax.location, size: 24.w),
                    SizedBox(width: 3.w),
                    Text(
                      'New York, USA',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                CustomTextField(
                  controller: donerHomeController.searchController,
                  prefixIcon: Icon(Iconsax.search_normal_14),
                  hintText: 'Search',
                  filled: true,
                  filColor: AppColors.border.withValues(alpha: 0.1),
                ),
                SizedBox(height: 32.h),

                Container(
                  width: 335.w,
                  height: 119.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.red.withValues(alpha: 0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.appLogo2.image(),
                          SizedBox(height: 8.h),
                          Text(
                            '#BecomeTheMovement',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      SizedBox(width: 14.w),
                      Assets.images.jar.image(
                        width: 116.w,
                        height: 82.h,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),
                TitleRow(title: 'Categories'),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 100.h,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: donerHomeController.categoryList.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 16.w);
                    },
                    itemBuilder: (context, index) {
                      final category = donerHomeController.categoryList[index];
                      return CategoryCard(
                        image: category.image,
                        title: category.title,
                        onTap: () {},
                      );
                    },
                  ),
                ),
                TitleRow(
                  title: 'Empowerment',
                  isSeeAll: true,
                  onTap: () {
                    Get.toNamed(AppRoutes.empowerment, arguments: {'id': 2});
                  },
                ),

                Obx(() {
                  if (donerHomeController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: donerHomeController.empowermentList.length
                          .clamp(0, 5),
                      itemBuilder: (context, index) {
                        final item = donerHomeController.empowermentList[index];

                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: ShowingCard(
                            image: item.coverImage ?? 'http://10.10.12.62:8000/media/projects/covers/Screenshot_2025-08-14_111157_CPWUbyT.png',
                            title: item.title ?? 'title',
                            location: item.location ?? 'location',
                            //TODO: count
                            familyCount: 24,
                            buttonTitle: item.category?.name ?? 'category',
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.empowermentDetailScreen,
                                arguments: {'title': item.title},
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

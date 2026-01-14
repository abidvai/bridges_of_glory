import 'package:bridges_of_glory/core/common_widgets/custom_text_field.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/donation/explore/controller/empowerment_controller.dart';
import 'package:bridges_of_glory/views/donation/explore/empowerment_detail_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/empowerment_screen.dart';
import 'package:bridges_of_glory/views/donation/home/category_wise_project_screen.dart';
import 'package:bridges_of_glory/views/donation/home/controller/doner_home_controller.dart';
import 'package:bridges_of_glory/views/donation/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/common_widgets/category_card.dart';
import '../../../core/common_widgets/showing_card.dart';
import '../../../core/common_widgets/title_row.dart';
import '../../../gen/assets.gen.dart';

class DonerHomeScreen extends StatelessWidget {
  DonerHomeScreen({super.key});

  final DonerHomeController donerHomeController = Get.put(
    DonerHomeController(),
  );
  final EmpowermentController empowermentController = Get.put(
    EmpowermentController(id: 2),
  );
  final DonerProfileController _donerProfileController = Get.put(
    DonerProfileController(),
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
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Obx(() {
                      return CircleAvatar(
                        radius: 20,
                        // optional size
                        backgroundImage:
                            _donerProfileController
                                    .profileInfo
                                    .value
                                    ?.data
                                    ?.avatar !=
                                null
                            ? NetworkImage(
                                _donerProfileController
                                    .profileInfo
                                    .value!
                                    .data!
                                    .avatar!,
                              )
                            : null,
                        backgroundColor: Colors.grey[300],
                        child:
                            _donerProfileController
                                    .profileInfo
                                    .value
                                    ?.data
                                    ?.avatar ==
                                null
                            ? Icon(Icons.person, size: 30)
                            : null,
                      );
                    }),
                    SizedBox(width: 10.w),
                    Text(
                      'Hi! ${_donerProfileController.profileInfo.value?.data?.fullName ?? 'userName'}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22.h),
                CustomTextField(
                  controller: donerHomeController.searchController,
                  prefixIcon: Icon(Iconsax.search_normal_14),
                  hintText: 'Search',
                  filled: true,
                  filColor: AppColors.border.withValues(alpha: 0.1),
                  onChanged: (value) {
                    donerHomeController.searchText.value = value;
                    donerHomeController.search(searchText: value);
                  },
                ),
                SizedBox(height: 26.h),

                Obx(() {
                  if (donerHomeController.searchText.value.isEmpty) {
                    return _homeWidget(context);
                  } else if (donerHomeController.searchProjectList.isEmpty) {
                    return Center(child: Text('No search result found'));
                  }
                  return Skeletonizer(
                    enabled: donerHomeController.isLoading.value,
                    child: SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: donerHomeController.searchProjectList.length,
                        itemBuilder: (context, index) {
                          final item =
                              donerHomeController.searchProjectList[index];

                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h, left: 20.w),
                            child: ShowingCard(
                              image:
                                  item.coverImage ??
                                  'http://10.10.12.62:8000/media/projects/covers/Screenshot_2025-08-14_111157_CPWUbyT.png',
                              title: item.title ?? 'title',
                              location: item.location ?? 'location',
                              familyCount: item.totalBenefitedFamilies ?? 0,
                              buttonTitle: item.category?.name ?? 'category',
                              onTap: () async {
                                await empowermentController.fetchProjectDetails(
                                  item.id ?? 0,
                                );

                                // Navigate to detail screen with fetched details
                                if (empowermentController
                                        .empowermentDetail
                                        .value !=
                                    null) {
                                  Get.to(
                                    () => EmpowermentDetailScreen(
                                      details: empowermentController
                                          .empowermentDetail
                                          .value!,
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
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

  Widget _homeWidget(BuildContext context) {
    return Column(
      children: [
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
        Obx(() {
          if (empowermentController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.red),
            );
          }
          return SizedBox(
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
                  image:
                      category.image ??
                      'http://10.10.12.62:8000/media/categories/business.png',
                  title: category.name ?? 'category',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CategoryWiseProjectScreen(categoryModel: category),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }),
        TitleRow(
          title: 'Empowerment',
          isSeeAll: true,
          onTap: () {
            Get.to(EmpowermentScreen(id: 2));
          },
        ),

        Obx(() {
          if (empowermentController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.red),
            );
          }
          return SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: donerHomeController.empowermentList.length.clamp(0, 5),
              itemBuilder: (context, index) {
                final item = donerHomeController.empowermentList[index];

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: ShowingCard(
                    image:
                        item.coverImage ??
                        'http://10.10.12.62:8000/media/projects/covers/Screenshot_2025-08-14_111157_CPWUbyT.png',
                    title: item.title ?? 'title',
                    location: item.location ?? 'location',
                    familyCount: item.totalBenefitedFamilies ?? 0,
                    buttonTitle: item.category?.name ?? 'category',
                    onTap: () async {
                      await empowermentController.fetchProjectDetails(
                        item.id ?? 0,
                      );

                      // Navigate to detail screen with fetched details
                      if (empowermentController.empowermentDetail.value !=
                          null) {
                        Get.to(
                          () => EmpowermentDetailScreen(
                            details:
                                empowermentController.empowermentDetail.value!,
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

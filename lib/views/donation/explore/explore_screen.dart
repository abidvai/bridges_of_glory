import 'package:bridges_of_glory/core/common_widgets/app_back_button.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/donation/explore/controller/explore_controller.dart';
import 'package:bridges_of_glory/views/donation/library/library_screen.dart';
import 'package:bridges_of_glory/views/info_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../gen/assets.gen.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final ExploreController exploreController = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: AppBar(
        title: Text('Explore'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.surfaceBg,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    width: 335.w,
                    height: 550.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 32.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.surface,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select what you\'d like to explore!',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'Pick what interests you.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 30.h),
                        Obx(() {
                          if (exploreController.isLoading.value) {
                            return SizedBox(
                              height: 400.h,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8.h,
                                      crossAxisSpacing: 16.w,
                                      childAspectRatio: 1.06,
                                    ),
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Skeletonizer(
                                    enabled: true,
                                    child: Container(
                                      width: 100.w,
                                      height: 99.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 400.h,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8.h,
                                      crossAxisSpacing: 16.w,
                                      childAspectRatio: 1.06,
                                    ),
                                itemCount: exploreController.exploreMenu.length,
                                itemBuilder: (context, index) {
                                  final exploreMenu =
                                      exploreController.exploreMenu[index];
                                  return ExploreMenu(
                                    image: exploreMenu.image ?? '',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              InfoScreen(id: exploreMenu.id!),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreMenu extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const ExploreMenu({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100.w,
        height: 99.h,
        child: CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, url) =>
              Image.asset('assets/images/become_movement.png'),
        ),
      ),
    );
  }
}

class AppTopBar extends StatelessWidget {
  final String text;

  const AppTopBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Center(
        child: Text(text, style: Theme.of(context).textTheme.titleLarge),
      ),
      // Row(
      //   children: [
      //     AppBackButton(),
      //     Spacer(),
      //     Center(
      //       child: Text(text, style: Theme.of(context).textTheme.titleLarge),
      //     ),
      //     Spacer(),
      //     Opacity(opacity: 0, child: AppBackButton()),
      //   ],
      // ),
    );
  }
}

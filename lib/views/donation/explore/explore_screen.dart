import 'package:bridges_of_glory/core/common_widgets/app_back_button.dart';
import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../gen/assets.gen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(text: 'Explore'),
            SizedBox(height: 20.h),
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                width: 335.w,
                height: 480.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
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
                    SizedBox(height: 20.h),
                    Center(
                      child: Wrap(
                        spacing: 39.w,
                        runSpacing: 18.h,
                        alignment: WrapAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          ExploreMenu(
                            image: Assets.images.becomeMovement,
                            onTap: () {
                              Get.to(InfoScreen(onTap: (){
                                Get.toNamed(AppRoutes.empowerment);
                              }),
                                arguments: {
                                  'information':
                                      'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                  'description':
                                      'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                },
                              );
                            },
                          ),
                          ExploreMenu(
                            image: Assets.images.kingdomEmpowerment,
                            onTap: () {},
                          ),
                          ExploreMenu(
                            image: Assets.images.walkingWitnessWomen,
                            onTap: () {},
                          ),
                          ExploreMenu(
                            image: Assets.images.adoptaVillage,
                            onTap: () {},
                          ),
                          ExploreMenu(
                            image: Assets.images.bibleBook,
                            onTap: () {},
                          ),
                          ExploreMenu(
                            image: Assets.images.livingKingdom,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class AppTopBar extends StatelessWidget {
  final String text;

  const AppTopBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          AppBackButton(),
          Spacer(),
          Center(
            child: Text(text, style: Theme.of(context).textTheme.titleLarge),
          ),
          Spacer(),
          Opacity(opacity: 0, child: AppBackButton()),
        ],
      ),
    );
  }
}

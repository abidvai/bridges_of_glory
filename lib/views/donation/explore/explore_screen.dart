import 'package:bridges_of_glory/core/common_widgets/app_back_button.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/donation/library/library_screen.dart';
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
            padding: EdgeInsets.symmetric(vertical: 50.h),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // AppTopBar(text: 'Explore'),
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    width: 335.w,
                    height: 500.h,
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
                                  Get.to(
                                    InfoScreen(
                                      isMovement: true,
                                      onTap: () {
                                        Get.back();
                                        // Get.to(LibraryScreen(showAppBar: true));
                                      },
                                      url:
                                          'https://www.youtube.com/watch?v=HH-Hgc3O1Ec',
                                      title: 'Become The Movement',
                                      information:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                      description:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                    ),
                                  );
                                },
                              ),
                              ExploreMenu(
                                image: Assets.images.kingdomEmpowerment,
                                onTap: () {
                                  Get.to(
                                    InfoScreen(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.empowerment);
                                      },
                                      url:
                                          'https://www.youtube.com/watch?v=R_TwTnWvGkI',
                                      title: 'Kingdom Empowerment',
                                      information:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                      description:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                    ),
                                  );
                                },
                              ),
                              ExploreMenu(
                                image: Assets.images.walkingWitnessWomen,
                                onTap: () {
                                  Get.to(
                                    InfoScreen(
                                      onTap: () {
                                        Get.toNamed(
                                          AppRoutes.witnessWomenScreen,
                                        );
                                      },
                                      url:
                                          'https://www.youtube.com/watch?v=dGiW5_m4Ihc',
                                      title: 'Walking Witness Women',
                                      information:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                      description:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                    ),
                                  );
                                },
                              ),
                              ExploreMenu(
                                image: Assets.images.adoptaVillage,
                                onTap: () {
                                  Get.to(
                                    InfoScreen(
                                      onTap: () {
                                        Get.toNamed(
                                          AppRoutes.adoptProjectScreen,
                                        );
                                      },
                                      url:
                                          'https://www.youtube.com/watch?v=Rhw7kqPibKs',
                                      title: 'Adopt a Village / Prison',
                                      information:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                      description:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                    ),
                                  );
                                },
                              ),
                              ExploreMenu(
                                image: Assets.images.bibleBook,
                                onTap: () {
                                  Get.to(
                                    InfoScreen(
                                      onTap: () {
                                        Get.to(LibraryScreen(showAppBar: true));
                                      },
                                      title: 'Bible Books and More',
                                      information:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                      description:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                    ),
                                  );
                                },
                              ),
                              ExploreMenu(
                                image: Assets.images.livingKingdom,
                                onTap: () {
                                  Get.to(
                                    InfoScreen(
                                      onTap: () {
                                        Get.back();
                                      },
                                      url:
                                          'https://www.youtube.com/watch?v=EAFTFkfSa-4',
                                      title: 'Living in The Kingdom',
                                      information:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                      description:
                                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                                    ),
                                  );
                                },
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

import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../gen/assets.gen.dart';

class LibraryScreen extends StatelessWidget {
  final bool? showAppBar;

  const LibraryScreen({super.key, this.showAppBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (showAppBar ?? false)
          ? AppTopBar(text: 'Library')
          : AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.surface,
              title: Text(
                'Library',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
      backgroundColor: AppColors.surfaceBg,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(
              child: GridView(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 16.h,
                  mainAxisExtent: 258.h,
                  // childAspectRatio: 0.7,
                ),
                children: [
                  LibraryCard(
                    image: Assets.images.bible,
                    title: 'Bible',
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.viewBookScreen,
                        arguments: Assets.images.bible,
                      );
                    },
                  ),
                  LibraryCard(
                    image: Assets.images.milkyBook,
                    title: 'Bible',
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.viewBookScreen,
                        arguments: Assets.images.milkyBook,
                      );
                    },
                  ),
                  LibraryCard(
                    image: Assets.images.bible,
                    title: 'Bible',
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.viewBookScreen,
                        arguments: Assets.images.bible,
                      );
                    },
                  ),
                  LibraryCard(
                    image: Assets.images.milkyBook,
                    title: 'Bible',
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.viewBookScreen,
                        arguments: Assets.images.milkyBook,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryCard extends StatelessWidget {
  final AssetGenImage image;
  final String title;
  final VoidCallback onTap;

  const LibraryCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(12.r),
        elevation: 1,
        child: Container(
          width: 150.w,
          height: 258.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.surface,
          ),
          child: Column(
            children: [
              image.image(width: 134.w, height: 210.h, fit: BoxFit.cover),
              SizedBox(height: 8.h),
              Text(title, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}

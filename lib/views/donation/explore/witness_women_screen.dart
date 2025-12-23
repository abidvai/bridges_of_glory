import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/donation/explore/controller/witness_women_controlle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/common_widgets/app_top_bar.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../core/common_widgets/showing_card.dart';
import '../bottom_nav_donation.dart';

class WitnessWomenScreen extends StatelessWidget {
  WitnessWomenScreen({super.key});

  final WitnessWomenController witnessWomenController = Get.put(
    WitnessWomenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            AppTopBar(text: 'Walking Witness Women'),
            SizedBox(height: 16.h),
            SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(() {
                  return Row(
                    children: [
                      ...witnessWomenController.menuList.map((item) {
                        final isSelected =
                            item == witnessWomenController.selected.value;

                        return GestureDetector(
                          onTap: () {
                            witnessWomenController.selected.value = item;
                          },
                          child: Container(
                            height: 40.h,
                            margin: EdgeInsets.only(right: 8.w),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: isSelected
                                  ? AppColors.red.withValues(alpha: 0.1)
                                  : AppColors.border.withValues(alpha: 0.2),
                            ),
                            child: Center(
                              child: Text(
                                item,
                                style: isSelected
                                    ? TextStyle(color: AppColors.red)
                                    : Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }),
              ),
            ),

            SizedBox(height: 22.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: witnessWomenController.items.length,
                itemBuilder: (context, index) {
                  final item = witnessWomenController.items[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: ShowingCard(
                      image: item.image,
                      title: item.title,
                      location: item.location,
                      familyCount: item.familyCount,
                      buttonTitle: item.buttonTitle,
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.witnessWomenDetailScreen,
                          arguments: {'title': item.title},
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

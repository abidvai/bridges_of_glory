import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/donation/explore/controller/witness_women_controlle.dart';
import 'package:bridges_of_glory/views/donation/explore/witness_women_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/common_widgets/app_top_bar.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../core/common_widgets/showing_card.dart';
import '../bottom_nav_donation.dart';

class WitnessWomenScreen extends StatefulWidget {
  final int id;

  const WitnessWomenScreen({super.key, required this.id});

  @override
  State<WitnessWomenScreen> createState() => _WitnessWomenScreenState();
}

class _WitnessWomenScreenState extends State<WitnessWomenScreen> {
  late WitnessWomenController witnessWomenController;

  @override
  void initState() {
    super.initState();
    witnessWomenController = Get.put(WitnessWomenController(id: widget.id));
  }

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
                  if (witnessWomenController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Row(
                    children: [
                      ...witnessWomenController.categoryList.map((item) {
                        final isSelected =
                            item.name == witnessWomenController.selected.value;

                        return GestureDetector(
                          onTap: () {
                            witnessWomenController.selected.value =
                                item.name ?? 'All';
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
                                item.name ?? '',
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

            Obx(() {
              if (witnessWomenController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount:
                  witnessWomenController.filteredWitnessProjectList.length,
                  itemBuilder: (context, index) {
                    final item = witnessWomenController
                        .filteredWitnessProjectList[index];

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
                          await witnessWomenController.fetchProjectDetails(
                            item.id ?? 0,
                          );

                          // Navigate to detail screen with fetched details
                          if (witnessWomenController
                              .witnessProjectDetailsList
                              .value !=
                              null) {
                            Get.to(
                                  () => WitnessWomenDetailScreen(
                                details: witnessWomenController
                                    .witnessProjectDetailsList
                                    .value!,
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
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

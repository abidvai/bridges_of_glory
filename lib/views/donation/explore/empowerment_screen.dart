import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/donation/bottom_nav_donation.dart';
import 'package:bridges_of_glory/views/donation/explore/controller/empowerment_controller.dart';
import 'package:bridges_of_glory/views/donation/explore/empowerment_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/common_widgets/custom_text_field.dart';
import '../../../core/common_widgets/showing_card.dart';

class EmpowermentScreen extends StatefulWidget {
  final int id;

  const EmpowermentScreen({super.key, required this.id});

  @override
  State<EmpowermentScreen> createState() => _EmpowermentScreenState();
}

class _EmpowermentScreenState extends State<EmpowermentScreen> {
  late EmpowermentController empowermentController;

  @override
  void initState() {
    super.initState();
    empowermentController = Get.put(EmpowermentController(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            AppTopBar(text: 'Empowerment'),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextField(
                controller: empowermentController.searchController,
                prefixIcon: Icon(Iconsax.search_normal_14),
                hintText: 'Search',
                filled: true,
                filColor: AppColors.border.withValues(alpha: 0.1),
              ),
            ),
            SizedBox(height: 24.h),
            SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(() {
                  if (empowermentController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Row(
                    children: [
                      ...empowermentController.categoryList.map((item) {
                        final isSelected =
                            item.name == empowermentController.selected.value;

                        return GestureDetector(
                          onTap: () {
                            empowermentController.selected.value =
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
                                item.name ?? 'category',
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
              if (empowermentController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (empowermentController.filterEmpowermentList.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 120.h),
                    child: Text(
                      'No result found in ${empowermentController.selected} category',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.hintText,
                      ),
                    ),
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: empowermentController.filterEmpowermentList.length,
                  itemBuilder: (context, index) {
                    final item =
                        empowermentController.filterEmpowermentList[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: ShowingCard(
                        image: item.coverImage ?? 'assets/images/cooking.png',
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
              );
            }),
            SizedBox(height: 50.h),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
        child: PrimaryButton(
          text: 'Home',
          onTap: () {
            Get.to(BottomNavDonation(index: 0));
          },
        ),
      ),
    );
  }
}

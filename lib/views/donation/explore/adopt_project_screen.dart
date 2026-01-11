import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/donation/explore/adopt_detail_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/controller/adopt_project_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/common_widgets/app_top_bar.dart';
import '../../../core/common_widgets/custom_text_field.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../core/common_widgets/showing_card.dart';
import '../../../utils/constant/color.dart';
import '../bottom_nav_donation.dart';

class AdoptProjectScreen extends StatefulWidget {
  final bool? showAppBar;
  final bool? showBottomButton;
  final int id;

  const AdoptProjectScreen({
    super.key,
    this.showAppBar,
    this.showBottomButton,
    required this.id,
  });

  @override
  State<AdoptProjectScreen> createState() => _AdoptProjectScreenState();
}

class _AdoptProjectScreenState extends State<AdoptProjectScreen> {
  late AdoptProjectController adoptProjectController;

  @override
  void initState() {
    super.initState();
    adoptProjectController = Get.put(AdoptProjectController(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: (widget.showAppBar ?? false)
          ? AppTopBar(text: 'ADOPT A PROJECT')
          : AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.surface,
              title: Text(
                'ADOPT A PROJECT',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextField(
                controller: adoptProjectController.searchController,
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
                  return Row(
                    children: [
                      ...adoptProjectController.menuList.map((item) {
                        final isSelected =
                            item == adoptProjectController.selected.value;

                        return GestureDetector(
                          onTap: () {
                            adoptProjectController.selected.value = item;
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
            Obx(() {
              if (adoptProjectController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: adoptProjectController.filterVillageProjectList.length,
                  itemBuilder: (context, index) {
                    final item =
                        adoptProjectController.filterVillageProjectList[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: ShowingCard(
                        image: item.coverImage ?? 'http://10.10.12.62:8000/media/projects/covers/Screenshot_2025-08-14_111157_CPWUbyT.png',
                        title: item.title ?? 'title',
                        location: item.location ?? 'location',
                        familyCount: item.totalBenefitedFamilies ?? 0,
                        buttonTitle: item.category?.name ?? 'category',
                        onTap: () async {
                          await adoptProjectController.fetchProjectDetails(
                            item.id ?? 0,
                          );

                          if (adoptProjectController
                              .adoptProjectDetail
                              .value !=
                              null) {
                            Get.to(
                                  () => AdoptDetailScreen(
                                details: adoptProjectController
                                    .adoptProjectDetail
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
            (widget.showBottomButton ?? true)
                ? SizedBox(height: 50.h)
                : SizedBox(height: 0),
          ],
        ),
      ),
      bottomSheet: (widget.showBottomButton ?? true)
          ? Padding(
              padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
              child: PrimaryButton(
                text: 'Home',
                onTap: () {
                  Get.to(BottomNavDonation(index: 0));
                },
              ),
            )
          : null,
    );
  }
}

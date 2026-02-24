import 'package:bridges_of_glory/views/donation/explore/adopt_detail_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/controller/adopt_project_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
                onChanged: (value) {
                  adoptProjectController.searchText.value = value;
                  adoptProjectController.search(searchText: value);
                },
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(child: _buildContent()),
            if (widget.showBottomButton ?? true) SizedBox(height: 50.h),
          ],
        ),
      ),
      bottomSheet: (widget.showBottomButton ?? true)
          ? Padding(
              padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
              child: PrimaryButton(
                text: 'Home',
                onTap: () {
                  Get.to(() => BottomNavDonation(index: 0));
                },
              ),
            )
          : null,
    );
  }

  Widget _buildContent() {
    return Obx(() {
      final isSearching = adoptProjectController.searchText.value.isNotEmpty;

      if (isSearching) {
        return _buildSearchResults();
      } else {
        return _buildMainContent();
      }
    });
  }

  Widget _buildSearchResults() {
    return Obx(() {
      if (adoptProjectController.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: AppColors.red));
      }

      if (adoptProjectController.searchProjectList.isEmpty) {
        return Center(
          child: Text(
            'No search results found',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.hintText),
          ),
        );
      }

      return _buildProjectList(
        adoptProjectController.searchProjectList,
        showHorizontalPadding: true,
      );
    });
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        _buildCategorySelector(),
        SizedBox(height: 22.h),
        Expanded(child: _buildFilteredProjects()),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() {
          if (adoptProjectController.isLoading.value) {
            return Center(child: Text(''));
          }

          return Row(
            children: adoptProjectController.categoryList.map((item) {
              final isSelected =
                  item.name == adoptProjectController.selected.value;

              return GestureDetector(
                onTap: () {
                  adoptProjectController.selected.value = item.name ?? 'All';
                  adoptProjectController.selectedCategoryId.value =
                      item.id ?? 0;
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
            }).toList(),
          );
        }),
      ),
    );
  }

  Widget _buildFilteredProjects() {
    return Obx(() {
      if (adoptProjectController.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: AppColors.red));
      }

      if (adoptProjectController.filterVillageProjectList.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 120.h),
            child: Text(
              'No result found in ${adoptProjectController.selected.value} category',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.hintText),
            ),
          ),
        );
      }

      return _buildProjectList(
        adoptProjectController.filterVillageProjectList,
        showHorizontalPadding: true,
      );
    });
  }

  // Reusable project list builder
  Widget _buildProjectList(
    List<dynamic> projects, {
    bool showHorizontalPadding = false,
  }) {
    return Obx(() {
      return Skeletonizer(
        enabled: adoptProjectController.isLoading.value,
        child: ListView.builder(
          padding: showHorizontalPadding
              ? EdgeInsets.symmetric(horizontal: 20.w)
              : EdgeInsets.zero,
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final item = projects[index];
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
                onTap: () => _handleProjectTap(item),
              ),
            );
          },
        ),
      );
    });
  }

  Future<void> _handleProjectTap(dynamic item) async {
    try {
      // Get.dialog(
      //   Center(child: CircularProgressIndicator()),
      //   barrierDismissible: false,
      // );

      await adoptProjectController.fetchProjectDetails(item.id ?? 0);

      Get.back();

      if (adoptProjectController.adoptProjectDetail.value != null) {
        Get.to(
          () => AdoptDetailScreen(
            details: adoptProjectController.adoptProjectDetail.value!,
          ),
        );
      } else {
        Get.snackbar(
          'Error',
          'Unable to load project details',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();

      Get.snackbar(
        'Error',
        'Failed to load project: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

import 'package:bridges_of_glory/core/common_widgets/showing_card.dart';
import 'package:bridges_of_glory/model/category_model.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/views/donation/home/controller/doner_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../explore/empowerment_detail_screen.dart';

class CategoryWiseProjectScreen extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryWiseProjectScreen({super.key, required this.categoryModel});

  @override
  State<CategoryWiseProjectScreen> createState() =>
      _CategoryWiseProjectScreenState();
}

class _CategoryWiseProjectScreenState extends State<CategoryWiseProjectScreen> {
  late DonerHomeController donerHomeController;

  @override
  void initState() {
    super.initState();
    donerHomeController = Get.find<DonerHomeController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      donerHomeController.fetchCategoryProject(widget.categoryModel.id ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceBg,
        title: Text(widget.categoryModel.name ?? 'category'),
      ),
      body: Obx(() {
        if (donerHomeController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...donerHomeController.categoryProjectList.map((item) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: ShowingCard(
                      image: item.coverImage ?? '',
                      title: item.title ?? 'title',
                      location: item.location ?? 'location',
                      familyCount: item.totalBenefitedFamilies ?? 0,
                      buttonTitle: item.category?.name ?? 'category',
                      onTap: () async {
                        await donerHomeController.fetchProjectDetails(
                          item.id ?? 0,
                        );

                        if (donerHomeController.projectDetail.value != null) {
                          Get.to(
                            () => EmpowermentDetailScreen(
                              details: donerHomeController.projectDetail.value!,
                            ),
                          );
                        }
                      },
                    ),
                  );
                }),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}

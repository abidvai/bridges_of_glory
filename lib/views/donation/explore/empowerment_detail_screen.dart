import 'package:bridges_of_glory/views/donation/explore/controller/empowerment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/common_widgets/app_top_bar.dart';
import '../../../core/common_widgets/detail_top_card.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../utils/constant/color.dart';
import '../../../gen/assets.gen.dart';

class EmpowermentDetailScreen extends StatelessWidget {
  EmpowermentDetailScreen({super.key});

  final EmpowermentController empowermentController = Get.put(
    EmpowermentController(),
  );

  @override
  Widget build(BuildContext context) {
    final title = Get.arguments['title'];

    return Scaffold(
      backgroundColor: AppColors.surfaceBg,

      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(text: title),
            SizedBox(height: 14.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailTopCard(
                        image: Assets.images.chickensHub,
                        title: 'Project Details',
                        location: 'Lower Kasese, Kasese District Uganda',
                        pastor: 'Alvin',
                        sponsor: 'Eric Lumika',
                        chicken: 30,
                        establish: '8/11/24',
                      ),

                      SizedBox(height: 32.h),
                      Text(
                        'Stories',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'er with the regional council, sat down and found that there is a needto plant a church in kathi village for the already converted members.They mobilized funds and bought land where we are building a church without walls. This is actually a miracle that they have received. Members and non-members are surprised by what the Lord has doneThe church is currently attended by 36 members every Sunday, with hopes that after theconstruction of this church, the number might increase based on the hunger these people have forthe gospel',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          letterSpacing: 0.8,
                          wordSpacing: 1.2,
                          color: AppColors.textSecondary.withValues(alpha: 0.8),
                        ),
                      ),

                      SizedBox(height: 32.h),
                      Text(
                        'Recent Updates',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),

                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Icon(Iconsax.calendar_1, size: 20.w),
                          SizedBox(width: 3.w),
                          Text('Nov 15, 2024'),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'A close-knit community working together to build sustainable livelihoods through agriculture and livestock. Our journey began 5 years ago with a vision to improve our community.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          letterSpacing: 0.8,
                          wordSpacing: 1.2,
                          color: AppColors.textSecondary.withValues(alpha: 0.8),
                        ),
                      ),

                      SizedBox(height: 32.h),
                      Text(
                        'Impact so far',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        '120 families have directly benefited from our projects.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          letterSpacing: 0.8,
                          wordSpacing: 1.2,
                          color: AppColors.textSecondary.withValues(alpha: 0.8),
                        ),
                      ),

                      ExpansionTile(
                        // collapsedShape: OutlineInputBorder(),
                        title: Text('Pastor Support'),
                        shape: InputBorder.none,
                        children: [
                          Obx(
                            () => Column(
                              children: [
                                RadioListTile<int>(
                                  title: Text('\$ 100 UsD'),
                                  value: 100,
                                  groupValue:
                                      empowermentController.pastorSupport.value,
                                  onChanged: (value) {
                                    empowermentController.pastorSupport.value =
                                        value!;
                                  },
                                  activeColor: AppColors.red,
                                ),
                                RadioListTile<int>(
                                  title: Text('\$ 200 USD'),
                                  value: 200,
                                  groupValue:
                                      empowermentController.pastorSupport.value,
                                  onChanged: (value) {
                                    empowermentController.pastorSupport.value =
                                        value!;
                                  },
                                  activeColor: AppColors.red,
                                ),
                                RadioListTile<int>(
                                  title: Text('\$ 300 USD'),
                                  value: 300,
                                  groupValue:
                                      empowermentController.pastorSupport.value,
                                  onChanged: (value) {
                                    empowermentController.pastorSupport.value =
                                        value!;
                                  },
                                  activeColor: AppColors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        // collapsedShape: OutlineInputBorder(),
                        title: Text('Livestock for Village'),
                        shape: InputBorder.none,
                        children: [
                          Obx(
                            () => Column(
                              children: [
                                RadioListTile<int>(
                                  title: Text('\100 Goats'),
                                  value: 100,
                                  groupValue: empowermentController
                                      .liveStockSupport
                                      .value,
                                  onChanged: (value) {
                                    empowermentController
                                            .liveStockSupport
                                            .value =
                                        value!;
                                  },
                                  activeColor: AppColors.red,
                                ),
                                RadioListTile<int>(
                                  title: Text('\$ 200 Pigs'),
                                  value: 200,
                                  groupValue: empowermentController
                                      .liveStockSupport
                                      .value,
                                  onChanged: (value) {
                                    empowermentController
                                            .liveStockSupport
                                            .value =
                                        value!;
                                  },
                                  activeColor: AppColors.red,
                                ),
                                RadioListTile<int>(
                                  title: Text('\$ 500 Chicken'),
                                  value: 300,
                                  groupValue: empowermentController
                                      .liveStockSupport
                                      .value,
                                  onChanged: (value) {
                                    empowermentController
                                            .liveStockSupport
                                            .value =
                                        value!;
                                  },
                                  activeColor: AppColors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        // collapsedShape: OutlineInputBorder(),
                        title: Text('Other(used for items for the church)'),
                        shape: InputBorder.none,
                        children: [
                          Obx(
                            () => Column(
                              children: [
                                RadioListTile<int>(
                                  title: Text('\$ 50'),
                                  value: 50,
                                  groupValue:
                                      empowermentController.churchSupport.value,
                                  onChanged: (value) {
                                    empowermentController.churchSupport.value =
                                        value!;
                                  },
                                  activeColor: AppColors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: PrimaryButton(
          text: 'Click to Support this Village',
          onTap: () {
            // Get.toNamed(AppRoutes.verifyOtp);
          },
        ),
      ),
    );
  }
}

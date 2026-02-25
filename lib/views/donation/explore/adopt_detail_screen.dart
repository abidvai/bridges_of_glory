import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/auth/login/controller/login_controller.dart';
import 'package:bridges_of_glory/views/auth/signup/controller/signup_Controller.dart';
import 'package:bridges_of_glory/views/donation/explore/controller/adopt_project_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/common_widgets/detail_top_card.dart';
import '../../../model/project_detail_model.dart';
import '../../../utils/constant/color.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/formate_date.dart';

class AdoptDetailScreen extends StatelessWidget {
  final ProjectDetailsModel details;

  AdoptDetailScreen({super.key, required this.details});

  final AdoptProjectController adoptProjectController =
      Get.find<AdoptProjectController>();

  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(text: details.title),
            SizedBox(height: 14.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailTopCard(
                        image: details.coverImage,
                        title: details.title,
                        location: details.location,
                        pastor: details.pastorName,
                        sponsor: details.sponsorName,
                        establish: details.establishedDate,
                        category: details.category.name,
                      ),

                      SizedBox(height: 32.h),
                      Text(
                        'Stories',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        details.projectStories,
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
                          Text(formatDate(details.updatedAt)),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        details.recentUpdates,
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
                        details.impact,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          letterSpacing: 0.8,
                          wordSpacing: 1.2,
                          color: AppColors.textSecondary.withValues(alpha: 0.8),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      //TODO: use visibility to display this section after verified
                      Text(
                        'Contribute Us',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 10.h),
                      ExpansionTile(
                        title: Text('Pastor Support'),
                        shape: InputBorder.none,
                        children: [
                          Obx(
                            () => Column(
                              children: details.pastorSupportPrices.map((item) {
                                return RadioListTile<String>(
                                  title: Text('\$${item.amount}'),
                                  value: 'pastor ${item.amount}',
                                  groupValue: adoptProjectController
                                      .selectedSupportValue
                                      .value,
                                  onChanged: (val) {
                                    adoptProjectController
                                            .selectedSupportValue
                                            .value =
                                        val!;
                                    adoptProjectController
                                            .selectedSupportTitle
                                            .value =
                                        'pastor';
                                  },
                                  activeColor: AppColors.red,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),

                      ExpansionTile(
                        title: Text('LiveStock for Village'),
                        shape: InputBorder.none,
                        children: [
                          Obx(
                            () => Column(
                              children: details.livestockItems.map((item) {
                                return RadioListTile<String>(
                                  title: Text(
                                    '\$${item.amount} ${item.name} (${item.quantity})',
                                  ),
                                  value: 'livestock ${item.amount}',
                                  groupValue: adoptProjectController
                                      .selectedSupportValue
                                      .value,
                                  onChanged: (val) {
                                    adoptProjectController
                                            .selectedSupportValue
                                            .value =
                                        val!;
                                    adoptProjectController
                                            .selectedSupportTitle
                                            .value =
                                        'livestock';
                                  },
                                  activeColor: AppColors.red,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text('Other Supports'),
                        shape: InputBorder.none,
                        children: [
                          Obx(
                            () => Column(
                              children: details.otherSupports.map((item) {
                                return RadioListTile<String>(
                                  title: Text('\$${item.amount}'),
                                  value: 'other ${item.amount}',
                                  groupValue: adoptProjectController
                                      .selectedSupportValue
                                      .value,
                                  onChanged: (val) {
                                    adoptProjectController
                                            .selectedSupportValue
                                            .value =
                                        val!;
                                    adoptProjectController
                                            .selectedSupportTitle
                                            .value =
                                        'other';
                                  },
                                  activeColor: AppColors.red,
                                );
                              }).toList(),
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
        child: Obx(() {
          return PrimaryButton(
            text: 'Click to Support this Village',
            loading: adoptProjectController.isLoading.value,
            onTap: () async {
              final ok = await adoptProjectController.getOtp();

              if (ok) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors.surfaceBg,
                      title: Text(
                        'Check your email',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Text(
                              'Please enter the four-digit code we sent to you to view the price',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            controller.emailController.text,
                            style: TextStyle(color: AppColors.red),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                          OtpTextField(
                            numberOfFields: 4,
                            cursorColor: AppColors.text,
                            fillColor: AppColors.surface,
                            filled: true,
                            focusedBorderColor: AppColors.red,
                            enabledBorderColor: AppColors.border,
                            showFieldAsBox: true,
                            borderRadius: BorderRadius.circular(12.r),
                            fieldWidth: 48.w,
                            borderWidth: 1.5,
                            fieldHeight: 48.w,
                            textStyle: TextStyle(
                              color: AppColors.text,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            onCodeChanged: (String code) {},
                            onSubmit: (String verificationCode) {
                              adoptProjectController.otp = verificationCode;
                            },
                          ),
                          SizedBox(height: 32.h),
                          Obx(() {
                            return PrimaryButton(
                              text: 'verify',
                              loading: adoptProjectController.isLoading.value,
                              onTap: () async {
                                final amount = double.parse(
                                  adoptProjectController
                                      .selectedSupportValue
                                      .value,
                                );
                                await adoptProjectController.submitOtp(
                                  details.id,
                                  details.title,
                                  adoptProjectController
                                      .selectedSupportTitle
                                      .value,
                                  amount,
                                );
                              },
                            );
                          }),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          );
        }),
      ),
    );
  }
}

import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/detail_top_card.dart';
import 'package:bridges_of_glory/model/project_detail_model.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/views/donation/explore/controller/witness_women_controlle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../core/route/app_routes.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/formate_date.dart';

class WitnessWomenDetailScreen extends StatelessWidget {
  final ProjectDetailsModel details;

  WitnessWomenDetailScreen({super.key, required this.details});

  final WitnessWomenController witnessWomenController =
      Get.find<WitnessWomenController>();

  // var isVerify = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: AppTopBar(text: details.title ?? 'title'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailTopCard(
                image:
                    details.coverImage ??
                    'http://10.10.12.62:8000/media/projects/covers/Rectangle_4_gwWg3fv.png',
                title: details.title ?? 'title',
                location: details.location ?? 'location',
                pastor: details.pastorName ?? 'pastor name',
                sponsor: details.sponsorName ?? 'sponsor name',
                category: details.category?.name ?? 'category',
                establish: details.establishedDate ?? DateTime.now(),
              ),

              SizedBox(height: 32.h),
              Text('Stories', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 12.h),
              Text(
                details.projectStories ?? 'project stories',
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
                details.recentUpdates ?? 'recent update',
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
                details.impact ?? 'impact',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  letterSpacing: 0.8,
                  wordSpacing: 1.2,
                  color: AppColors.textSecondary.withValues(alpha: 0.8),
                ),
              ),

              SizedBox(height: 32.h),

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
                          value: item.amount,
                          groupValue:
                              witnessWomenController.selectedSupport.value,
                          onChanged: (val) {
                            witnessWomenController.selectedSupport.value = val!;
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
                          value: item.amount,
                          groupValue:
                              witnessWomenController.selectedSupport.value,
                          onChanged: (val) {
                            witnessWomenController.selectedSupport.value = val!;
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
                          value: item.amount,
                          groupValue:
                              witnessWomenController.selectedSupport.value,
                          onChanged: (val) {
                            witnessWomenController.selectedSupport.value = val!;
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
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: PrimaryButton(
          // text : isVerify ? 'Sponsor' : 'Click to Sponsor'
          text: 'Click to Sponsor',
          onTap: () {
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
                          'Please enter the 4-digit code we sent to you to view the price',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'example@gmail.com',
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
                          // forgotController.otp = verificationCode;
                        },
                      ),
                      SizedBox(height: 32.h),
                      PrimaryButton(
                        text: 'verify',
                        onTap: () {
                          Get.toNamed(AppRoutes.paymentScreen);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

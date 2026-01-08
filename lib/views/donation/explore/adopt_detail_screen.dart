import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/common_widgets/detail_top_card.dart';
import '../../../utils/constant/color.dart';
import '../../../gen/assets.gen.dart';

class AdoptDetailScreen extends StatelessWidget {
  const AdoptDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(text: args['title']),
            SizedBox(height: 14.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailTopCard(
                        image: 'http://10.10.12.62:8000/media/projects/covers/Rectangle_4_gwWg3fv.png',
                        title: 'Adopt Prisons/ Villages',
                        location: 'Lower Kasese, Kasese District Uganda',
                        pastor: 'Alvin',
                        sponsor: 'Eric Lumika',
                        establish: DateTime.now(),
                        category: '30',
                      ),

                      SizedBox(height: 32.h),
                      Text(
                        'Stories',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Village is called kathi village found in busongora north, kasese district under the leadership of Rev Eric Lumika. This church started in 2020 after a team of evangelists conducted a door-to-door preaching in thisvillage, where 4 households accepted Jesus as Lord and Savior, who could travel a long distance ofabout 5km to reach the neighbouring church called kitswamba full gospel for fellowshipAs these 4 families continued to testify to others about how the Lord had healed their diseases,chased our demons that tormented them, the number increased.Then the mother church, together with the regional council, sat down and found that there is a needto plant a church in kathi village for the already converted members.They mobilized funds and bought land where we are building a church without walls. This is actually a miracle that they have received. Members and non-members are surprised by what the Lord has doneThe church is currently attended by 36 members every Sunday, with hopes that after theconstruction of this church, the number might increase based on the hunger these people have forthe gospel',
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
                        'The first batch of cow farm training has been successfully completed.',
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

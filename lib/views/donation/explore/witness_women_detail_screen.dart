import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/detail_top_card.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../gen/assets.gen.dart';

class WitnessWomenDetailScreen extends StatelessWidget {
  const WitnessWomenDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final title = Get.arguments['title'];

    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: AppTopBar(text: title),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailTopCard(
                image: Assets.images.chickensHub,
                title: 'Chicken Project by WWW',
                location: 'Lower Kasese, Kasese District Uganda',
                pastor: 'Alvin',
                sponsor: 'Eric Lumika',
                chicken: '8/11/24',
                establish: '30',
              ),

              SizedBox(height: 32.h),
              Text('Stories', style: Theme.of(context).textTheme.titleSmall),
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
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: PrimaryButton(
          text: 'Click to Sponsor',
          onTap: () {
            // Get.toNamed(AppRoutes.verifyOtp);
          },
        ),
      ),
    );
  }
}

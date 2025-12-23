import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/custom_text_field.dart';
import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(text: 'Create Projects'),
      backgroundColor: AppColors.surfaceBg,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project Category',
                style: Theme.of(context).textTheme.titleSmall,
              ),

              Text(
                'Project Title',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: 'Your title goes here...',
                maxLines: 1,
              ),
              SizedBox(height: 28.h),

              Text(
                'Select Location',
                style: Theme.of(context).textTheme.titleSmall,
              ),

              Text('Pastor', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: 'Name',
                maxLines: 1,
              ),

              SizedBox(height: 28.h),
              Text('Sponsor', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: 'Sponsor Name',
                maxLines: 1,
              ),
              SizedBox(height: 28.h),
              Text(
                'Established',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: 'Name',
                maxLines: 1,
              ),
              SizedBox(height: 28.h),

              Text('Chickens', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: 'Add family number',
                maxLines: 1,
              ),
              SizedBox(height: 28.h),
              Text('Stories', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: 'Your description goes here...',
                maxLines: 5,
              ),
              SizedBox(height: 28.h),
              PrimaryButton(text: 'Create'),
            ],
          ),
        ),
      ),
    );
  }
}

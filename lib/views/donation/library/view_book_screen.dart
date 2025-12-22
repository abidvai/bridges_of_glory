import 'package:bridges_of_glory/core/common_widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/color.dart';

class ViewBookScreen extends StatelessWidget {

  const ViewBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final image = Get.arguments;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(height: 1.sh, width: 1.sw),
                image.image(
              width: 1.sw,
              height: 612.h,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 260.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                  color: AppColors.surface,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Intro',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            width: 87.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.border,
                                width: 1.2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 5.h,
                            ),
                            child: Center(
                              child: DropdownButton<String>(
                                padding: EdgeInsets.zero,
                                underline: SizedBox(),
                                isExpanded: true,
                                value: 'English',
                                borderRadius: BorderRadius.circular(10.r),
                                dropdownColor: AppColors.blueish,
                                items: [
                                  DropdownMenuItem(
                                    value: 'English',
                                    child: Text(
                                      'English',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Spanish',
                                    child: Text(
                                      'Spanish',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Hindi',
                                    child: Text(
                                      'Hindi',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Dutch',
                                    child: Text(
                                      'Dutch',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  print('Selected: $value');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Nec egestas tempor turpis enim. Bibendum nulla placerat risus habitant. Eu pellentesque pretium massa orci. Cursus tincidunt purus congue blandit massa quam tortor diam.',
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Nec egestas tempor turpis enim. Bibendum nulla placerat risus habitant. Eu pellentesque pretium massa orci. Cursus tincidunt purus congue blandit massa quam tortor diam.Lorem ipsum dolor sit amet consectetur. Nec egestas tempor turpis enim. Bibendum nulla placerat risus habitant. Eu pellentesque pretium massa orci. Cursus tincidunt purus congue blandit massa quam tortor diam.',
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Nec egestas tempor turpis enim. Bibendum nulla placerat risus habitant. Eu pellentesque pretium massa orci Eu pellentesque pretium massa orci. Cursus tincidunt purus congue blandit massa quam tortor diam.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: AppBackButton(iconColor: AppColors.surface),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/custom_text_field.dart';
import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:bridges_of_glory/env_handler.dart';
import 'package:bridges_of_glory/views/owner/create/controller/create_controller.dart';
import 'package:bridges_of_glory/views/owner/create/google_map_search.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({super.key});

  final CreateController controller = Get.put(CreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surfaceBg,
        title: Text('Create', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
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
              SizedBox(height: 12.h),

              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(width: 1.2, color: AppColors.border),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                ),
                borderRadius: BorderRadius.circular(12.r),
                dropdownColor: AppColors.surface,
                alignment: Alignment.centerLeft,
                style: Theme.of(context).textTheme.bodyLarge,
                hint: Text('Select a category'),
                items: [
                  DropdownMenuItem(
                    value: ProjectCategory.chicken,
                    child: Text('Chicken'),
                  ),
                  DropdownMenuItem(
                    value: ProjectCategory.cow,
                    child: Text('Cow'),
                  ),
                  DropdownMenuItem(
                    value: ProjectCategory.goat,
                    child: Text('Goat'),
                  ),
                  DropdownMenuItem(
                    value: ProjectCategory.pig,
                    child: Text('Pig'),
                  ),
                  DropdownMenuItem(
                    value: ProjectCategory.business,
                    child: Text('Business'),
                  ),
                  DropdownMenuItem(
                    value: ProjectCategory.becomeTheMovement,
                    child: Text('Become The Movement'),
                  ),
                  DropdownMenuItem(
                    value: ProjectCategory.kingdomEmpowerment,
                    child: Text('Kingdom Empowerment'),
                  ),
                  DropdownMenuItem(
                    value: ProjectCategory.walkingWitnessWomen,
                    child: Text('Walking Witness Women'),
                  ),
                  DropdownMenuItem(
                    value: ProjectCategory.adoptAVillagePrison,
                    child: Text('Adopt A Village / Prison'),
                  ),
                ],
                onChanged: (value) {},
              ),

              SizedBox(height: 28.h),

              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  dashPattern: [6, 6],
                  radius: Radius.circular(12.r),
                ),
                child: GestureDetector(
                  onTap: () {
                    controller.pickImage(context);
                  },
                  child: Container(
                    width: 335.w,
                    height: 187.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: controller.selectedImage.value != null
                          ? AssetEntityImage(
                              controller.selectedImage.value!,
                              isOriginal: false,
                              thumbnailSize: ThumbnailSize.square(200),
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.image_search_outlined, size: 25.w),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 28.h),
              Text(
                'Project Title',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: controller.title,
                hintText: 'Your title goes here...',
                maxLines: 1,
              ),
              SizedBox(height: 28.h),

              Text(
                'Select Location',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () {
                  Get.to(
                    GoogleMapScreen(
                      apiKey: EnvHandler.google_map_api_key,
                      onLocationSelect: (location) {
                        controller.selectedLocationText.value = location.name;
                        controller.selectedLatLng.value = location.position;
                      },
                    ),
                  );
                },
                child: Container(
                  width: 335.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey, width: 1.2),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 24.w,
                        color: Colors.grey[700],
                      ),
                      SizedBox(width: 12.w),
                      Obx(
                        () => Expanded(
                          child: Text(
                            controller.selectedLocationText.value.isEmpty
                                ? 'Select Location'
                                : controller.selectedLocationText.value,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color:
                                  controller.selectedLocationText.value.isEmpty
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 28.h),
              Text('Pastor', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: controller.pastor,
                hintText: 'Name',
                maxLines: 1,
              ),

              SizedBox(height: 28.h),
              Text('Sponsor', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: controller.sponsorName,
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
                controller: controller.establish,
                hintText: 'Name',
                maxLines: 1,
              ),
              SizedBox(height: 28.h),

              Text('Chickens', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: controller.chickens,
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

              Text(
                'Recent Updates',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 12.h),
              Text(
                'Select Date',
                style: Theme.of(context).textTheme.titleSmall,
              ),

              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate:
                        controller.selectedDate.value ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    controller.setDate(picked);
                  }
                },
                child: Container(
                  width: 335.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey, width: 1.2),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 24.w,
                        color: Colors.grey[700],
                      ),
                      SizedBox(width: 12.w),
                      Obx(
                        () => Text(
                          controller.selectedDate.value != null
                              ? DateFormat(
                                  'dd MMM yyyy',
                                ).format(controller.selectedDate.value!)
                              : 'Select Date',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 12.h),
              CustomTextField(
                controller: controller.description,
                hintText: 'Your description goes here...',
              ),

              SizedBox(height: 28.h),
              Text(
                'Impact so far',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: 'Your description goes here...',
              ),

              SizedBox(height: 60.h),
              PrimaryButton(text: 'Create'),
            ],
          ),
        ),
      ),
    );
  }
}

enum ProjectCategory {
  chicken,
  cow,
  goat,
  pig,
  business,
  becomeTheMovement,
  kingdomEmpowerment,
  walkingWitnessWomen,
  adoptAVillagePrison,
}

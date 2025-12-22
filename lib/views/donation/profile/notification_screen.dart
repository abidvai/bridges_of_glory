import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:load_switch/load_switch.dart';

import '../../../core/constant/color.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  Widget _notificationItem({required String title, required String text}) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 36.w),
          CustomSwitch(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.surface,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: AppColors.border.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16.w,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                  Text(
                    'Notification Settings',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(flex: 3),
                ],
              ),
            ),
            SizedBox(height: 36.h),
            _notificationItem(
              title: 'Pop up notification',
              text: 'Get an notification every time someone accepts your offer',
            ),
            SizedBox(height: 15.h),
            Divider(color: AppColors.hintText.withValues(alpha: 0.4)),
            SizedBox(height: 15.h),
            _notificationItem(
              title: 'Turn on all chat notification',
              text: 'Get an notification every time someone cancels an order',
            ),
            SizedBox(height: 15.h),
            Divider(color: AppColors.hintText.withValues(alpha: 0.4)),
            SizedBox(height: 15.h),
            _notificationItem(
              title: 'Turn on new update notification',
              text: 'Get an notification every time someone leaves a review',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return LoadSwitch(
      value: value,
      width: 36.w,
      height: 16.w,
      future: () async {
        return await Future.delayed(Duration(milliseconds: 500), () {
          return !value;
        });
      },
      style: SpinStyle.material,
      curveIn: Curves.easeInBack,
      curveOut: Curves.easeOutBack,
      animationDuration: const Duration(milliseconds: 500),
      switchDecoration: (value, value2) => BoxDecoration(
        color: value
            ? AppColors.red.withOpacity(0.5)
            : AppColors.hintText.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: value
                ? AppColors.red.withOpacity(0.1)
                : AppColors.hintText.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      spinColor: (value) =>
          value ? AppColors.red : const Color.fromARGB(255, 255, 77, 77),
      spinStrokeWidth: 1,
      thumbDecoration: (value, value2) => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: value
                ? AppColors.red.withOpacity(0.1)
                : AppColors.hintText.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      onChange: (v) {
        value = v;
        print('Value changed to $v');
        setState(() {});
      },
      onTap: (v) {
        print('Tapping while value is $v');
      },
    );
  }
}

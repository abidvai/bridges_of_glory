import 'package:bridges_of_glory/core/common_widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/common_widgets/primary_button.dart';
import '../utils/constant/color.dart';

class InfoScreen extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String information;
  final String description;
  final bool isMovement;

  const InfoScreen({
    super.key,
    required this.onTap,
    required this.title,
    required this.information,
    required this.description,
    this.isMovement = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: InfoWidget(
                title: title,
                information: information,
                description: description,
                onTap: onTap,
                showMovement: isMovement,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: PrimaryButton(text: 'Skip', onTap: onTap),
      ),
    );
  }
}

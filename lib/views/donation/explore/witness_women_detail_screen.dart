import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/detail_top_card.dart';
import 'package:bridges_of_glory/model/project_detail_model.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../gen/assets.gen.dart';

class WitnessWomenDetailScreen extends StatefulWidget {
  final ProjectDetailsModel details;

  const WitnessWomenDetailScreen({super.key, required this.details});

  @override
  State<WitnessWomenDetailScreen> createState() =>
      _WitnessWomenDetailScreenState();
}

class _WitnessWomenDetailScreenState extends State<WitnessWomenDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: AppTopBar(text: widget.details.title ?? 'title'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailTopCard(
                image:
                    widget.details.coverImage ??
                    'http://10.10.12.62:8000/media/projects/covers/Rectangle_4_gwWg3fv.png',
                title: widget.details.title ?? 'title',
                location: widget.details.location ?? 'location',
                pastor: widget.details.pastorName ?? 'pastor name',
                sponsor: widget.details.sponsorName ?? 'sponsor name',
                category: widget.details.category?.name ?? 'category',
                establish: widget.details.establishedDate ?? DateTime.now(),
              ),

              SizedBox(height: 32.h),
              Text('Stories', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 12.h),
              Text(
                widget.details.projectStories ?? 'project stories',
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
                  Text(formatDate(widget.details.updatedAt)),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                widget.details.recentUpdates ?? 'recent update',
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
                widget.details.impact ?? 'impact',
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


String formatDate(dynamic value) {
  if (value == null) return '';

  try {
    DateTime date;
    if (value is DateTime) {
      date = value;
    } else {
      date = DateTime.parse(value.toString());
    }
    return DateFormat('MMM d, yyyy').format(date); // Nov 15, 2024
  } catch (_) {
    return value.toString(); // if not a date, return as-is
  }
}

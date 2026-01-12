import 'package:bridges_of_glory/core/common_widgets/app_back_button.dart';
import 'package:bridges_of_glory/core/common_widgets/icon_container.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import '../../gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoWidget extends StatelessWidget {
  final String information;
  final String description;
  final String title;
  final VoidCallback onTap;
  final bool showMovement;
  final String? url;

  const InfoWidget({
    super.key,
    required this.information,
    required this.description,
    required this.onTap,
    required this.title,
    this.showMovement = false,
    this.url,
  });

  Future<void> goToYt(String link) async {
    final Uri url = Uri.parse(link);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: double.infinity),
        Container(
          width: double.infinity,
          height: 121.h,
          color: AppColors.secondary,
        ),
        Positioned(
          left: 100.w,
          top: 45.h,
          child: Assets.images.appLogo2.image(),
        ),
        Positioned(top: 8, left: 16, child: AppBackButton()),
        Positioned(
          top: 100.h,
          left: 0.w,
          right: 0.w,
          bottom: 0.h,
          // Add bottom padding for the button
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 16.h),

                          Text(
                            'YouTube',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'To watch our works: ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  goToYt(
                                    url ??
                                        'https://www.youtube.com/watch?v=65vwVG2B138&list=PLlQVyyPF7a-qO4GVVo2IklIB_eZuKj2uM&index=11',
                                  );
                                },
                                child: Row(
                                  children: [
                                    Assets.icons.youtube.svg(
                                      width: 90.w,
                                      height: 50.h,
                                    ),
                                    Text(
                                      'YouTube',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Information',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            information,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          if (showMovement) ...[
                            SizedBox(height: 20.h),
                            Text(
                              'Contact Us',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'You can get in touch with us through below platforms. We will reach out to you as soon as it would be possible',
                            ),

                            SizedBox(height: 20.h),
                            ContactInfoCard(
                              title: 'Contact Number',
                              value: '+1 (555) 123-4567',
                              path: Assets.icons.call.path,
                              urlScheme: 'tel:+15551234567',
                            ),
                            ContactInfoCard(
                              title: 'Mail address',
                              value: 'example@gmail.com',
                              path: Assets.icons.mail.path,
                              urlScheme: 'mailto:example@gmail.com',
                            ),
                          ],
                          // Spacer(),
                          SizedBox(height: 60.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ContactInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String path;
  final String? urlScheme;

  const ContactInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.path,
    this.urlScheme,
  });

  Future<void> _launchUrl() async {
    if (urlScheme == null) return;

    final Uri uri = Uri.parse(urlScheme!);

    if (!await launchUrl(uri)) {
      throw 'Could not launch $urlScheme';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchUrl,
      child: ListTile(
        leading: SvgPicture.asset(path, width: 35, height: 35),
        title: Text(title),
        subtitle: Text(value),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

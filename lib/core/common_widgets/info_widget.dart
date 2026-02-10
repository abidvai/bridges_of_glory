import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../gen/assets.gen.dart';
import 'package:bridges_of_glory/core/common_widgets/app_back_button.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';

class InfoWidget extends StatefulWidget {
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

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  late YoutubePlayerController _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();

    // Start with portrait mode lock
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final videoId = YoutubePlayer.convertUrlToId(widget.url ?? '');
    if (videoId == null) {
      throw Exception('Invalid YouTube URL');
    }

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: true,
        disableDragSeek: true,
        useHybridComposition: true,
        enableCaption: false,
        hideThumbnail: true,
        hideControls: false,
        // Disable full screen button
        showLiveFullscreenButton: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    // Restore orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: Stack(
        children: [
          // Background Top Section
          Container(
            width: double.infinity,
            height: 121.h,
            color: AppColors.secondary,
          ),

          // App Logo
          Positioned(
            left: 100.w,
            top: 45.h,
            child: Assets.images.appLogo2.image(),
          ),

          // Back Button
          Positioned(
            top: 8,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),

          // Main Content
          Positioned(
            top: 100.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Video Player without full screen option
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: AppColors.secondary,
                            progressColors: ProgressBarColors(
                              playedColor: AppColors.secondary,
                              handleColor: AppColors.secondary,
                              backgroundColor: Colors.grey[300],
                              bufferedColor: Colors.grey[200],
                            ),
                            onReady: () {
                              setState(() {
                                _isReady = true;
                              });
                            },
                            // Custom bottom actions without full screen button
                            bottomActions: [
                              CurrentPosition(),
                              ProgressBar(isExpanded: true),
                              RemainingDuration(),
                              // Removed FullScreenButton
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Information
                      Text(
                        'Information',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        widget.information,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.text.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Description
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        widget.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.text.withOpacity(0.8),
                        ),
                      ),

                      if (widget.showMovement) ...[
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
                          'You can get in touch with us through the platforms below. We will reach out to you as soon as possible.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.text.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        ContactInfoCard(
                          title: 'Contact Number',
                          value: '406-282-1198',
                          path: Assets.icons.call.path,
                          urlScheme: 'tel:406-282-1198',
                        ),
                        ContactInfoCard(
                          title: 'Mail Address',
                          value: 'info@walkingwitness.org',
                          path: Assets.icons.mail.path,
                          urlScheme: 'mailto:info@walkingwitness.org',
                        ),
                      ],

                      SizedBox(height: 80.h), // Extra space for bottom button
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Contact Info Card
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
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlScheme';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchUrl,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: SvgPicture.asset(
            path,
            width: 35,
            height: 35,
            colorFilter: ColorFilter.mode(
              AppColors.secondary,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          subtitle: Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[700],
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
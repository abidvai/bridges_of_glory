import 'package:bridges_of_glory/core/common_widgets/app_back_button.dart';
import 'package:bridges_of_glory/core/common_widgets/custom_text_field.dart';
import 'package:bridges_of_glory/views/owner/home/controller/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constant/color.dart';
import '../../../model/chat_model.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  final ScrollController _scrollController = ScrollController();
  final MessageController messageController = MessageController();

  void sendMessage() {
    if (messageController.controller.text.trim().isEmpty) return;

    messageController.messages.add(
      ChatMessageModel(
        text: messageController.controller.text.trim(),
        isSender: true,
      ),
    );
    messageController.controller.clear();

    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 5.h),
              Obx(() {
                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 16.h,
                    ),
                    itemCount: messageController.messages.length,
                    itemBuilder: (context, index) {
                      final message = messageController.messages[index];

                      return Align(
                        alignment: message.isSender
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          decoration: BoxDecoration(
                            color: message.isSender
                                ? AppColors.red.withValues(alpha: 0.8)
                                : AppColors.chatBg,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: message.isSender
                                  ? Colors.white
                                  : AppColors.text,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: messageController.controller,
                hintText: 'Write...',
                suffixIcon: IconButton(
                  onPressed: () {
                    sendMessage();
                  },
                  icon: Icon(Iconsax.send_24, size: 25.w),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

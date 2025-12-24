import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/custom_text_field.dart';
import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/gen/assets.gen.dart';
import 'package:bridges_of_glory/views/donation/payment/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTopBar(text: 'Payment Method'),
              SizedBox(height: 35.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 335.w,
                      height: 215.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(width: 1.2, color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          PaymentOption(
                            icon: Assets.icons.paypal.svg(),
                            title: 'Paypal',
                            value: 'paypal',
                            selectedPayment: paymentController.selectedPayment,
                          ),
                          Divider(),
                          PaymentOption(
                            icon: Assets.icons.stripe.svg(),
                            title: 'Stripe',
                            value: 'stripe',
                            selectedPayment: paymentController.selectedPayment,
                          ),
                          Divider(),
                          PaymentOption(
                            icon: Assets.icons.cash.svg(),
                            title: 'Cash App',
                            value: 'cashApp',
                            selectedPayment: paymentController.selectedPayment,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      'Notice',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextField(
                      controller: paymentController.noticeController,
                      hintText:
                          'If your payment amount is above please send us a message here...',
                      maxLines: 10,
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: PrimaryButton(
                        text: 'Send',
                        width: 100.w,
                        height: 40.h,
                        backgroundColor: AppColors.text,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: PrimaryButton(
          text: 'Next',
          onTap: () {
            Get.toNamed(AppRoutes.paymentSuccessScreen);
          },
        ),
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final SvgPicture icon;
  final String title;
  final String value;
  final RxString selectedPayment;

  const PaymentOption({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.selectedPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon,
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        Obx(
          () => Radio<String>(
            splashRadius: 20.r,
            value: value,
            groupValue: selectedPayment.value,
            onChanged: (val) {
              if (val != null) selectedPayment.value = val;
            },
          ),
        ),
      ],
    );
  }
}

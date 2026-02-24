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
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late WebViewController controller;
  final PaymentController paymentController = Get.put(PaymentController());

  Future<void> startPayment(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch payment page';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments as Map;

    print(data['amount']);
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
                          // Divider(),
                          // PaymentOption(
                          //   icon: Assets.icons.cashApp.svg(),
                          //   title: 'Cash App',
                          //   value: 'cashApp',
                          //   selectedPayment: paymentController.selectedPayment,
                          // ),
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
                          'If your payment amount is above \$1000 please send us a message here...',
                      maxLines: 10,
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Obx(() {
                        return PrimaryButton(
                          text: 'Send',
                          width: 100.w,
                          height: 40.h,
                          loading: paymentController.isLoading2.value,
                          backgroundColor: AppColors.text,
                          onTap: () async {
                            final response = await paymentController
                                .sendEmailPay(
                                  data['projectId'],
                                  paymentController.noticeController.text,
                                );
                            if (response) {
                              Get.offAllNamed(AppRoutes.donationBottomNav);
                            }
                          },
                        );
                      }),
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
        child: Obx(() {
          return PrimaryButton(
            loading: paymentController.isLoading.value,
            text: 'Next',
            onTap: () async {
              final url = await paymentController.payment(
                data['projectId'],
                data['projectName'],
                data['supportType'],
                data['amount'],
              );
              if (url != null) {
                startPayment(url);
              }
            },
          );
        }),
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

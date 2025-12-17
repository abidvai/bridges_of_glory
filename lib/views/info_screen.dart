import 'package:bridges_of_glory/core/common_widgets/info_widget.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InfoWidget(
        information:
            'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
        description:
            'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
        onTap: () {
          Get.toNamed(AppRoutes.selectUser);
        },
      ),
    );
  }
}

import 'package:bridges_of_glory/core/common_widgets/info_widget.dart';
import 'package:bridges_of_glory/utils/enum/explore_type.dart';
import 'package:bridges_of_glory/views/donation/explore/adopt_project_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/controller/explore_controller.dart';
import 'package:bridges_of_glory/views/donation/explore/empowerment_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/witness_women_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/common_widgets/primary_button.dart';
import 'donation/library/library_screen.dart';

class InfoScreen extends StatefulWidget {
  final int id;

  const InfoScreen({super.key, required this.id});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late ExploreController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ExploreController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getExploreDetails(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: InfoWidget(
                      title:
                          controller.exploreDetail.value?.title ??
                          'Walking Witness',
                      information:
                          controller.exploreDetail.value?.information ??
                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                      description:
                          controller.exploreDetail.value?.description ??
                          'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                      onTap: () {},
                      showMovement: true,
                      url:
                          controller.exploreDetail.value?.link ??
                          'https://www.youtube.com/watch?v=HH-Hgc3O1Ec',
                    ),
                  ),
                ],
              ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: PrimaryButton(
          text: 'Skip',
          onTap: () {
            switch (controller.exploreDetail.value?.type) {
              case ExploreType.becomeTheMovement:
                Get.back();
                break;
              case ExploreType.kingdomEmpowerment:
                Get.to(EmpowermentScreen(id: widget.id));
                break;
              case ExploreType.walkingWitnessWomen:
                Get.to(WitnessWomenScreen(id: widget.id));
                break;
              case ExploreType.adoptAVillage:
                Get.to(
                  AdoptProjectScreen(id: controller.exploreDetail.value!.id!),
                );
                break;
              case ExploreType.biblesBooksAndMore:
                Get.to(() => LibraryScreen(showAppBar: true));
                break;
              case ExploreType.livingInTheKingdom:
                Get.back();
                break;
              case null:
                Get.back();
            }
          },
        ),
      ),
    );
  }
}

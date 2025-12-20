import 'package:bridges_of_glory/core/common_widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoScreen extends StatelessWidget {
  final VoidCallback onTap;

  const InfoScreen({
    super.key, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, String>?;

    return Scaffold(
      body: InfoWidget(
        information:
            args?['information'] ?? '',
        description: args?['description'] ?? '',
        onTap: onTap
      ),
    );
  }
}

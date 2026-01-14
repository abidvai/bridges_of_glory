import 'package:bridges_of_glory/core/common_widgets/app_back_button.dart';
import 'package:bridges_of_glory/model/book_list_model.dart';
import 'package:bridges_of_glory/views/donation/library/controller/library_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../utils/constant/color.dart';

class ViewBookScreen extends StatelessWidget {
  final Datum bookListModel;

  ViewBookScreen({
    super.key,
    required this.bookListModel,
  });

  final LibraryController libraryController =
  Get.find<LibraryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Obx(() {
              final lang = libraryController.selectedLang.value;

              String? pdfUrl;
              if (lang == 'en') {
                pdfUrl = bookListModel.pdfs.en;
              } else if (lang == 'bn') {
                pdfUrl = bookListModel.pdfs.bn;
              }

              if (pdfUrl == null || pdfUrl.isEmpty) {
                return const Center(
                  child: Text('PDF not available'),
                );
              }

              return SfPdfViewer.network(
                pdfUrl,
                key: ValueKey(pdfUrl),
                controller: libraryController.pdfViewerController,
                initialZoomLevel: 1.2,
                onDocumentLoaded: (details) {
                  debugPrint(
                      'PDF Loaded: ${details.document.pages.count} pages');
                },
                onDocumentLoadFailed: (details) {
                  Get.snackbar('Error', 'Failed to load PDF');
                },
              );
            }),

            /// 🔙 Back Button
            Positioned(
              top: 20.h,
              left: 16.w,
              child: const AppBackButton(),
            ),

            Positioned(
              right: 16.w,
              top: 20.h,
              child: Container(
                width: 100.w,
                height: 32.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.border,
                    width: 1.2,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: Center(
                  child: Obx(() {
                    return DropdownButton<String>(
                      value: libraryController.selectedLang.value,
                      isExpanded: true,
                      underline: const SizedBox(),
                      dropdownColor: AppColors.blueish,
                      items: bookListModel.languages.map((lang) {
                        return DropdownMenuItem<String>(
                          value: lang,
                          child: Text(
                            _getLanguageName(lang),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        libraryController.selectedLang.value =
                        value!;
                        libraryController
                            .pdfViewerController
                            .firstPage();
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          libraryController.pdfViewerController.firstPage();
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}

String _getLanguageName(String code) {
  switch (code) {
    case 'en':
      return 'English';
    case 'bn':
      return 'Bangla';
    case 'hi':
      return 'Hindi';
    case 'es':
      return 'Spanish';
    default:
      return code.toUpperCase();
  }
}

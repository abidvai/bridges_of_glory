import 'package:bridges_of_glory/core/common_widgets/app_back_button.dart';
import 'package:bridges_of_glory/model/book_list_model.dart';
import 'package:bridges_of_glory/views/donation/library/controller/library_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../utils/constant/color.dart';

class ViewBookScreen extends StatelessWidget {
  final Book book;

  ViewBookScreen({
    super.key,
    required this.book,
  });

  final LibraryController libraryController =
  Get.find<LibraryController>();

  @override
  Widget build(BuildContext context) {
    // Remove duplicate languages
    final List<String> uniqueLanguages = book.languages.toSet().toList();

    // Ensure selected language exists in the list
    if (!uniqueLanguages.contains(libraryController.selectedLang.value)) {
      if (uniqueLanguages.isNotEmpty) {
        libraryController.selectedLang.value = uniqueLanguages.first;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Obx(() {
              final String selectedLang =
                  libraryController.selectedLang.value;

              // safe selected language
              final String safeLang = uniqueLanguages.contains(selectedLang)
                  ? selectedLang
                  : (uniqueLanguages.isNotEmpty ? uniqueLanguages.first : '');

              // get pdf dynamically
              String? pdfUrl = book.pdfs[safeLang];

              // fallback if selected language pdf not available
              pdfUrl ??= book.pdfs.isNotEmpty ? book.pdfs.values.first : null;

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
                    'PDF Loaded: ${details.document.pages.count} pages',
                  );
                },
                onDocumentLoadFailed: (details) {
                  Get.snackbar('Error', 'Failed to load PDF');
                },
              );
            }),

            Positioned(
              top: 20.h,
              left: 16.w,
              child: const AppBackButton(),
            ),

            Positioned(
              right: 16.w,
              top: 20.h,
              child: Container(
                width: 110.w,
                height: 34.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.border,
                    width: 1.2,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Center(
                  child: Obx(() {
                    final String safeLang =
                        libraryController.selectedLang.value;

                    return DropdownButton<String>(
                      value: safeLang,
                      isExpanded: true,
                      underline: const SizedBox(),
                      dropdownColor: AppColors.blueish,
                      items: uniqueLanguages.map((lang) {
                        return DropdownMenuItem<String>(
                          value: lang,
                          child: Text(
                            _getLanguageName(lang),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        libraryController.selectedLang.value = value;
                        libraryController.pdfViewerController.firstPage();
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
    case 'ar':
      return 'Arabic';
    default:
      return code.toUpperCase();
  }
}

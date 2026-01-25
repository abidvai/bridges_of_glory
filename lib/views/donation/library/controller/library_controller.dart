import 'package:bridges_of_glory/model/book_details_model.dart';
import 'package:bridges_of_glory/service/library/library_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/common_widgets/custom_toast.dart';
import '../../../../model/book_list_model.dart';

class LibraryController extends GetxController {
  RxString selectedLang = RxString('en');

  PdfViewerController pdfViewerController = PdfViewerController();

  final LibraryService _libraryService = LibraryService();
  RxBool isLoading = RxBool(false);
  RxList<Book> bookList = <Book>[].obs;
  Rxn<BookDetailsModel> bookDetails = Rxn<BookDetailsModel>(null);

  Future<void> fetchBook() async {
    isLoading.value = true;
    final response = await _libraryService.fetchBookList();

    if (response.data != null) {
      isLoading.value = false;
      bookList.assignAll(response.data!.data);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404.');
    }
  }

  Future<void> fetchBookPdf(int bookId, String lan) async {
    isLoading.value = true;
    final response = await _libraryService.fetchBookDetailsPdf(bookId, lan);

    if (response.data != null) {
      isLoading.value = false;
      bookDetails.value = response.data!;
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404.');
    }
  }



  @override
  void onInit() {
    fetchBook();
    super.onInit();
  }

  @override
  void onClose() {
    pdfViewerController.dispose();
    super.onClose();
  }
}

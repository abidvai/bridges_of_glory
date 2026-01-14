import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/donation/library/controller/library_controller.dart';
import 'package:bridges_of_glory/views/donation/library/view_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../gen/assets.gen.dart';

class LibraryScreen extends StatelessWidget {
  final bool? showAppBar;

  LibraryScreen({super.key, this.showAppBar});

  final LibraryController _libraryController = Get.put(LibraryController());

  Future<void> goToYt(String link) async {
    final Uri url = Uri.parse(link);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (showAppBar ?? false)
          ? AppTopBar(text: 'Library')
          : AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.surface,
              title: Text(
                'Library',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  goToYt('https://www.youtube.com/@walkingwitness3785');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'To join Our Podcast: ',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Assets.icons.youtube.svg(width: 50, height: 60),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Obx(() {
                if (_libraryController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.red),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.w,
                      mainAxisSpacing: 16.h,
                      mainAxisExtent: 258.h,
                      // childAspectRatio: 0.7,
                    ),
                    itemCount: _libraryController.bookList.length,
                    itemBuilder: (context, index) {
                      final book = _libraryController.bookList[index];
                      return LibraryCard(
                        image: book.cover,
                        title: book.name,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ViewBookScreen(bookListModel: book),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class LibraryCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const LibraryCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(12.r),
        elevation: 1,
        child: Container(
          width: 150.w,
          height: 250.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.surface,
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  image,
                  width: 134.w,
                  height: 210.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

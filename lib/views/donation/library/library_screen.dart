import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
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
                      'To join Our Podcast:',
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
                    padding: EdgeInsets.only(bottom: 50.h),
                    itemCount: _libraryController.bookList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 0.57, // tuned to avoid overflow
                    ),
                    itemBuilder: (context, index) {
                      final book = _libraryController.bookList[index];

                      return LibraryCard(
                        image: book.cover,
                        title: book.name,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ViewBookScreen(book: book),
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
        elevation: 1,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: AspectRatio(
                  aspectRatio: 0.8, // book cover ratio
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
              ),

              SizedBox(height: 6.h),

              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 3, // prevents overflow
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

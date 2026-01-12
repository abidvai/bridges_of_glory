import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bridges_of_glory/utils/constant/color.dart';

/// ===============================
/// IMAGE UPLOADER WIDGET
/// ===============================
class ImageUploaderVOne extends StatefulWidget {
  final double height;
  final String? defaultImage; // Local SVG asset
  final String? currentImage; // Remote image URL
  final bool enable;
  final bool loading;
  final bool showBorder;
  final void Function(File)? onImageSelected;
  final File? selectedImage;

  const ImageUploaderVOne({
    super.key,
    this.enable = true,
    this.defaultImage,
    this.currentImage,
    this.onImageSelected,
    this.height = 120,
    this.loading = false,
    this.showBorder = false,
    this.selectedImage,
  });

  @override
  State<ImageUploaderVOne> createState() => _ImageUploaderVOneState();
}

class _ImageUploaderVOneState extends State<ImageUploaderVOne> {
  File? _imageFile;         // Local picked image
  Uint8List? _imageData;    // Bytes of picked image

  /// Pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? file = await picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (file == null) return;

      final imgFile = File(file.path);
      final bytes = await imgFile.readAsBytes();

      setState(() {
        _imageFile = imgFile;
        _imageData = bytes;
      });

      widget.onImageSelected?.call(imgFile);
    } catch (e) {
      debugPrint('Image pick error: $e');
    }
  }

  /// Bottom sheet for camera/gallery selection
  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.blueish,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant ImageUploaderVOne oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedImage != null) {
      widget.selectedImage!.readAsBytes().then((bytes) {
        setState(() {
          _imageFile = widget.selectedImage;
          _imageData = bytes;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.height,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (!widget.enable || widget.loading) return;
              _showPickerOptions();
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffEFEEF9),
                border: widget.showBorder
                    ? Border.all(color: Colors.white, width: 3)
                    : null,
                borderRadius: BorderRadius.circular(widget.height / 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.height / 2),
                child: _buildImageWidget(),
              ),
            ),
          ),

          /// loading overlay
          if (widget.loading)
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.3),
                borderRadius: BorderRadius.circular(widget.height / 2),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ),

          /// edit icon
          if (widget.enable)
            Positioned(
              bottom: 4,
              right: 4,
              child: GestureDetector(
                onTap: () {
                  if (!widget.loading) _showPickerOptions();
                },
                child: Container(
                  width: widget.height * .28,
                  height: widget.height * .28,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: AppColors.red,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Returns the correct widget depending on what is available
  Widget _buildImageWidget() {
    // 1. Show picked local image
    if (_imageData != null) {
      return Image.memory(_imageData!, fit: BoxFit.cover);
    }

    // 2. Show remote image from URL (JPG/PNG)
    if (widget.currentImage != null && widget.currentImage!.isNotEmpty) {
      if (widget.currentImage!.endsWith('.svg')) {
        return SvgPicture.network(
          widget.currentImage!,
          fit: BoxFit.cover,
          placeholderBuilder: (_) => const Center(child: CircularProgressIndicator()),
          alignment: Alignment.center,
        );
      } else {
        return Image.network(
          widget.currentImage!,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.person, color: Colors.grey));
          },
        );
      }
    }

    // 3. Show default asset SVG
    if (widget.defaultImage != null && widget.defaultImage!.isNotEmpty) {
      return SvgPicture.asset(
        widget.defaultImage!,
        fit: BoxFit.cover,
        width: widget.height * .6,
        height: widget.height * .6,
        color: Colors.grey,
        alignment: Alignment.center,
        placeholderBuilder: (_) => const Center(child: CircularProgressIndicator()),
      );
    }

    // 4. Fallback icon
    return const Center(
      child: Icon(
        Icons.person,
        size: 40,
        color: Colors.grey,
      ),
    );
  }
}

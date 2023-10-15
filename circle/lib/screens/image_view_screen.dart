import 'package:circle/configs/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewScreen extends StatelessWidget {
  final String? image;
  const ImageViewScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.background,
        elevation: 0,
      ),
      body: Center(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(
            color: CustomColors.background,
          ),
          imageProvider: NetworkImage(image!),
        ),
      ),
    );
  }
}

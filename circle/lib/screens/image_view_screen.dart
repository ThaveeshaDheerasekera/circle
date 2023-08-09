import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  final String? image;
  const ImageViewScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: double.infinity,
          child: Image.network(
            image!,
          ),
        ),
      ),
    );
  }
}

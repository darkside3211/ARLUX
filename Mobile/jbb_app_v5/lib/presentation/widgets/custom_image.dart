import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

abstract class CustomImage {}

class CustomSingleImage extends StatelessWidget implements CustomImage {
  final String image;
  final bool isNetwork;
  final bool isFile;
  final bool disableGestures;
  final double aspectRatio;

  const CustomSingleImage({
    super.key,
    required this.image,
    required this.disableGestures,
    required this.aspectRatio,
    this.isNetwork = false,
    this.isFile = false,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: PhotoView(
        enablePanAlways: true,
        enableRotation: false,
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2,
        strictScale: true,
        imageProvider: isNetwork
            ? NetworkImage(image)
            : isFile
                ? FileImage(File(image))
                : AssetImage(image),
        disableGestures: disableGestures,
        loadingBuilder: (context, event) => const Center(
            child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(color: AppColors.yellow))),
        tightMode: true,
      ),
    );
  }
}

class CustomGalleryImage extends StatefulWidget {
  final List<String> imageItems;
  final double aspectRatio;
  final bool isNetwork;

  const CustomGalleryImage({
    super.key,
    required this.imageItems,
    required this.isNetwork,
    required this.aspectRatio,
  });

  @override
  State<CustomGalleryImage> createState() => _CustomGalleryImageState();
}

class _CustomGalleryImageState extends State<CustomGalleryImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.imageItems.isNotEmpty) {
      return AspectRatio(
        aspectRatio: 1 / 1,
        child: PhotoViewGallery.builder(
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          enableRotation: false,
          itemCount: widget.imageItems.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: widget.isNetwork
                  ? NetworkImage(widget.imageItems[index])
                  : AssetImage('assets/images/${widget.imageItems[index]}'),
              initialScale: PhotoViewComputedScale.contained,
            );
          },
          loadingBuilder: (context, event) {
            return const Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      );
    } else {
      return const Center(
        child: Column(
          children: [
            Icon(Icons.sim_card_alert),
            Text('No Images to Show'),
          ],
        ),
      );
    }
  }
}

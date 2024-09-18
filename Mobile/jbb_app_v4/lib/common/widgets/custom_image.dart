import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

abstract class CustomImage {}

class CustomImageSingle extends StatelessWidget implements CustomImage {
  final String image;
  final bool disableGestures;
  const CustomImageSingle({super.key, required this.image, this.disableGestures = true});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: PhotoView(
        imageProvider: AssetImage('assets/images/$image'),
        disableGestures: disableGestures,
        loadingBuilder: (context, event) => const CircularProgressIndicator(),
        tightMode: true,
      ),
    );
  }
}

class CustomImageGallery extends StatefulWidget implements CustomImage {
  final List<String> imageItems;
  const CustomImageGallery({super.key, required this.imageItems});

  @override
  State<CustomImageGallery> createState() => _CustomImageGalleryState();
}

class _CustomImageGalleryState extends State<CustomImageGallery> {
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
              imageProvider: AssetImage('assets/images/${widget.imageItems[index]}'),
              initialScale: PhotoViewComputedScale.contained,
            );
          },
          loadingBuilder: (context, event) {
            return const Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      );
    } else {
      return const Center(
        child: Icon(Icons.sim_card_alert),
      );
    }
  }
}
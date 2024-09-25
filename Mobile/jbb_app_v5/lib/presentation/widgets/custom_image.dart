import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

abstract class CustomImage {}

class CustomSingleImage extends StatelessWidget implements CustomImage {
  final String image;
  final bool isNetwork;
  final bool disableGestures;
  final double aspectRatio;

  const CustomSingleImage({
    super.key,
    required this.image,
    required this.disableGestures,
    required this.aspectRatio,
    required this.isNetwork,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: PhotoView(
        imageProvider: isNetwork
            ? NetworkImage(image)
            : AssetImage('assets/images/$image'),
        disableGestures: disableGestures,
        loadingBuilder: (context, event) =>
            const CircularProgressIndicator(color: Colors.amber),
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

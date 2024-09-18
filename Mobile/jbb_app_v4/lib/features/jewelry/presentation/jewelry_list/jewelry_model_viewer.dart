import 'package:flutter/material.dart';
import 'package:jbb_app_v4/common/widgets/custom_image.dart';
import 'package:o3d/o3d.dart';

class JewelryModelViewer extends StatefulWidget {
  final String modelUrl;
  final List<String> imageUrls;

  const JewelryModelViewer(
      {super.key, required this.modelUrl, required this.imageUrls});

  @override
  State<JewelryModelViewer> createState() => _JewelryModelViewerState();
}

class _JewelryModelViewerState extends State<JewelryModelViewer> {
  bool isModelView = false;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          isModelView
              ? buildModelView()
              : CustomImageGallery(imageItems: widget.imageUrls),
          Positioned(
            bottom: 8,
            right: 8,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isModelView = !isModelView;
                });
              },
              label: isModelView ? const Text('Show Images') : const Text('Show in 3D'),
              icon: isModelView
                  ? const Icon(Icons.image_outlined)
                  : const Icon(Icons.view_in_ar),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }

  O3D buildModelView() {
    return O3D.asset(
      src: widget.modelUrl,
      disablePan: true,
      cameraTarget: CameraTarget(0, 0, 0),
      cameraOrbit: CameraOrbit(0, 75, 1000),
      orientation: '0deg 90deg 0deg',
      alt: 'Jewelry 3D model',
      backgroundColor: Colors.amber.shade50,
    );
  }
}

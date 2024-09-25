import 'package:flutter/material.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_image.dart';
import 'package:o3d/o3d.dart';

class ProductViewer extends StatefulWidget {
  final bool isNetwork;
  final String? modelUrl;
  final List<String> imageUrls;

  const ProductViewer({super.key, this.modelUrl, required this.imageUrls, required this.isNetwork});

  @override
  State<ProductViewer> createState() => _ProductViewerState();
}

class _ProductViewerState extends State<ProductViewer> {
  bool isModelView = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          isModelView
              ? _buildModelView()
              : CustomGalleryImage(
                  imageItems: widget.imageUrls,
                  isNetwork: widget.isNetwork,
                  aspectRatio: 1 / 1,
                ),
          Positioned(
            bottom: 8,
            right: 8,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  if (widget.modelUrl != null || widget.modelUrl!.isNotEmpty) {
                    isModelView = !isModelView;
                  }
                });
              },
              label: isModelView
                  ? const Text('Show Images')
                  : const Text('Show in 3D'),
              icon: isModelView
                  ? const Icon(Icons.image_outlined)
                  : const Icon(Icons.view_in_ar),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, foregroundColor: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }

  O3D _buildModelView() {
    return O3D.asset(
      src: widget.isNetwork ? widget.modelUrl! : 'assets/models/${widget.modelUrl}',
      disablePan: true,
      cameraTarget: CameraTarget(0, 0, 0),
      cameraOrbit: CameraOrbit(0, 75, 1000),
      orientation: '0deg 90deg 0deg',
      alt: 'Jewelry 3D model',
      backgroundColor: Colors.amber.shade50,
    );
  }
}

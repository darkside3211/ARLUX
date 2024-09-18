import 'package:flutter/material.dart';
import 'package:jbb_app_v3/features/products/domain/product_model.dart';
import 'package:jbb_app_v3/features/products/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v3/features/products/presentation/widgets/component_builders.dart';
import 'package:o3d/o3d.dart';
import 'package:photo_view/photo_view.dart';

class ProductViewer {
  final ProductModel productModel;
  final AppBars appBars = AppBars();

  ProductViewer({
    required this.productModel,
  });

  Widget showImage(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: _buildPhotoView(context),
            );
          },
        );
      },
      child: Hero(
        tag: productModel.id,
        child: Image.asset(
          "assets${productModel.imageUrl}",
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }

  PhotoView _buildPhotoView(BuildContext context) {
    return PhotoView(
      basePosition: const Alignment(0, 0),
      strictScale: true,
      initialScale: PhotoViewComputedScale.contained * 0.9,
      maxScale: PhotoViewComputedScale.covered * 5,
      minScale: PhotoViewComputedScale.contained * 0.9,
      backgroundDecoration: const BoxDecoration(color: Colors.transparent),
      customSize: MediaQuery.of(context).size,
      imageProvider: AssetImage("assets${productModel.imageUrl}"),
      heroAttributes: PhotoViewHeroAttributes(tag: productModel.id),
    );
  }

  O3D buildModelView() {
    return O3D.network(
      src: "assets/models/heart_ring.glb",
      disablePan: true,
      cameraTarget: CameraTarget(0, 0, 0),
      cameraOrbit: CameraOrbit(0, 75, 1000),
      orientation: '0deg 90deg 0deg',
      alt: 'Diamond Moissanite Engagement Ring',
      backgroundColor: Colors.amber.shade50,
    );
  }

  Widget buildModelViewWithControllers(BuildContext context) {
    final O3DController modelController = O3DController();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            O3D.network(
              controller: modelController,
              src: "assets/models/heart_ring.glb",
              disablePan: true,
              cameraTarget: CameraTarget(0, 0, 0),
              cameraOrbit: CameraOrbit(0, 75, 1000),
              orientation: '0deg 90deg 0deg',
              alt: 'Diamond Moissanite Engagement Ring',
              backgroundColor: Colors.amber.shade50,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: appBars.appBarWishCart(context, title: productModel.name),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  priceBuild(productModel.price),
                  style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton.filled(
            onPressed: () {},
            iconSize: 30,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey[850]),
            ),
            icon: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 8),
          IconButton.filled(
            onPressed: () {
              modelController.cameraTarget(0, 0, 0);
              modelController.cameraOrbit(0, 75, 1000);
            },
            iconSize: 30,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey[850]),
            ),
            icon: const Icon(
              Icons.restart_alt_outlined,
              color: Colors.amber,
            ),
          ),
        ],
      ),
      bottomNavigationBar: appBars.bottomBuyCartBar(),
    );
  }
}

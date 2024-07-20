import 'package:camerakit_flutter/camerakit_flutter.dart';
import 'package:camerakit_flutter/lens_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jbb_application/components/constants.dart';
import 'try_on_result.dart';
import 'product_detail_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:o3d/o3d.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    implements CameraKitFlutterEvents {
  static const double fabHeightClosed = 256;
  double fabHeight = fabHeightClosed;

  final panelController = PanelController();
  final modelController = O3DController();

  late String _filePath = '';
  late String _fileType = '';
  late final CameraKitFlutterImpl cameraKitFlutterImpl =
      CameraKitFlutterImpl(cameraKitFlutterEvents: this);

  @override
  void initState() {
    super.initState();

    cameraKitFlutterImpl.setCredentials(apiToken: Constants.snapApiKey);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initCameraKit() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      await cameraKitFlutterImpl.openCameraKitWithSingleLens(
          lensId: '6b13b1ba-d977-4a99-b57d-d3ca8f86d2f2',
          groupId: '7aeb2993-bfe1-4e83-a359-f9be18206dbc');
    } on PlatformException {
      if (kDebugMode) {
        print("Failed to open camera kit");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.26;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.6;

    return Scaffold(
      body: SafeArea(
        child: Stack(alignment: Alignment.topCenter, children: [
          //Details Panel
          SlidingUpPanel(
            controller: panelController,
            maxHeight: panelHeightOpened,
            minHeight: panelHeightClosed,
            body: ModelInspection(modelController: modelController),
            panelBuilder: (controller) => ProductDetailPanel(
              controller: controller,
              panelController: panelController,
            ),
            parallaxEnabled: true,
            parallaxOffset: 0.6,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            onPanelSlide: (position) => setState(() {
              final panelMaxScrollExtent =
                  panelHeightOpened - panelHeightClosed;
              fabHeight = position * panelMaxScrollExtent + fabHeightClosed;
              modelController.cameraTarget(0, -1, 0);
              modelController.cameraOrbit(0, 75, 1000);
            }),
          ),
          Positioned(
            right: 20,
            bottom: fabHeight,
            child: Column(
              children: [
                buildModelControlsFAB(context),
                const SizedBox(
                  height: 8,
                ),
                buildCameraKitFAB(context)
              ],
            ),
          ),
          //App Bar
          Positioned(
            top: 0.0,
            right: 0.0,
            left: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.shopping_bag))
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: const BottomMenuBar(),
    );
  }

  Widget buildModelControlsFAB(BuildContext context) => FloatingActionButton(
        onPressed: () {
          setState(() {
            modelController.cameraTarget(0, -1, 0);
            modelController.cameraOrbit(0, 75, 1000);
          });
        },
        backgroundColor: const Color(0xff292929),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
        foregroundColor: Colors.amber,
        child: const Icon(Icons.replay_outlined),
      );

  Widget buildCameraKitFAB(BuildContext context) => FloatingActionButton(
        onPressed: () {
          initCameraKit();
        },
        backgroundColor: const Color(0xff292929),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
        foregroundColor: Colors.amber,
        child: const Icon(Icons.camera_outlined),
      );

  @override
  void onCameraKitResult(Map result) {
    _filePath = result["path"] as String;
    _fileType = result["type"] as String;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TryOnResult(
              filePath: _filePath,
              fileType: _fileType,
            )));
  }

  @override
  void receivedLenses(List<Lens> lensList) {}
}

class BottomMenuBar extends StatelessWidget {
  const BottomMenuBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.amber, width: 2.0))),
      child: BottomAppBar(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(onPressed: () {}, icon: const Icon(Icons.help)),
              IconButton(
                icon: const Icon(Icons.chat),
                onPressed: () {
                  // Handle chat icon button press
                },
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle Buy Now button press
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: const Color(0xff292929)),
                    child: const Text('Buy Now'),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Add to Cart button press
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class ModelInspection extends StatelessWidget {
  final O3DController modelController;

  const ModelInspection({
    super.key,
    required this.modelController,
  });

  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return O3D.asset(
      src: 'assets/models/diamond_heart_ring.glb',
      controller: modelController,
      disablePan: true,
      cameraTarget: CameraTarget(0, -1, 0),
      cameraOrbit: CameraOrbit(0, 75, 1000),
      orientation: '0deg 90deg 0deg',
      alt: 'Diamond Moissanite Engagement Ring',
      progressBarColor: Colors.amber,
      backgroundColor: Colors.amber.shade50,
    );
  }
}

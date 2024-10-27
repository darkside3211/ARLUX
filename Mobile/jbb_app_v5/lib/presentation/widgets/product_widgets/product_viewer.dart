import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/presentation/pages/try_on/try_on_screen.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_image.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/gmodel_view.dart';

class ProductViewer extends ConsumerStatefulWidget {
  final bool isNetwork;
  final String? modelUrl;
  final String lensID;
  final String groupID;
  final List<String> imageUrls;

  const ProductViewer({
    super.key,
    required this.modelUrl,
    required this.imageUrls,
    required this.isNetwork,
    this.lensID = '',
    this.groupID = '',
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductViewerState();
}

class _ProductViewerState extends ConsumerState<ProductViewer>
    with SingleTickerProviderStateMixin {
  bool isModelView = false;
  bool canTryOn = false;
  bool showSettings = true;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    if (widget.lensID.isNotEmpty) {
      canTryOn = true;
    }

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          isModelView
              ? GmodelView(modelUrl: widget.modelUrl!)
              : InkWell(
                  onTap: () {
                    showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (context) {
                        return Center(
                          child: CustomGalleryImage(
                              imageItems: widget.imageUrls,
                              isNetwork: true,
                              aspectRatio: 9 / 16),
                        );
                      },
                    );
                  },
                  child: CustomGalleryImage(
                    imageItems: widget.imageUrls,
                    isNetwork: widget.isNetwork,
                    aspectRatio: 1 / 1,
                  ),
                ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (widget.modelUrl != null)
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: RotationTransition(
                      turns: _animationController,
                      child: IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: AppColors.yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            showSettings = !showSettings;

                            if (showSettings) {
                              _animationController.forward();
                            } else {
                              _animationController.reverse();
                            }
                          });
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                // AnimatedSwitcher for Try it virtually button
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0), // Enter from right
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: showSettings && isModelView && canTryOn
                      ? ElevatedButton.icon(
                          key: const ValueKey(
                              'tryOnButton'), // Unique key for switching
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TryOnScreen(
                                    lensID: widget.lensID,
                                    groupID: widget.groupID),
                              ),
                            );
                          },
                          label: const Text('Try it virtually!'),
                          icon: const Icon(Icons.camera_enhance),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: AppColors.yellow,
                          ),
                        )
                      : const SizedBox(), // Empty widget when not showing
                ),
                const SizedBox(height: 8),
                // AnimatedSwitcher for Show Images / Show in 3D button
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0), // Enter from right
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: showSettings
                      ? ElevatedButton.icon(
                          key: const ValueKey(
                              'toggleViewButton'), // Unique key for switching
                          onPressed: () {
                            setState(() {
                              if (widget.modelUrl != null ||
                                  widget.modelUrl!.isNotEmpty) {
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
                              backgroundColor: Colors.black,
                              foregroundColor: AppColors.yellow),
                        )
                      : const SizedBox(), // Empty widget when not showing
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

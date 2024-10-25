import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/features/3d_model/gmodel_repository.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class GmodelView extends ConsumerWidget {
  final String modelUrl;
  final Color? backgroundColor;
  final int? autoRotateDelay;
  const GmodelView({super.key, required this.modelUrl, this.backgroundColor, this.autoRotateDelay});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(downloadModelProvider(url: modelUrl));
    return path.when(
      data: (data) {
        if (data != null) {
          return ModelViewer(
            src: 'file://$data',
            alt: 'Jewelry 3D model',
            backgroundColor: backgroundColor ?? AppColors.black,
            cameraControls: true,
            autoRotate: true,
            autoRotateDelay: autoRotateDelay ?? 3000,
            shadowIntensity: 1,
            exposure: 2,
          );
        } else {
          return const IconedFailure(
            message: 'Download Failed.',
            displayIcon: Icon(Icons.error),
          );
        }
      },
      error: (err, stack) {
        return IconedFailure(
          message: err.toString(),
          displayIcon: const Icon(Icons.error),
        );
      },
      loading: () => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.amber,
            ),
            Text('Model loading...'),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_image.dart';

class TryOnResult extends ConsumerStatefulWidget {
  final String path;
  final String type;
  const TryOnResult({
    super.key,
    required this.path,
    required this.type,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TryOnResultState();
}

class _TryOnResultState extends ConsumerState<TryOnResult> {
  late CachedVideoPlayerPlusController videoController;

  @override
  void initState() {
    super.initState();
    videoController = CachedVideoPlayerPlusController.file(File(widget.path))
      ..initialize().then((value) async {
        videoController.setLooping(true);
        videoController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            widget.type == "image"
                ? CustomSingleImage(
                    image: widget.path,
                    disableGestures: false,
                    aspectRatio: 9 / 16,
                    isNetwork: false,
                    isFile: true,
                  )
                : InkWell(
                    onTap: () => setState(() {
                      videoController.value.isPlaying
                          ? videoController.pause()
                          : videoController.play();
                    }),
                    child: Center(
                      child: videoController.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: videoController.value.aspectRatio,
                              child: CachedVideoPlayerPlus(videoController),
                            )
                          : const CircularProgressIndicator(
                              color: AppColors.yellow),
                    ),
                  ),
            Positioned(
              top: 8.0,
              left: 8.0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton.filled(
            onPressed: () {},
            iconSize: 32,
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.yellow)),
            icon: const Icon(Icons.save_alt),
          ),
          gapH16,
          FloatingActionButton(
            backgroundColor: AppColors.yellow,
            onPressed: () {
              setState(() {
                videoController.value.isPlaying
                    ? videoController.pause()
                    : videoController.play();
              });
            },
            child: Icon(
              videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

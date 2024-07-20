import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TryOnResult extends StatefulWidget {
  final String filePath;
  final String fileType;

  const TryOnResult(
      {super.key, required this.filePath, required this.fileType});

  @override
  State<TryOnResult> createState() => _CameraResultWidgetState();
}

class _CameraResultWidgetState extends State<TryOnResult> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.isInitialized &&
          (_controller.value.duration == _controller.value.position)) {
        setState(() {
          if (kDebugMode) {
            print("video done :>");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('CameraKit Result'),
    //     ),
    //     floatingActionButton: widget.filePath.isNotEmpty &&
    //             widget.fileType == "video"
    //         ? FloatingActionButton(
    //             onPressed: () {
    //               setState(() {
    //                 _controller.value.isPlaying
    //                     ? _controller.pause()
    //                     : _controller.play();
    //               });
    //             },
    //             child: Icon(
    //               _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //             ),
    //           )
    //         : Container(),
    //     body: widget.filePath.isNotEmpty
    //         ? widget.fileType == 'video'
    //             ? Center(
    //                 child: AspectRatio(
    //                   aspectRatio: _controller.value.aspectRatio,
    //                   child: VideoPlayer(_controller),
    //                 ),
    //               )
    //             : widget.fileType == 'image'
    //                 ? Center(child: Image.file(File(widget.filePath)))
    //                 : const Text("UnKnown File to show")
    //         : const Text("No File to show"));
  }
}

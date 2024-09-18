import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductViewer extends ConsumerStatefulWidget {
  final int id;
  final String image;
  final Map<String, String>? lensGroup;
  final String? modelUrl;
  final List<String>? imageList;
  const ProductViewer({
    super.key,
    required this.id,
    required this.image,
    this.imageList,
    this.lensGroup,
    this.modelUrl,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductViewerState();
}

class _ProductViewerState extends ConsumerState<ProductViewer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 64, bottom: 256),
      child: Center(
        child: Hero(
          tag: widget.id,
          child: Image.network(
            widget.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/review/data/review_repository.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';

class RatingBottomSheet extends ConsumerStatefulWidget {
  final String productId;
  const RatingBottomSheet({super.key, required this.productId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RatingBottomSheetState();
}

class _RatingBottomSheetState extends ConsumerState<RatingBottomSheet> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();
  List<XFile> _images = [];
  int _rating = 0;

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles =
        await _picker.pickMultiImage(imageQuality: 80, limit: 3);

    if (pickedFiles.isNotEmpty) {
      setState(() {
        _images = pickedFiles;
      });
    }
  }

  void _submitReview(BuildContext context) async {
    if (_rating > 0) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      );

      final isReview = await ref.read(addReviewProvider(
        description: _descriptionController.text,
        rating: _rating,
        images: _images,
        productID: widget.productId,
      ).future);

      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        if (isReview) {
          SnackBarFailure(context, message: 'Review Successfully added');
          Navigator.of(context).pop();
        } else {
          SnackBarFailure(context, message: 'An error occured');
          Navigator.of(context).pop();
        }
      }
    } else {
      Navigator.of(context).pop();
      SnackBarFailure(context, message: 'Please provide rating');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add a Review ($_rating)",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            gapH16,
            // Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    color: index < _rating ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            // Description
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.yellow,
                )),
              ),
              maxLines: 3,
            ),
            gapH16,
            // Image Picker
            ElevatedButton.icon(
              onPressed: _pickImages,
              icon: const Icon(Icons.add_photo_alternate),
              label: const Text("Add Images"),
            ),
            gapH8,
            // Image Preview Thumbnails
            if (_images.isNotEmpty)
              Wrap(
                spacing: 8.0,
                children: _images.map((image) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(image.path),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            gapH16,
            // Submit Button
            ElevatedButton(
              onPressed: () {
                _submitReview(context);
              },
              child: const Text("Submit Review"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/utils/formats.dart';
import 'package:jbb_app_v5/features/review/data/review_repository.dart';
import 'package:jbb_app_v5/features/review/model/review_model.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_image.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_widget.dart';

class ReviewTile extends ConsumerWidget {
  final ReviewModel review;
  final bool canEdit;
  const ReviewTile({super.key, required this.review, this.canEdit = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              review.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            ProductRatingBuilder(rating: double.parse(review.rating)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatDate(review.updatedAt)),
            Text(review.description),
            if (review.mediaUrls.isNotEmpty)
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: review.mediaUrls.map((url) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return Center(
                            child: CustomGalleryImage(
                                imageItems: review.mediaUrls,
                                isNetwork: true,
                                aspectRatio: 9 / 16),
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(url,
                          width: 60, // Thumbnail width
                          height: 60, // Thumbnail height
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        );
                      }),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
        trailing: canEdit
            ? IconButton(
                onPressed: () async {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    ),
                  );

                  final isDeleted = await ref.read(
                      removeReviewProvider(reviewID: review.reviewID).future);

                  if (context.mounted) {
                    Navigator.of(context, rootNavigator: true).pop();
                    // ignore: unused_result
                    ref.refresh(
                        getReviewsProvider(productId: review.productId));
                    if (isDeleted) {
                      SnackBarFailure(context,
                          message: 'Your review is removedd successfully');
                    } else {
                      SnackBarFailure(context, message: 'An error occured');
                    }
                  }
                },
                icon: const Icon(Icons.delete_outline),
              )
            : null,
        dense: true,
        isThreeLine: true,
      ),
    );
  }
}

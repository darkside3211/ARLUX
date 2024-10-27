import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/review/data/review_repository.dart';
import 'package:jbb_app_v5/presentation/pages/rating/review_tile.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';

class ReviewList extends ConsumerStatefulWidget {
  final bool isScrollable;
  final String productID;
  const ReviewList(
      {super.key, this.isScrollable = false, required this.productID});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewListState();
}

class _ReviewListState extends ConsumerState<ReviewList> {
  @override
  Widget build(BuildContext context) {
    final reviews = ref.watch(getReviewsProvider(productId: widget.productID));
    final userInfo = ref.watch(getUserInfoProvider);

    return reviews.when(
      data: (data) {
        if (data.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: widget.isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              bool canEdit = false;
              userInfo.whenData(
                (value) {
                  canEdit = value.firebaseUid == data[index].userId;
                },
              );
              return ReviewTile(
                review: data[index],
                canEdit: canEdit,
              );
            },
          );
        } else {
          return const IconedFailure(
              message: 'No reviews yet',
              displayIcon: Icon(Icons.rate_review_outlined));
        }
      },
      error: (err, stack) => IconedFailure(
          message: err.toString(), displayIcon: const Icon(Icons.error)),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.amber,
        ),
      ),
    );
  }
}

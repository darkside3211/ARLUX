import 'package:dio/dio.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/review/model/review_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_repository.g.dart';

class ReviewRepository {
  final Dio dio = DioInstance().getDioInstance();

  Future<bool> addReview({
    required String productID,
    required String description,
    required int rating,
    required String mediaUrl,
    required String? token,
  }) async {
    try {
      final result = await dio.request(
        '/reviews',
        data: {
          'productId': productID,
          'description': description,
          'rating': rating,
          'mediaUrl': mediaUrl,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: 'POST',
        ),
      );
      if (result.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ReviewModel>> getReviews({required String productID}) async {
    try {
      final result = await dio.request(
        '/reviews',
        data: {
          'productId': productID,
        },
        options: Options(
          method: 'GET',
        ),
      );
      if (result.statusCode == 200) {
        final json = result.data as List<dynamic>;

        List<ReviewModel> jewelries =
            json.map((item) => ReviewModel.fromJson(item)).toList();

        return jewelries;
      } else {
        return List.empty();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

@riverpod
ReviewRepository reviewRepository(ReviewRepositoryRef ref) {
  return ReviewRepository();
}

@riverpod
Future<bool> addReview(
  AddReviewRef ref, {
  required String productID,
  required String description,
  required int rating,
  required String mediaUrl,
}) async {
  final reviewRepository = ref.watch(reviewRepositoryProvider);
  final String? token = await ref.watch(getFirebaseTokenProvider.future);

  bool result = await reviewRepository.addReview(
    productID: productID,
    description: description,
    rating: rating,
    mediaUrl: mediaUrl,
    token: token,
  );

  if (result) {
    // ignore: unused_result
    //ref.refresh(getBagItemsProvider);
  }

  return result;
}

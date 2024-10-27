import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
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
    required List<XFile> images,
    required String? token,
  }) async {
    try {
      final FormData formData = FormData.fromMap({
        'productId': productID,
        'description': description,
        'rating': rating,
        'files': images
            .map((image) => MultipartFile.fromFileSync(image.path,
                contentType: DioMediaType.parse("image/jpeg")))
            .toList(),
      });

      final result = await dio.request(
        '/reviews',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
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
        '/reviews/$productID',
        options: Options(
          method: 'GET',
        ),
      );
      if (result.statusCode == 200) {
        final json = result.data as List<dynamic>;

        List<ReviewModel> reviews =
            json.map((item) => ReviewModel.fromJson(item)).toList();

        return reviews;
      } else {
        return List.empty();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> removeReview(
      {required String reviewID, required String? token}) async {
    try {
      final result = await dio.request(
        '/reviews/$reviewID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          method: 'DELETE',
        ),
      );
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
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
  required List<XFile> images,
}) async {
  final reviewRepository = ref.watch(reviewRepositoryProvider);
  final String? token = await ref.watch(getFirebaseTokenProvider.future);

  bool result = await reviewRepository.addReview(
    productID: productID,
    description: description,
    rating: rating,
    images: images,
    token: token,
  );

  if (result) {
    // ignore: unused_result
    ref.refresh(getUserInfoProvider);
  }

  return result;
}

@riverpod
Future<List<ReviewModel>> getReviews(GetReviewsRef ref,
    {required String productId}) {
  final reviewRepository = ref.watch(reviewRepositoryProvider);
  return reviewRepository.getReviews(productID: productId);
}

@riverpod
Future<bool> removeReview(RemoveReviewRef ref,
    {required String reviewID}) async {
  final reviewRepository = ref.watch(reviewRepositoryProvider);
  final String? token = await ref.watch(getFirebaseTokenProvider.future);

  final result =
      await reviewRepository.removeReview(reviewID: reviewID, token: token);

  if (result) {
    // ignore: unused_result
    ref.refresh(getUserInfoProvider);
  }

  return result;
}

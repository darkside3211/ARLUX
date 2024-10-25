import 'dart:io';

import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'gmodel_repository.g.dart';

class GmodelRepository {
  final Dio dio = DioInstance().getDioInstance();

  Future<String?> downloadModel(
      {required String url, required String filename}) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/$filename';

      final file = File(filePath);
      if (await file.exists()) {
        return filePath;
      }

      await dio.download(url, filePath);
      return filePath;
    } catch (e) {
      ToastFailure(message: 'Error downloading model: $e');
      return null;
    }
  }

  String extractFileName({required String url}) {
    Uri uri = Uri.parse(url);
    String filename = uri.pathSegments.last;
    return Uri.decodeComponent(filename);
  }
}

@riverpod
GmodelRepository gmodelRepository(GmodelRepositoryRef ref) {
  return GmodelRepository();
}

@riverpod
Future<String?> downloadModel(DownloadModelRef ref,
    {required String url}) async {
  final gmodelRef = ref.watch(gmodelRepositoryProvider);

  final fileName = gmodelRef.extractFileName(url: url);

  return await gmodelRef.downloadModel(url: url, filename: fileName);
}

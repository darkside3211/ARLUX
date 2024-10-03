import 'package:camerakit_flutter/camerakit_flutter.dart';
import 'package:camerakit_flutter/lens_model.dart';
import 'package:flutter/material.dart';
import 'package:jbb_app_v5/core/constants/lens_config.dart';
import 'package:jbb_app_v5/presentation/pages/try_on/try_on_result.dart';

class TryOnScreen extends StatefulWidget {
  final String lensID;
  final String groupID;
  const TryOnScreen({
    super.key,
    required this.lensID,
    required this.groupID,
  });

  @override
  State<TryOnScreen> createState() => _TryOnScreenState();
}

class _TryOnScreenState extends State<TryOnScreen>
    implements CameraKitFlutterEvents {
  late String _filePath = '';
  late String _fileType = '';

  late final _cameraKitImpl =
      CameraKitFlutterImpl(cameraKitFlutterEvents: this);

  @override
  void initState() {
    super.initState();
    _cameraKitImpl.setCredentials(apiToken: LensConfig.cameraKitApiToken);
  }

  void showCamera() {
    _cameraKitImpl.openCameraKitWithSingleLens(
        lensId: widget.lensID,
        groupId: widget.groupID,
        isHideCloseButton: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Tutorial here...'),
              ElevatedButton(
                onPressed: () {
                  showCamera();
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onCameraKitResult(Map result) {
    setState(() {
      _filePath = result["path"] as String;
      _fileType = result["type"] as String;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TryOnResult(path: _filePath, type: _fileType),
        ),
      );
    });
  }

  @override
  void receivedLenses(List<Lens> lensList) {}
}

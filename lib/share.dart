import 'src/share_platform_interface.dart';

class Share {
  Future<String?> getPlatformVersion() {
    return SharePlatform.instance.getPlatformVersion();
  }

  Future<void> shareString(String stringToShare) async {
    await SharePlatform.instance.shareString(stringToShare);
  }

  Future<void> shareImage(String imagePath) async {
    await SharePlatform.instance.shareImage(imagePath);
  }
}

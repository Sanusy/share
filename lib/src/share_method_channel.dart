import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'share_platform_interface.dart';

/// An implementation of [SharePlatform] that uses method channels.
class MethodChannelShare extends SharePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('share');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> shareString(String stringToShare) async {
    await methodChannel.invokeMethod<String>('shareString', stringToShare);
  }

  @override
  Future<void> shareImage(String imagePath) async {
    await methodChannel.invokeMethod<String>('shareImage', imagePath);
  }
}

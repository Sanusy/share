import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'share_method_channel.dart';

abstract class SharePlatform extends PlatformInterface {
  /// Constructs a SharePlatform.
  SharePlatform() : super(token: _token);

  static final Object _token = Object();

  static SharePlatform _instance = MethodChannelShare();

  /// The default instance of [SharePlatform] to use.
  ///
  /// Defaults to [MethodChannelShare].
  static SharePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SharePlatform] when
  /// they register themselves.
  static set instance(SharePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() async {
    return await _instance.getPlatformVersion();
  }

  Future<void> shareString(String stringToShare) async {
    await _instance.shareString(stringToShare);
  }

  Future<void> shareImage(String imagePath) async {
    await _instance.shareImage(imagePath);
  }
}

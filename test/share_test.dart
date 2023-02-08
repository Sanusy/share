import 'package:flutter_test/flutter_test.dart';
import 'package:share/share.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:share/src/share_method_channel.dart';
import 'package:share/src/share_platform_interface.dart';

class MockSharePlatform
    with MockPlatformInterfaceMixin
    implements SharePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> shareImage(String imagePath) {
    // TODO: implement shareImage
    throw UnimplementedError();
  }

  @override
  Future<void> shareString(String stringToShare) {
    // TODO: implement shareString
    throw UnimplementedError();
  }
}

void main() {
  final SharePlatform initialPlatform = SharePlatform.instance;

  test('$MethodChannelShare is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelShare>());
  });

  test('getPlatformVersion', () async {
    Share sharePlugin = Share();
    MockSharePlatform fakePlatform = MockSharePlatform();
    SharePlatform.instance = fakePlatform;

    expect(await sharePlugin.getPlatformVersion(), '42');
  });
}

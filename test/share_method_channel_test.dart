import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share/src/share_method_channel.dart';

void main() {
  MethodChannelShare platform = MethodChannelShare();
  const MethodChannel channel = MethodChannel('share');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_content_provider/flutter_content_provider_platform_interface.dart';
import 'package:flutter_content_provider/flutter_content_provider_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterContentProviderPlatform with MockPlatformInterfaceMixin implements FlutterContentProviderPlatform {
  @override
  Future<void> delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> insert({required String key, required String value}) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<String?> query(String key) {
    // TODO: implement query
    throw UnimplementedError();
  }
}

void main() {
  final FlutterContentProviderPlatform initialPlatform = FlutterContentProviderPlatform.instance;

  test('$MethodChannelFlutterContentProvider is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterContentProvider>());
  });
}

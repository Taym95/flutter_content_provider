import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_content_provider_platform_interface.dart';

/// An implementation of [FlutterContentProviderPlatform] that uses method channels.
class MethodChannelFlutterContentProvider extends FlutterContentProviderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_content_provider');

  @override
  Future<void> insert({required String key, required String value}) async {
    final args = {
      key: value,
    };
    return methodChannel.invokeMethod<void>('insert', args);
  }

  @override
  Future<String?> query(String key) async => methodChannel.invokeMethod<String>('query', key);

  @override
  Future<void> delete(String key) async => methodChannel.invokeMethod<void>('delete', key);
}

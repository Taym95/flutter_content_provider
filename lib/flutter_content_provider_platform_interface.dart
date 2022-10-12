import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_content_provider_method_channel.dart';

abstract class FlutterContentProviderPlatform extends PlatformInterface {
  /// Constructs a FlutterContentProviderPlatform.
  FlutterContentProviderPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterContentProviderPlatform _instance = MethodChannelFlutterContentProvider();

  /// The default instance of [FlutterContentProviderPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterContentProvider].
  static FlutterContentProviderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterContentProviderPlatform] when
  /// they register themselves.
  static set instance(FlutterContentProviderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> insert({required String key, required String value}) async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> query(String key) async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> delete(String key) async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

import 'flutter_content_provider_platform_interface.dart';

class FlutterContentProvider {
  Future<void> insert({required String key, required String value}) {
    return FlutterContentProviderPlatform.instance.insert(key: key, value: value);
  }

  Future<String?> query(String key) {
    return FlutterContentProviderPlatform.instance.query(key);
  }

  Future<void> delete(String key) {
    return FlutterContentProviderPlatform.instance.delete(key);
  }
}

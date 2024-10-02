part of 'local_store.dart';

class _Store {
  static GetStorage _ = GetStorage();

  static T? read<T>(String key) => _.read<T?>(key);

  static Future<void> write(String key, dynamic value) async =>
      _.write(key, value);

  static Future<void> erase() => _.erase();
}
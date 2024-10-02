import 'package:get_starter_kit_2024/app/data/local/storage_keys.dart';
import 'package:get_storage/get_storage.dart';

part 'store_helper.dart';

class _StoreObject<T> {
  final String key;
  T? value;

  _StoreObject({
    required this.key,
    this.value,
    T? initialValue,
  }) {
    if (call() == null && initialValue != null) {
      call(initialValue);
    }
  }

  T? call([T? v]) {
    if (v != null) {
      _Store.write(key, v);
      value = v;
    }
    value ??= _Store.read<T?>(key);
    return value;
  }

  @override
  String toString() => value.toString();
}

/// Local storage keys with built in helpers
class LocalStore {

  /// current locale
  static final _StoreObject<String> currentLocale =
  _StoreObject<String>(key: StorageKeys.currentLocaleKey);

  /// theme mode
  static final _StoreObject<int> themeMode =
  _StoreObject<int>(key: StorageKeys.themeKey);

  static Future<void> erase() async {
    _Store.erase();
  }
}
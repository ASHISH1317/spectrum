import 'dart:convert';
import 'package:get_starter_kit_2024/app/data/config/encryption.dart';
import 'package:get_starter_kit_2024/app/data/local/storage_keys.dart';
import 'package:get_starter_kit_2024/app/data/models/user_entity.dart';
import 'package:get_storage/get_storage.dart';

/// Helper class for local stored User
class UserProvider {
  static UserEntity? _userEntity;
  static String? _authToken;
  static late bool _isLoggedIn;

  /// Get currently logged in user
  static UserEntity? get currentUser => _userEntity;

  /// Get auth token of the logged in user
  static String? get authToken => _authToken;

  /// If the user is logged in or not
  static bool get isLoggedIn => _isLoggedIn;

  ///Set [currentUser] and [authToken]
  static Future<void> onLogin(UserEntity user, String userAuthToken) async {
    _isLoggedIn = true;
    _userEntity = user;
    _authToken = userAuthToken;
    await GetStorage().write(StorageKeys.userDataKey,
        AppEncryption.encrypt(plainText: jsonEncode(user.toJson())));
    await GetStorage().write(StorageKeys.authTokenKey, userAuthToken);
  }

  ///Load [currentUser] and [authToken]
  static void loadUser() {
    final String? encryptedUserData =
        GetStorage().read<String>(StorageKeys.userDataKey);

    if (encryptedUserData != null) {
      _isLoggedIn = true;
      _userEntity = UserEntity.fromMap(
          jsonDecode(AppEncryption.decrypt(cipherText: encryptedUserData))
              as Map<String, dynamic>);
      _authToken = GetStorage().read<String>(StorageKeys.authTokenKey)!;
    } else {
      _isLoggedIn = false;
    }
  }

  ///Remove [currentUser] and [authToken] from local storage
  static Future<void> onLogout() async {
    _isLoggedIn = false;
    _userEntity = null;
    _authToken = null;
    await GetStorage().remove(StorageKeys.userDataKey);
    await GetStorage().remove(StorageKeys.authTokenKey);
  }
}

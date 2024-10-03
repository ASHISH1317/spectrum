import 'dart:convert';

import 'package:get_starter_kit_2024/app/data/config/encryption.dart';
import 'package:get_starter_kit_2024/app/data/local/store/local_store.dart';
import 'package:get_starter_kit_2024/app/data/models/user_entity.dart';

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
  static void onLogin({
    required UserEntity user,
    required String userAuthToken,
  }) {
    _isLoggedIn = true;
    _userEntity = user;
    _authToken = userAuthToken;
    LocalStore.user(AppEncryption.encrypt(plainText: user.toJson()));
    LocalStore.authToken(userAuthToken);
  }

  ///Load [currentUser] and [authToken]
  static void loadUser() {
    final String? encryptedUserData = LocalStore.user();

    if (encryptedUserData != null) {
      _isLoggedIn = true;
      _userEntity = UserEntity.fromMap(
          jsonDecode(AppEncryption.decrypt(cipherText: encryptedUserData))
          as Map<String, dynamic>);
      _authToken = LocalStore.authToken();
    } else {
      _isLoggedIn = false;
    }
  }

  ///Remove [currentUser] and [authToken] from local storage
  static void onLogout() {
    _isLoggedIn = false;
    _userEntity = null;
    _authToken = null;
    LocalStore.user.erase();
    LocalStore.authToken.erase();
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/src/shared_preferences_legacy.dart';

const sessionIdKey = 'sessionId';
const accountKey = 'accountId';

class SessionService {
  SessionService(this._secureStorage, {FlutterSecureStorage? secureStorage, SharedPreferences? preferences});

  final FlutterSecureStorage _secureStorage;

  Future<String?> get sessionId {
    return _secureStorage.read(key: sessionIdKey);
  }

  Future<String?> get accountId {
    return _secureStorage.read(key: accountKey);
  }

  Future<void> saveSessionId(String sessionId) {
    return _secureStorage.write(
      key: sessionIdKey,
      value: sessionId,
    );
  }

  Future<void> saveAccountId(String accountId) {
    return _secureStorage.write(
      key: accountKey,
      value: accountId,
    );
  }

  Future<void> signOut() {
    return _secureStorage.deleteAll();
  }
}

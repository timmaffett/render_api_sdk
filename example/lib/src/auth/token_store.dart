import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Holds the Render API token, in the platform keychain.
///
/// A token is a bearer credential for the whole workspace, so it does not go in
/// `shared_preferences` beside the theme settings, and it is never written to a
/// file in the project. Deleting it is the whole of signing out.
class TokenStore extends ChangeNotifier {
  TokenStore(this._storage);

  static const _key = 'render_api_token';

  final FlutterSecureStorage _storage;

  String? _token;
  bool _loaded = false;

  /// Null until [load] has run, and again after [signOut].
  String? get token => _token;

  /// False while the keychain read is still in flight, so the app can show a
  /// splash rather than flashing the sign-in page at someone already signed in.
  bool get loaded => _loaded;

  bool get signedIn => _token != null;

  Future<void> load() async {
    _token = await _storage.read(key: _key);
    _loaded = true;
    notifyListeners();
  }

  Future<void> signIn(String token) async {
    final trimmed = token.trim();
    await _storage.write(key: _key, value: trimmed);
    _token = trimmed;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _storage.delete(key: _key);
    _token = null;
    notifyListeners();
  }
}

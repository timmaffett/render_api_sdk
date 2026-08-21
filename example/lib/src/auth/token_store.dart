import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Holds the Render API token, in the platform keychain.
///
/// A token is a bearer credential for the whole workspace, so it does not go in
/// `shared_preferences` beside the theme settings, and it is never written to a
/// file in the project. Deleting it is the whole of signing out.
class TokenStore extends ChangeNotifier {
  TokenStore([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage(mOptions: _macOs);

  static const _key = 'render_api_token';

  /// macOS needs the legacy keychain here, and the reason is worth knowing.
  ///
  /// The default is the **data protection** keychain, which a sandboxed app may
  /// only touch if it carries a `keychain-access-groups` entitlement — and that
  /// entitlement requires signing with a real development certificate. An
  /// ad-hoc signed build, which is what `flutter run` and `flutter build macos`
  /// produce without a signing team, fails with
  /// `-34018 errSecMissingEntitlement` on the first write.
  ///
  /// It fails at the *write*, not at build or launch, so it looks like a bug in
  /// the sign-in form. Opting into the file-based keychain keeps the token out
  /// of plain preferences while letting this example build and run for anyone,
  /// with no Apple developer account. A shipping app with a team should do the
  /// opposite: add the entitlement and delete this.
  static const _macOs = MacOsOptions(usesDataProtectionKeychain: false);

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

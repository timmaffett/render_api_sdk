// A read-only Flutter dashboard for a Render account, and the example for
// package:render_api.
//
//   flutter run -d macos
//
// There is no web build. Render's API sends no CORS headers, so a browser
// blocks every response — see README.md. Desktop and mobile are unaffected.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/auth/sign_in_page.dart';
import 'src/auth/token_store.dart';
import 'src/data/render_client.dart';
import 'src/pages/databases_page.dart';
import 'src/pages/services_page.dart';
import 'src/pages/workflows_page.dart';
import 'src/pages/workspace_page.dart';
import 'src/theme/settings_page.dart';
import 'src/theme/app_settings.dart';
import 'src/data/response_cache.dart';
import 'src/design/adaptive_app.dart';
import 'src/design/design_scope.dart';
import 'src/widgets/data_time.dart';
import 'src/widgets/refresh_scope.dart';
import 'src/widgets/responsive_scaffold.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final tokens = TokenStore()..load();

  // Every GET goes through here, so a rate-limited refresh replays the last
  // good response instead of replacing real data with an error.
  final cache = ResponseCache(prefs);

  runApp(
    RenderDashboardApp(
      settings: AppSettings(prefs),
      tokens: tokens,
      cache: cache,
      refresh: RefreshSignal(),
    ),
  );
}

class RenderDashboardApp extends StatelessWidget {
  const RenderDashboardApp({
    super.key,
    required this.settings,
    required this.tokens,
    required this.cache,
    required this.refresh,
  });

  final AppSettings settings;
  final TokenStore tokens;
  final ResponseCache cache;
  final RefreshSignal refresh;

  @override
  Widget build(BuildContext context) {
    // Two listenables, no state-management package: the theme rebuilds the
    // MaterialApp, the token decides which screen is under it.
    return SettingsScope(
      settings: settings,
      child: RefreshScope(
        signal: refresh,
        cache: cache,
        child: ListenableBuilder(
          listenable: settings,
          // DesignScope sits above the root app, because every adapter needs it
          // and some of them live in pushed routes — the same reason
          // RefreshScope had to be hoisted above MaterialApp.
          builder: (context, _) => DesignScope(
            system: settings.system,
            child: AdaptiveApp(
              settings: settings,
              title: 'Render Dashboard',
              home: ListenableBuilder(
                listenable: tokens,
                builder: (context, _) {
                  if (!tokens.loaded) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final token = tokens.token;
                  if (token == null) {
                    return SignInPage(onSubmit: tokens.signIn);
                  }
                  return _Home(
                    // Keyed on the token so signing in with a different one
                    // builds a fresh RenderClient rather than reusing the old
                    // HTTP client.
                    key: ValueKey(token),
                    token: token,
                    settings: settings,
                    cache: cache,
                    onSignOut: tokens.signOut,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({
    super.key,
    required this.token,
    required this.settings,
    required this.cache,
    required this.onSignOut,
  });

  final String token;
  final AppSettings settings;
  final ResponseCache cache;
  final Future<void> Function() onSignOut;

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  late final RenderClient _client = RenderClient(
    widget.token,
    cache: widget.cache,
  );
  int _index = 0;

  @override
  void dispose() {
    // RenderApi owns an HTTP client, so it has to be released.
    _client.close();
    super.dispose();
  }

  void _signOut() => widget.onSignOut();

  @override
  Widget build(BuildContext context) {
    final destinations = [
      Destination(
        label: 'Workspace',
        icon: Icons.account_tree_outlined,
        builder: (context) =>
            WorkspacePage(client: _client, onUnauthorized: _signOut),
      ),
      Destination(
        label: 'Services',
        icon: Icons.dns_outlined,
        builder: (context) =>
            ServicesPage(client: _client, onUnauthorized: _signOut),
      ),
      Destination(
        label: 'Databases',
        icon: Icons.storage_outlined,
        builder: (context) =>
            DatabasesPage(client: _client, onUnauthorized: _signOut),
      ),
      Destination(
        label: 'Workflows',
        icon: Icons.bolt_outlined,
        builder: (context) =>
            WorkflowsPage(client: _client, onUnauthorized: _signOut),
      ),
      Destination(
        label: 'Settings',
        icon: Icons.tune_outlined,
        builder: (context) =>
            SettingsPage(settings: widget.settings, onSignOut: _signOut),
      ),
    ];

    return ResponsiveScaffold(
      title: 'Render',
      destinations: destinations,
      selectedIndex: _index,
      onSelect: (index) => setState(() => _index = index),
      actions: const [RefreshButton()],
    );
  }
}

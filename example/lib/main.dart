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
import 'src/theme/theme_settings.dart';
import 'src/widgets/responsive_scaffold.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final tokens = TokenStore()..load();

  runApp(RenderDashboardApp(settings: ThemeSettings(prefs), tokens: tokens));
}

class RenderDashboardApp extends StatelessWidget {
  const RenderDashboardApp({
    super.key,
    required this.settings,
    required this.tokens,
  });

  final ThemeSettings settings;
  final TokenStore tokens;

  @override
  Widget build(BuildContext context) {
    // Two listenables, no state-management package: the theme rebuilds the
    // MaterialApp, the token decides which screen is under it.
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) => MaterialApp(
        title: 'Render Dashboard',
        debugShowCheckedModeBanner: false,
        theme: settings.theme,
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
              // Keyed on the token so signing in with a different one builds a
              // fresh RenderClient rather than reusing the old HTTP client.
              key: ValueKey(token),
              token: token,
              settings: settings,
              onSignOut: tokens.signOut,
            );
          },
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
    required this.onSignOut,
  });

  final String token;
  final ThemeSettings settings;
  final Future<void> Function() onSignOut;

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  late final RenderClient _client = RenderClient(widget.token);
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
    );
  }
}

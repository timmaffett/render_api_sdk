import 'package:auris/auris_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;

/// Where the API token is pasted in.
///
/// There is no OAuth flow to use — Render's API authenticates with a bearer
/// token created in the dashboard — so this is a text field and a button. The
/// token goes straight to the keychain; see `TokenStore`.
class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.onSubmit});

  final Future<void> Function(String token) onSubmit;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _controller = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await widget.onSubmit(_controller.text);
    } on Object catch (error) {
      // Storing the token can fail for reasons that have nothing to do with
      // the token — a macOS build missing the keychain entitlement returns
      // -34018 here. Without this the button sat on CHECKING… forever and
      // said nothing, because the exception skipped the line that clears it.
      if (mounted) setState(() => _error = _describe(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// The actionable part of a failure, rather than a raw toString.
  String _describe(Object error) => switch (error) {
    PlatformException e
        when e.code.contains('-34018') || '${e.details}'.contains('-34018') =>
      'The keychain rejected the write: the app is missing the '
          'keychain-access-groups entitlement. See macos/Runner/*.entitlements.',
    PlatformException e => e.message ?? e.code,
    _ => error.toString(),
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).extension<AurisScheme>()!;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: scheme.surfacePage,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: AurisPanel(
              title: 'RENDER DASHBOARD',
              code: 'render_api',
              accent: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Paste a Render API key. It is stored in this device\'s '
                    'keychain and sent only to api.render.com.',
                    style: text.bodySmall?.copyWith(color: scheme.textMid),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _controller,
                    obscureText: true,
                    autofocus: true,
                    onSubmitted: (_) => _submit(),
                    decoration: const InputDecoration(
                      labelText: 'API KEY',
                      hintText: 'rnd_...',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Dashboard → Account Settings → API Keys',
                    style: text.labelSmall?.copyWith(color: scheme.textDim),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: scheme.surfaceInset,
                        border: Border(
                          left: BorderSide(color: scheme.danger, width: 2),
                        ),
                      ),
                      child: SelectableText(
                        _error!,
                        style: text.bodySmall?.copyWith(color: scheme.textMid),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _busy ? null : _submit,
                    child: Text(_busy ? 'CHECKING…' : 'CONNECT'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

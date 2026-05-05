// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    final s   = app.settings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ── APPEARANCE ──────────────────────────────────────────────────
          const SectionHeader(title: 'Appearance'),
          Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(children: [

              // Dark mode
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                leading: Icon(
                  s.darkMode
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  color: cs.primary, size: 22,
                ),
                title: const Text('Dark Mode',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                subtitle: Text(
                  s.darkMode ? 'Currently dark' : 'Currently light',
                  style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurface.withValues(alpha: 0.55)),
                ),
                trailing: Switch.adaptive(
                  value: s.darkMode,
                  onChanged: (v) => app.updateSetting('darkMode', v),
                ),
              ),

              const Divider(height: 1, indent: 56),

              // Theme colour
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(Icons.palette_outlined,
                          color: cs.primary, size: 22),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Theme Colour',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          Text(
                            kSeedLabels[s.themeSeed] ?? s.themeSeed,
                            style: TextStyle(
                                fontSize: 12,
                                color: cs.onSurface
                                    .withValues(alpha: 0.55)),
                          ),
                        ],
                      ),
                    ]),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: kSeedColours.entries.map((e) {
                        final sel = s.themeSeed == e.key;
                        return GestureDetector(
                          onTap: () =>
                              app.updateSetting('themeSeed', e.key),
                          child: AnimatedContainer(
                            duration:
                                const Duration(milliseconds: 180),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: e.value,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: sel
                                    ? cs.onSurface
                                    : Colors.transparent,
                                width: 3,
                              ),
                              boxShadow: sel
                                  ? [
                                      BoxShadow(
                                        color: e.value
                                            .withValues(alpha: 0.5),
                                        blurRadius: 6,
                                        spreadRadius: 1,
                                      )
                                    ]
                                  : null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ]),
          ),

          // ── CURRENCY ────────────────────────────────────────────────────
          const SectionHeader(title: 'Currency'),
          Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              leading: Icon(Icons.monetization_on_outlined,
                  color: cs.primary, size: 22),
              title: const Text('Default Currency',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              subtitle: Text(
                '${currencyInfo(s.currency).name} (${currencyInfo(s.currency).symbol})',
                style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurface.withValues(alpha: 0.55)),
              ),
              trailing: DropdownButton<String>(
                value: s.currency,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(16),
                items: kCurrencies
                    .map((c) => DropdownMenuItem(
                          value: c.code,
                          child: Text('${c.code}  ${c.symbol}'),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) app.updateSetting('currency', v);
                },
              ),
            ),
          ),

          // ── PREFERENCES ─────────────────────────────────────────────────
          const SectionHeader(title: 'Preferences'),
          Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                leading: Icon(Icons.date_range_outlined,
                    color: cs.primary, size: 22),
                title: const Text('Week Starts On',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                subtitle: Text(
                  s.weekStart == 'monday' ? 'Monday' : 'Sunday',
                  style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurface.withValues(alpha: 0.55)),
                ),
                trailing: DropdownButton<String>(
                  value: s.weekStart,
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(16),
                  items: const [
                    DropdownMenuItem(
                        value: 'monday', child: Text('Monday')),
                    DropdownMenuItem(
                        value: 'sunday', child: Text('Sunday')),
                  ],
                  onChanged: (v) {
                    if (v != null) {
                      app.updateSetting('weekStart', v);
                    }
                  },
                ),
              ),
              const Divider(height: 1, indent: 56),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                leading: Icon(Icons.visibility_off_outlined,
                    color: cs.primary, size: 22),
                title: const Text('Hide Balance',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                subtitle: Text('Show balance as ••••••',
                    style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurface.withValues(alpha: 0.55))),
                trailing: Switch.adaptive(
                  value: s.hideBalance,
                  onChanged: (v) =>
                      app.updateSetting('hideBalance', v),
                ),
              ),
            ]),
          ),

          // ── PROFILE ───────────────────────────────────────────────────────
          const SectionHeader(title: 'Profile'),
          Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              leading: Icon(Icons.person_outline_rounded,
                  color: cs.primary, size: 22),
              title: const Text('Your Name',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              subtitle: Text(
                s.userName.isNotEmpty ? s.userName : 'Not set',
                style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurface.withValues(alpha: 0.55)),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => _editName(context, app),
            ),
          ),

          // ── ABOUT ─────────────────────────────────────────────────────────
          const SectionHeader(title: 'About'),
          Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                leading: Icon(Icons.info_outline_rounded,
                    color: cs.primary, size: 22),
                title: const Text('Version',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                subtitle: const Text('Expensy v1.0.1',
                    style: TextStyle(fontSize: 12)),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('Latest',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: cs.primary)),
                ),
              ),
              const Divider(height: 1, indent: 56),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                leading: Icon(Icons.shield_outlined,
                    color: cs.primary, size: 22),
                title: const Text('Offline & Private',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                subtitle: const Text(
                    'All data stored locally on your device',
                    style: TextStyle(fontSize: 12)),
                trailing: const Icon(Icons.check_circle_outline,
                    color: Color(0xFF2E7D32)),
              ),
            ]),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _editName(BuildContext context, AppProvider app) {
    final ctrl =
        TextEditingController(text: app.settings.userName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Edit Name'),
        content: TextField(
          controller: ctrl,
          decoration:
              const InputDecoration(labelText: 'Your name'),
          autofocus: true,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              app.updateSetting('userName', ctrl.text.trim());
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

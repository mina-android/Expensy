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
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ── Appearance ────────────────────────────────────────────────
          const SectionHeader(title: 'Appearance'),
          Card(margin: const EdgeInsets.only(bottom: 8), child: Column(children: [
            // Theme mode
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.brightness_6_outlined, color: cs.primary, size: 20),
                  const SizedBox(width: 10),
                  const Text('Theme', style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14)),
                ]),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 2, shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8, mainAxisSpacing: 8,
                  childAspectRatio: 3.2,
                  children: [
                    _ThemeCard(icon: Icons.brightness_auto_outlined,
                        label: 'Follow System', value: 'system',
                        selected: s.themeMode, cs: cs,
                        onTap: () => app.updateSetting('themeMode', 'system')),
                    _ThemeCard(icon: Icons.light_mode_outlined,
                        label: 'Light Mode', value: 'light',
                        selected: s.themeMode, cs: cs,
                        onTap: () => app.updateSetting('themeMode', 'light')),
                    _ThemeCard(icon: Icons.dark_mode_outlined,
                        label: 'Dark Mode', value: 'dark',
                        selected: s.themeMode, cs: cs,
                        onTap: () => app.updateSetting('themeMode', 'dark')),
                    _ThemeCard(icon: Icons.contrast_outlined,
                        label: 'Black AMOLED', value: 'amoled',
                        selected: s.themeMode, cs: cs,
                        onTap: () => app.updateSetting('themeMode', 'amoled')),
                  ],
                ),
              ]),
            ),

            const Divider(height: 1, indent: 16, endIndent: 16),

            // Accent colour
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.palette_outlined, color: cs.primary, size: 20),
                  const SizedBox(width: 10),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Accent Colour', style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14)),
                    Text(kSeedLabels[s.themeSeed] ?? s.themeSeed,
                        style: TextStyle(fontSize: 12,
                            color: cs.onSurface.withValues(alpha: 0.55))),
                  ]),
                ]),
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8,
                    children: kSeedColours.entries.map((e) {
                      final sel = s.themeSeed == e.key;
                      return GestureDetector(
                        onTap: () => app.updateSetting('themeSeed', e.key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 140),
                          width: 32, height: 32,
                          decoration: BoxDecoration(
                            color: e.value, shape: BoxShape.circle,
                            border: Border.all(
                                color: sel ? cs.onSurface : Colors.transparent,
                                width: 3),
                            boxShadow: sel ? [BoxShadow(
                                color: e.value.withValues(alpha: 0.5),
                                blurRadius: 6, spreadRadius: 1)] : null,
                          ),
                        ),
                      );
                    }).toList()),
              ]),
            ),
          ])),

          // ── Currency ──────────────────────────────────────────────────
          const SectionHeader(title: 'Currency'),
          Card(margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            leading: Icon(Icons.monetization_on_outlined, color: cs.primary),
            title: const Text('Default Currency',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            subtitle: Text('${currencyInfo(s.currency).name} (${currencyInfo(s.currency).symbol})',
                style: TextStyle(fontSize: 12,
                    color: cs.onSurface.withValues(alpha: 0.55))),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () async {
              final picked = await showCurrencyPicker(context,
                  current: s.currency);
              if (picked != null && context.mounted) {
                context.read<AppProvider>().updateSetting('currency', picked);
              }
            },
          )),

          // ── Preferences ───────────────────────────────────────────────
          const SectionHeader(title: 'Preferences'),
          Card(margin: const EdgeInsets.only(bottom: 8), child: Column(children: [
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              leading: Icon(Icons.date_range_outlined, color: cs.primary),
              title: const Text('Week Starts On',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              trailing: DropdownButton<String>(
                value: s.weekStart,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(12),
                items: const [
                  DropdownMenuItem(value: 'monday', child: Text('Monday')),
                  DropdownMenuItem(value: 'sunday', child: Text('Sunday')),
                ],
                onChanged: (v) {
                  if (v != null) app.updateSetting('weekStart', v);
                },
              ),
            ),
            const Divider(height: 1, indent: 56),
            SwitchListTile.adaptive(
              secondary: Icon(Icons.visibility_off_outlined, color: cs.primary),
              title: const Text('Hide Balance',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              subtitle: const Text('Show ••••• instead of amounts'),
              value: s.hideBalance,
              onChanged: (v) => app.updateSetting('hideBalance', v),
            ),
          ])),

          // ── Profile ───────────────────────────────────────────────────
          const SectionHeader(title: 'Profile'),
          Card(margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            leading: Icon(Icons.person_outline_rounded, color: cs.primary),
            title: const Text('Display Name',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            subtitle: Text(s.userName.isNotEmpty ? s.userName : 'Not set',
                style: TextStyle(fontSize: 12,
                    color: cs.onSurface.withValues(alpha: 0.55))),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _editName(context, app),
          )),

          // ── About ──────────────────────────────────────────────────────
          const SectionHeader(title: 'About'),
          Card(margin: const EdgeInsets.only(bottom: 40), child: Column(children: [
            ListTile(
              leading: Icon(Icons.info_outline_rounded, color: cs.primary),
              title: const Text('Version', style: TextStyle(fontWeight: FontWeight.w700)),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('v1.0.3', style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w700, color: cs.primary)),
              ),
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: Icon(Icons.shield_outlined, color: cs.primary),
              title: const Text('Privacy', style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: const Text('All data stored locally — 100% offline'),
              trailing: const Icon(Icons.check_circle_outline,
                  color: Color(0xFF2E7D32)),
            ),
          ])),
        ],
      ),
    );
  }

  void _editName(BuildContext context, AppProvider app) {
    final ctrl = TextEditingController(text: app.settings.userName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Display Name'),
        content: TextField(controller: ctrl, autofocus: true,
            decoration: const InputDecoration(labelText: 'Your name')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
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

class _ThemeCard extends StatelessWidget {
  final IconData icon;
  final String label, value, selected;
  final ColorScheme cs;
  final VoidCallback onTap;
  const _ThemeCard({required this.icon, required this.label,
      required this.value, required this.selected,
      required this.cs, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final sel = selected == value;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        decoration: BoxDecoration(
          color: sel ? cs.primary : cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 16,
              color: sel ? Colors.white : cs.onSurface.withValues(alpha: 0.7)),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
              color: sel ? Colors.white : cs.onSurface)),
        ]),
      ),
    );
  }
}

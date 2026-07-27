// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../l10n/app_localizations.dart';
import '../utils/haptics.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    final s   = app.settings;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings_title, style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ── Appearance ────────────────────────────────────────────────
          SectionHeader(title: l10n.settings_appearance),
          Card(margin: const EdgeInsets.only(bottom: 8), child: Column(children: [
            // Theme mode
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.brightness_6_outlined, color: cs.primary, size: 20),
                  const SizedBox(width: 10),
                  Text(l10n.settings_theme, style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14)),
                ]),
                const SizedBox(height: 10),
                // 3-option row: System | Light | Dark
                Row(children: [
                  Expanded(child: _ThemeCard(
                    icon: Icons.brightness_auto_outlined,
                    label: l10n.settings_system, value: 'system',
                    selected: s.themeMode, cs: cs,
                    onTap: () => app.updateSetting('themeMode', 'system'))),
                  const SizedBox(width: 8),
                  Expanded(child: _ThemeCard(
                    icon: Icons.light_mode_outlined,
                    label: l10n.settings_light, value: 'light',
                    selected: s.themeMode, cs: cs,
                    onTap: () => app.updateSetting('themeMode', 'light'))),
                  const SizedBox(width: 8),
                  Expanded(child: _ThemeCard(
                    icon: Icons.dark_mode_outlined,
                    label: l10n.settings_dark, value: 'dark',
                    selected: s.themeMode, cs: cs,
                    onTap: () => app.updateSetting('themeMode', 'dark'))),
                ]),
              ]),
            ),

            // AMOLED toggle — hidden in light-only mode
            const Divider(height: 1, indent: 16, endIndent: 16),
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              secondary: Icon(Icons.format_paint_outlined, color: cs.primary, size: 20),
              title: Text('Dynamic Color',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              subtitle: Text('Use system wallpaper colors',
                  style: TextStyle(fontSize: 12,
                      color: cs.onSurface.withValues(alpha: 0.55))),
              value: s.dynamicColorEnabled,
              onChanged: (v) {
                AppHaptics.tap(context, HapticStrength.selection);
                app.updateSetting('dynamicColorEnabled', v);
              },
            ),
            
            if (s.themeMode != 'light') ...[
              const Divider(height: 1, indent: 16, endIndent: 16),
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                secondary: Icon(Icons.contrast_outlined, color: cs.primary, size: 20),
                title: Text(l10n.settings_amoledTitle,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                subtitle: Text(l10n.settings_amoledSubtitle,
                    style: TextStyle(fontSize: 12,
                        color: cs.onSurface.withValues(alpha: 0.55))),
                value: s.amoledSurfaces,
                onChanged: (v) {
                  AppHaptics.tap(context, HapticStrength.selection);
                  app.updateSetting('amoledSurfaces', v);
                },
              ),
            ],

            if (!s.dynamicColorEnabled) ...[
              const Divider(height: 1, indent: 16, endIndent: 16),

              // Accent colour
              Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.palette_outlined, color: cs.primary, size: 20),
                  const SizedBox(width: 10),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(l10n.settings_accentColor, style: TextStyle(
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
                          duration: const Duration(milliseconds: 100),
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
            ],
          ])),

          // ── App Font ──────────────────────────────────────────────────
          SectionHeader(title: l10n.settings_appFont),
          Card(margin: const EdgeInsets.only(bottom: 8), child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(Icons.text_fields_rounded, color: cs.primary, size: 20),
                const SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(l10n.settings_appFont, style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14)),
                  Text(kFonts[s.appFont] ?? l10n.settings_systemDefault,
                      style: TextStyle(fontSize: 12,
                          color: cs.onSurface.withValues(alpha: 0.55))),
                ]),
              ]),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 8,
                  children: kFonts.entries.map((e) {
                    final sel = s.appFont == e.key;
                    return GestureDetector(
                      onTap: () => app.updateSetting('appFont', e.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: sel
                              ? cs.primary
                              : cs.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(e.value,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: sel
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: sel
                                  ? cs.onPrimary
                                  : cs.onSurface,
                            )),
                      ),
                    );
                  }).toList()),
            ]),
          )),

          // ── Currency ──────────────────────────────────────────────────
          SectionHeader(title: l10n.settings_currency),
          Card(margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            leading: Icon(Icons.monetization_on_outlined, color: cs.primary),
            title: Text(l10n.settings_defaultCurrency,
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

          // ── Language ──────────────────────────────────────────────────
          SectionHeader(title: l10n.settings_language),
          Card(margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            leading: Icon(Icons.language_outlined, color: cs.primary),
            title: Text(l10n.settings_language,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            subtitle: Text(_langName(context, s.languageCode),
                style: TextStyle(fontSize: 12,
                    color: cs.onSurface.withValues(alpha: 0.55))),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () async {
              final picked = await _showLanguagePicker(context, current: s.languageCode);
              if (picked != null && context.mounted) {
                context.read<AppProvider>().updateSetting('languageCode', picked);
              }
            },
          )),

          // ── Preferences ───────────────────────────────────────────────
          SectionHeader(title: l10n.settings_preferences),
          Card(margin: const EdgeInsets.only(bottom: 8), child: Column(children: [
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              leading: Icon(Icons.date_range_outlined, color: cs.primary),
              title: Text(l10n.settings_weekStartsOn,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              trailing: DropdownButton<String>(
                value: s.weekStart,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(12),
                items: [DropdownMenuItem(value: 'monday', child: Text(l10n.settings_monday)),
                  DropdownMenuItem(value: 'sunday', child: Text(l10n.settings_sunday)),
                ],
                onChanged: (v) {
                  if (v != null) app.updateSetting('weekStart', v);
                },
              ),
            ),
            const Divider(height: 1, indent: 56),
            SwitchListTile.adaptive(
              secondary: Icon(Icons.visibility_off_outlined, color: cs.primary),
              title: Text(l10n.settings_hideBalance,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              subtitle: Text(l10n.settings_hideBalanceSubtitle),
              value: s.hideBalance,
              onChanged: (v) {
                AppHaptics.tap(context, HapticStrength.selection);
                app.updateSetting('hideBalance', v);
              },
            ),
            const Divider(height: 1, indent: 56),
            SwitchListTile.adaptive(
              secondary: Icon(Icons.notifications_active_outlined, color: cs.primary),
              title: const Text('Budget Alerts',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              subtitle: const Text('Notify when a budget or goal is reached'),
              value: s.budgetAlertsEnabled,
              onChanged: (v) {
                AppHaptics.tap(context, HapticStrength.selection);
                app.updateSetting('budgetAlertsEnabled', v);
              },
            ),
            const Divider(height: 1, indent: 56),
            SwitchListTile.adaptive(
              secondary: Icon(Icons.access_time_rounded, color: cs.primary),
              title: const Text('Daily Reminder',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              subtitle: const Text('Remind to log transactions daily'),
              value: s.dailyReminderEnabled,
              onChanged: (v) {
                AppHaptics.tap(context, HapticStrength.selection);
                app.updateSetting('dailyReminderEnabled', v);
              },
            ),
            if (s.dailyReminderEnabled) ...[
              ListTile(
                contentPadding: const EdgeInsets.only(left: 72, right: 16),
                title: const Text('Reminder Time', style: TextStyle(fontSize: 14)),
                trailing: Text(s.dailyReminderTime,
                    style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold)),
                onTap: () async {
                  final initial = TimeOfDay(
                    hour: int.tryParse(s.dailyReminderTime.split(':')[0]) ?? 22,
                    minute: int.tryParse(s.dailyReminderTime.split(':')[1]) ?? 0,
                  );
                  final picked = await showTimePicker(context: context, initialTime: initial);
                  if (picked != null && context.mounted) {
                    final timeStr = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                    app.updateSetting('dailyReminderTime', timeStr);
                  }
                },
              ),
            ],
            const Divider(height: 1, indent: 56),
            SwitchListTile.adaptive(
              secondary: Icon(Icons.vibration_rounded, color: cs.primary),
              title: const Text('Haptic Feedback',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              subtitle: const Text('Vibrate on interactions'),
              value: s.hapticsEnabled,
              onChanged: (v) {
                AppHaptics.tap(context, HapticStrength.selection);
                app.updateSetting('hapticsEnabled', v);
              },
            ),
          ])),

          // ── Profile ───────────────────────────────────────────────────
          SectionHeader(title: l10n.settings_profile),
          Card(margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            leading: Icon(Icons.person_outline_rounded, color: cs.primary),
            title: Text(l10n.settings_displayName,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            subtitle: Text(s.userName.isNotEmpty ? s.userName : l10n.settings_notSet,
                style: TextStyle(fontSize: 12,
                    color: cs.onSurface.withValues(alpha: 0.55))),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _editName(context, app),
          )),

          // ── About ──────────────────────────────────────────────────────
          SectionHeader(title: l10n.settings_about),
          Card(margin: const EdgeInsets.only(bottom: 40), child: Column(children: [
            ListTile(
              leading: Icon(Icons.info_outline_rounded, color: cs.primary),
              title: Text(l10n.settings_version, style: TextStyle(fontWeight: FontWeight.w700)),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('v1.0.8', style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w700, color: cs.primary)),
              ),
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: Icon(Icons.shield_outlined, color: cs.primary),
              title: Text(l10n.settings_privacy, style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(l10n.settings_privacySubtitle),
              trailing: const Icon(Icons.check_circle_outline,
                  color: Color(0xFF2E7D32)),
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: Icon(Icons.code_rounded, color: cs.primary),
              title: Text(l10n.settings_github, style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(l10n.settings_githubSubtitle),
              trailing: Icon(Icons.open_in_new_rounded,
                  size: 18, color: cs.onSurface.withValues(alpha: 0.4)),
              onTap: () async {
                final uri = Uri.parse('https://github.com/mina-android/Expensy');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: Icon(Icons.person_outline_rounded, color: cs.primary),
              title: Text(l10n.settings_developer, style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(l10n.settings_developerSubtitle),
              trailing: Icon(Icons.open_in_new_rounded,
                  size: 18, color: cs.onSurface.withValues(alpha: 0.4)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(l10n.settings_developer, style: TextStyle(fontWeight: FontWeight.w700)),
                    contentPadding: const EdgeInsets.only(top: 16, bottom: 8),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.code_rounded),
                          title: Text(l10n.settings_githubProfile),
                          onTap: () async {
                            Navigator.pop(ctx);
                            final uri = Uri.parse('https://github.com/mina-android');
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            }
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.language_rounded),
                          title: Text(l10n.settings_developerWebsite),
                          onTap: () async {
                            Navigator.pop(ctx);
                            final uri = Uri.parse('https://portfolio.minaashraf285.workers.dev');
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            }
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(l10n.settings_close),
                      ),
                    ],
                  ),
                );
              },
            ),
          ])),
        ],
      ),
    );
  }

  void _editName(BuildContext context, AppProvider app) {
    final l10n = AppLocalizations.of(context)!;
    final ctrl = TextEditingController(text: app.settings.userName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settings_displayName),
        content: TextField(controller: ctrl, autofocus: true,
            decoration: InputDecoration(labelText: l10n.settings_yourName)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.settings_cancel)),
          FilledButton(
            onPressed: () {
              app.updateSetting('userName', ctrl.text.trim());
              Navigator.pop(ctx);
            },
            child: Text(l10n.settings_save),
          ),
        ],
      ),
    );
  }

  String _langName(BuildContext context, String code) {
    final l10n = AppLocalizations.of(context)!;
    switch (code) {
      case 'en': return 'English';
      case 'ar': return 'العربية';
      case 'fr': return 'Français';
      case 'de': return 'Deutsch';
      case 'hi': return 'हिन्दी';
      default: return l10n.settings_systemDefault;
    }
  }

  Future<String?> _showLanguagePicker(BuildContext context, {required String current}) {
    final l10n = AppLocalizations.of(context)!;
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settings_language),
        contentPadding: const EdgeInsets.only(top: 16, bottom: 8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _langTile(l10n.settings_systemDefault, 'system', current, ctx),
            _langTile('English', 'en', current, ctx),
            _langTile('العربية', 'ar', current, ctx),
            _langTile('Français', 'fr', current, ctx),
            _langTile('Deutsch', 'de', current, ctx),
            _langTile('हिन्दी', 'hi', current, ctx),
          ],
        ),
      ),
    );
  }

  Widget _langTile(String label, String code, String current, BuildContext ctx) {
    final sel = code == current;
    final cs = Theme.of(ctx).colorScheme;
    return ListTile(
      leading: sel ? Icon(Icons.check, color: cs.primary) : const SizedBox(width: 24),
      title: Text(label, style: TextStyle(fontWeight: sel ? FontWeight.bold : FontWeight.normal)),
      onTap: () => Navigator.pop(ctx, code),
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
        duration: const Duration(milliseconds: 150),
        height: 68,
        decoration: BoxDecoration(
          color: sel ? cs.primary : cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: sel ? cs.primary : cs.outlineVariant,
            width: sel ? 0 : 1,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 22,
              color: sel ? Colors.white : cs.onSurface.withValues(alpha: 0.65)),
          const SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
              color: sel ? Colors.white : cs.onSurface)),
        ]),
      ),
    );
  }
}

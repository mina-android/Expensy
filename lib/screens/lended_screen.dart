// lib/screens/lended_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../services/notification_service.dart';

class LendedScreen extends StatelessWidget {
  const LendedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    String fmt(double v) => formatAmount(v, app.settings.currency);

    final active   = app.lended.where((l) => !l.isSettled).toList();
    final settled  = app.lended.where((l) =>  l.isSettled).toList();
    final theyOwe  = active.where((l) => l.type == 'lent')
        .fold(0.0, (s, l) => s + l.amount);
    final iOwe     = active.where((l) => l.type == 'borrowed')
        .fold(0.0, (s, l) => s + l.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lent Money',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: Column(children: [
        // Summary bar
        if (app.lended.isNotEmpty)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            color: cs.primary,
            child: Row(children: [
              Expanded(child: _SumCol(
                  label: 'They Owe Me', value: fmt(theyOwe),
                  color: cs.onPrimary.withValues(alpha: 0.9),
                  labelColor: cs.onPrimary.withValues(alpha: 0.65))),
              Expanded(child: _SumCol(
                  label: 'I Owe Them', value: fmt(iOwe),
                  color: cs.onPrimary.withValues(alpha: 0.9),
                  labelColor: cs.onPrimary.withValues(alpha: 0.65))),
              Expanded(child: _SumCol(
                  label: 'Net', value: fmt(theyOwe - iOwe),
                  color: cs.onPrimary,
                  labelColor: cs.onPrimary.withValues(alpha: 0.65))),
            ]),
          ),
        Expanded(child: app.lended.isEmpty
          ? const EmptyState(icon: Icons.handshake_outlined,
              message: 'No records',
              subMessage: 'Tap + to track lent or borrowed money')
          : ListView(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
              children: [
                if (active.isNotEmpty) ...[
                  const SectionHeader(title: 'Active'),
                  ...active.map((l) => _LendedCard(l: l, fmt: fmt)),
                ],
                if (settled.isNotEmpty) ...[
                  const SectionHeader(title: 'Settled'),
                  ...settled.map((l) => _LendedCard(l: l, fmt: fmt)),
                ],
              ],
            )),
      ]),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => _openSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void openSheetFromExternal(BuildContext ctx,
      {LendedMoney? existing}) =>
      _openSheet(ctx, existing: existing);

  static void _openSheet(BuildContext ctx, {LendedMoney? existing}) {
    showModalBottomSheet(
      context: ctx, isScrollControlled: true, useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _LendedSheet(existing: existing),
    );
  }
}

// ── Summary column ────────────────────────────────────────────────────────────
class _SumCol extends StatelessWidget {
  final String label, value;
  final Color color;
  final Color? labelColor;
  const _SumCol({required this.label, required this.value,
      required this.color, this.labelColor});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(label, style: TextStyle(fontSize: 10,
        color: labelColor ?? Theme.of(context).colorScheme
            .onPrimaryContainer.withValues(alpha: 0.6))),
    const SizedBox(height: 2),
    Text(value, style: TextStyle(fontSize: 13,
        fontWeight: FontWeight.w800, color: color)),
  ]);
}

// ── Card ──────────────────────────────────────────────────────────────────────
class _LendedCard extends StatelessWidget {
  final LendedMoney l;
  final String Function(double) fmt;
  const _LendedCard({required this.l, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final isLent = l.type == 'lent';
    final color  = isLent
        ? const Color(0xFF2E7D32)
        : const Color(0xFFC62828);

    final now    = DateTime.now();
    final isOverdue = l.dueDate != null &&
        !l.isSettled &&
        l.dueDate!.isBefore(DateTime(now.year, now.month, now.day));

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 42, height: 42,
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(
                    isLent
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: color)),
            const SizedBox(width: 12),
            Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(l.personName, style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 15)),
              Text(isLent ? 'Lent to' : 'Borrowed from',
                  style: TextStyle(fontSize: 11,
                      color: cs.onSurface.withValues(alpha: 0.5))),
            ])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(fmt(l.amount), style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w800, color: color)),
              if (l.dueDate != null)
                Text(
                  isOverdue
                      ? 'Overdue!'
                      : 'Due ${DateFormat('d MMM yy').format(l.dueDate!)}',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,
                      color: isOverdue ? cs.error
                          : cs.onSurface.withValues(alpha: 0.5)),
                ),
            ]),
          ]),

          if (l.notes.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(l.notes, style: TextStyle(fontSize: 12,
                color: cs.onSurface.withValues(alpha: 0.6))),
          ],

          // Reminder badge
          if (l.reminderEnabled && l.dueDate != null && !l.isSettled) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.notifications_active_outlined,
                    size: 11, color: cs.primary),
                const SizedBox(width: 4),
                Text(
                  'Reminder at ${l.reminderTime}',
                  style: TextStyle(fontSize: 10,
                      fontWeight: FontWeight.w600, color: cs.primary),
                ),
              ]),
            ),
          ],

          const SizedBox(height: 8),
          Row(children: [
            if (l.isSettled)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8)),
                child: const Text('SETTLED', style: TextStyle(fontSize: 10,
                    fontWeight: FontWeight.w700, color: Color(0xFF2E7D32))),
              )
            else
              TextButton.icon(
                icon: const Icon(Icons.check_circle_outline, size: 16),
                label: const Text('Settle', style: TextStyle(fontSize: 12)),
                onPressed: () =>
                    context.read<AppProvider>().settleLended(l),
              ),
            const Spacer(),
            IconButton(
                icon: const Icon(Icons.edit_outlined, size: 18),
                onPressed: () =>
                    LendedScreen._openSheet(context, existing: l)),
            IconButton(
                icon: Icon(Icons.delete_outline_rounded,
                    size: 18, color: cs.error),
                onPressed: () async {
                  if (await showDeleteConfirm(context, l.personName) &&
                      context.mounted) {
                    context.read<AppProvider>().deleteLended(l.id);
                  }
                }),
          ]),
        ]),
      ),
    );
  }
}

// ── Sheet ─────────────────────────────────────────────────────────────────────
class _LendedSheet extends StatefulWidget {
  final LendedMoney? existing;
  const _LendedSheet({this.existing});
  @override
  State<_LendedSheet> createState() => _LendedSheetState();
}

class _LendedSheetState extends State<_LendedSheet> {
  final _personCtrl = TextEditingController();
  final _amtCtrl    = TextEditingController();
  final _notesCtrl  = TextEditingController();

  String    _type             = 'lent';
  String?   _accountId;
  DateTime? _dueDate;
  bool      _reminderEnabled  = false;
  TimeOfDay _reminderTime     = const TimeOfDay(hour: 9, minute: 0);

  bool get isEdit => widget.existing != null;

  String get _reminderTimeStr =>
      '${_reminderTime.hour.toString().padLeft(2, '0')}:'
      '${_reminderTime.minute.toString().padLeft(2, '0')}';

  static TimeOfDay _parseTime(String s) {
    final parts = s.split(':');
    return TimeOfDay(
      hour:   int.tryParse(parts[0]) ?? 9,
      minute: parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0,
    );
  }

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _personCtrl.text  = e.personName;
      _amtCtrl.text     = e.amount.toStringAsFixed(2);
      _notesCtrl.text   = e.notes;
      _type             = e.type;
      _accountId        = e.accountId;
      _dueDate          = e.dueDate;
      _reminderEnabled  = e.reminderEnabled;
      _reminderTime     = _parseTime(e.reminderTime);
    }
  }

  @override
  void dispose() {
    _personCtrl.dispose(); _amtCtrl.dispose(); _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _toggleReminder(bool value) async {
    if (!value) {
      setState(() => _reminderEnabled = false);
      return;
    }
    // Reminder requires a due date
    if (_dueDate == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Set a due date first to enable reminders.'),
          duration: Duration(seconds: 3),
        ));
      }
      return;
    }
    final hasPermission = await NotificationService().hasPermission();
    if (!hasPermission) {
      final granted = await NotificationService().requestPermissions();
      if (!granted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Notification permission denied. '
              'Enable it in Settings → Apps → Expensy → Notifications.',
            ),
            duration: Duration(seconds: 4),
          ));
        }
        return;
      }
    }
    setState(() => _reminderEnabled = true);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
      helpText: 'Remind me at',
    );
    if (picked != null) setState(() => _reminderTime = picked);
  }

  Future<void> _submit() async {
    if (_personCtrl.text.trim().isEmpty) return;
    final amount = double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0) return;
    final app = context.read<AppProvider>();

    // If reminder is on but no due date, disable it
    final effectiveReminder = _reminderEnabled && _dueDate != null;

    if (isEdit) {
      final updated = widget.existing!.copyWith(
        personName:      _personCtrl.text.trim(),
        amount:          amount,
        type:            _type,
        accountId:       _accountId,
        dueDate:         _dueDate,
        notes:           _notesCtrl.text.trim(),
        clearAccount:    _accountId == null,
        reminderEnabled: effectiveReminder,
        reminderTime:    _reminderTimeStr,
      );
      await app.updateLended(updated, widget.existing!);
    } else {
      await app.addLended(LendedMoney(
        id:              app.newId(),
        personName:      _personCtrl.text.trim(),
        amount:          amount,
        type:            _type,
        accountId:       _accountId,
        date:            DateTime.now(),
        dueDate:         _dueDate,
        notes:           _notesCtrl.text.trim(),
        reminderEnabled: effectiveReminder,
        reminderTime:    _reminderTimeStr,
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    final sym = currencyInfo(app.settings.currency).symbol;

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 20, right: 20, top: 20),
      child: SingleChildScrollView(child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isEdit ? 'Edit Record' : 'Add Record',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),

          // Type toggle
          Row(children: [
            Expanded(child: GestureDetector(
              onTap: () => setState(() => _type = 'lent'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _type == 'lent'
                      ? const Color(0xFF2E7D32) : const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text('I Lent',
                    style: TextStyle(fontWeight: FontWeight.w700,
                        color: _type == 'lent'
                            ? Colors.white : const Color(0xFF2E7D32)))),
              ),
            )),
            const SizedBox(width: 10),
            Expanded(child: GestureDetector(
              onTap: () => setState(() => _type = 'borrowed'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _type == 'borrowed'
                      ? const Color(0xFFC62828) : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text('I Borrowed',
                    style: TextStyle(fontWeight: FontWeight.w700,
                        color: _type == 'borrowed'
                            ? Colors.white : const Color(0xFFC62828)))),
              ),
            )),
          ]),
          const SizedBox(height: 12),

          TextField(controller: _personCtrl,
              decoration: const InputDecoration(
                  labelText: 'Person\'s Name',
                  prefixIcon: Icon(Icons.person_outline_rounded))),
          const SizedBox(height: 12),
          TextField(controller: _amtCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: 'Amount', prefixText: '$sym ')),
          const SizedBox(height: 14),

          Text('Account (optional)',
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          AccountCardPicker(
            accounts: app.accounts.where((a) => !a.isGold).toList(),
            selectedId: _accountId, allowNone: true,
            onSelected: (id) => setState(() => _accountId = id),
          ),
          const SizedBox(height: 12),

          // Due date picker
          ListTile(contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event_outlined),
            title: Text(_dueDate != null
                ? 'Due: ${DateFormat('d MMM yyyy').format(_dueDate!)}'
                : 'No due date',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: _dueDate != null
                ? IconButton(icon: const Icon(Icons.clear),
                    onPressed: () => setState(() {
                      _dueDate = null;
                      _reminderEnabled = false;
                    }))
                : null,
            onTap: () async {
              final p = await showDatePicker(context: context,
                  initialDate: _dueDate ??
                      DateTime.now().add(const Duration(days: 30)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100));
              if (p != null) setState(() => _dueDate = p);
            },
          ),

          // ── Reminder section (only when due date is set) ────────────
          const Divider(height: 20),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            secondary: Icon(
              _reminderEnabled
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_none_outlined,
              color: _reminderEnabled ? cs.primary : null,
            ),
            title: Text(
              'Due Date Reminder',
              style: TextStyle(fontWeight: FontWeight.w600,
                  color: _reminderEnabled ? cs.primary : null),
            ),
            subtitle: Text(
              _dueDate == null
                  ? 'Set a due date first'
                  : _reminderEnabled
                      ? 'You\'ll be notified on the due date'
                      : 'Get notified when this is due',
              style: TextStyle(fontSize: 12,
                  color: cs.onSurface.withValues(alpha: 0.5)),
            ),
            value: _reminderEnabled,
            onChanged: _dueDate == null ? null : _toggleReminder,
          ),

          // Time picker — only when reminder is enabled
          if (_reminderEnabled && _dueDate != null) ...[
            const SizedBox(height: 4),
            InkWell(
              onTap: _pickTime,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: cs.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: cs.primary.withValues(alpha: 0.35)),
                ),
                child: Row(children: [
                  Icon(Icons.access_time_rounded, size: 20,
                      color: cs.primary),
                  const SizedBox(width: 12),
                  Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('Remind me at',
                        style: TextStyle(fontSize: 11,
                            color: cs.onSurface.withValues(alpha: 0.55))),
                    Text(_reminderTime.format(context),
                        style: TextStyle(fontSize: 16,
                            fontWeight: FontWeight.w700, color: cs.primary)),
                  ])),
                  Icon(Icons.chevron_right_rounded, color: cs.primary),
                ]),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                'Notification fires on ${DateFormat('d MMM yyyy').format(_dueDate!)} at ${_reminderTime.format(context)}.',
                style: TextStyle(fontSize: 11,
                    color: cs.onSurface.withValues(alpha: 0.4)),
              ),
            ),
          ],

          const SizedBox(height: 12),
          TextField(controller: _notesCtrl, maxLines: 2,
              decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  prefixIcon: Icon(Icons.sticky_note_2_outlined))),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _submit,
            style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28))),
            child: Text(isEdit ? 'Save Changes' : 'Add Record'),
          ),
        ],
      )),
    );
  }
}

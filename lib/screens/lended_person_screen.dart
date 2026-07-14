// lib/screens/lended_person_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../services/lended_notification_service.dart';
import 'lended_screen.dart' show kLendedPersonColors;

/// Detail page for a single [LendedPerson] — shows their net balance and
/// their full ledger of [LendedMoney] entries (add/edit/settle/delete),
/// the same way an account detail area shows a running balance plus its
/// own transaction history.
class LendedPersonScreen extends StatelessWidget {
  final LendedPerson person;
  const LendedPersonScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    // Re-resolve in case the person was edited since this screen was pushed.
    final current = app.personById(person.id) ?? person;
    String fmt(double v) => formatAmount(v, app.settings.currency);

    final entries = app.lendedFor(current.id);
    final active  = entries.where((l) => !l.isSettled).toList();
    final settled = entries.where((l) => l.isSettled).toList();
    final balance = app.personBalance(current.id);
    final color   = Color(current.colorValue);

    final balColor = balance > 0
        ? const Color(0xFF2E7D32)
        : balance < 0
            ? const Color(0xFFC62828)
            : cs.onPrimary;
    final balLabel = balance > 0
        ? '${current.name} owes you'
        : balance < 0
            ? 'You owe ${current.name}'
            : 'All settled up';

    return Scaffold(
      appBar: AppBar(
        title: Text(current.name,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _editPerson(context, current),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (v) async {
              if (v == 'delete') {
                final ok = await showDeleteConfirm(context, current.name);
                if (ok && context.mounted) {
                  await context.read<AppProvider>().deleteLendedPerson(current.id);
                  if (context.mounted) Navigator.pop(context);
                }
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'delete', child: Row(children: [
                Icon(Icons.delete_outline_rounded, size: 18, color: Colors.red),
                SizedBox(width: 8), Text('Delete person'),
              ])),
            ],
          ),
        ],
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          color: cs.primary,
          child: Column(children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(28)),
              child: Center(child: Text(
                current.name.isNotEmpty ? current.name[0].toUpperCase() : '?',
                style: const TextStyle(fontWeight: FontWeight.w800,
                    fontSize: 22, color: Colors.white),
              )),
            ),
            const SizedBox(height: 10),
            Text(fmt(balance.abs()), style: TextStyle(fontSize: 26,
                fontWeight: FontWeight.w800, color: cs.onPrimary)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                  color: balColor.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(balLabel, style: TextStyle(fontSize: 12,
                  fontWeight: FontWeight.w700, color: balColor)),
            ),
          ]),
        ),
        Expanded(child: entries.isEmpty
          ? const EmptyState(icon: Icons.receipt_long_outlined,
              message: 'No records yet',
              subMessage: 'Tap + to log money lent or borrowed')
          : ListView(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
              children: [
                if (active.isNotEmpty) ...[
                  const SectionHeader(title: 'Active'),
                  ...active.map((l) => _EntryCard(l: l, fmt: fmt)),
                ],
                if (settled.isNotEmpty) ...[
                  const SectionHeader(title: 'Settled'),
                  ...settled.map((l) => _EntryCard(l: l, fmt: fmt)),
                ],
              ],
            )),
      ]),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => _openEntrySheet(context, current),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _editPerson(BuildContext ctx, LendedPerson p) {
    showModalBottomSheet(
      context: ctx, isScrollControlled: true, useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _EditPersonInlineSheet(person: p),
    );
  }

  static void openEntrySheetFromExternal(BuildContext ctx, LendedMoney existing) {
    final app = ctx.read<AppProvider>();
    final p = app.personById(existing.personId);
    if (p == null) return;
    _openEntrySheet(ctx, p, existing: existing);
  }

  static void _openEntrySheet(BuildContext ctx, LendedPerson person,
      {LendedMoney? existing}) {
    showModalBottomSheet(
      context: ctx, isScrollControlled: true, useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _EntrySheet(person: person, existing: existing),
    );
  }
}

// Thin wrapper reusing the same fields as the Add-Person sheet, but bound to
// updateLendedPerson for an existing person (avoids duplicating the sheet UI
// in lended_screen.dart, which is private to that file).
class _EditPersonInlineSheet extends StatefulWidget {
  final LendedPerson person;
  const _EditPersonInlineSheet({required this.person});
  @override
  State<_EditPersonInlineSheet> createState() => _EditPersonInlineSheetState();
}

class _EditPersonInlineSheetState extends State<_EditPersonInlineSheet> {
  late final _nameCtrl  = TextEditingController(text: widget.person.name);
  late final _notesCtrl = TextEditingController(text: widget.person.notes);
  late int _color = widget.person.colorValue;

  @override
  void dispose() {
    _nameCtrl.dispose(); _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;
    final app = context.read<AppProvider>();
    await app.updateLendedPerson(widget.person.copyWith(
      name: name, colorValue: _color, notes: _notesCtrl.text.trim(),
    ));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 20, right: 20, top: 20),
      child: SingleChildScrollView(child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit Person', style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          TextField(controller: _nameCtrl,
              decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline_rounded))),
          const SizedBox(height: 14),
          Text('Colour', style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          Wrap(spacing: 10, runSpacing: 10, children: kLendedPersonColors.map((col) {
            final sel = _color == col;
            return GestureDetector(
              onTap: () => setState(() => _color = col),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: Color(col), shape: BoxShape.circle,
                  border: sel
                      ? Border.all(color: cs.onSurface, width: 2.5)
                      : null,
                ),
                child: sel
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
            );
          }).toList()),
          const SizedBox(height: 14),
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
            child: const Text('Save Changes'),
          ),
        ],
      )),
    );
  }
}

// ── Entry card (one lend/borrow ledger row) ─────────────────────────────────
class _EntryCard extends StatelessWidget {
  final LendedMoney l;
  final String Function(double) fmt;
  const _EntryCard({required this.l, required this.fmt});

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
              Text(isLent ? 'Lent' : 'Borrowed', style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 15)),
              Text(DateFormat('d MMM yyyy').format(l.date),
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
                onPressed: () {
                  final app = context.read<AppProvider>();
                  final person = app.personById(l.personId);
                  if (person != null) {
                    LendedPersonScreen._openEntrySheet(context, person,
                        existing: l);
                  }
                }),
            IconButton(
                icon: Icon(Icons.delete_outline_rounded,
                    size: 18, color: cs.error),
                onPressed: () async {
                  final app = context.read<AppProvider>();
                  final person = app.personById(l.personId);
                  if (await showDeleteConfirm(
                          context, person?.name ?? 'this record') &&
                      context.mounted) {
                    app.deleteLended(l.id);
                  }
                }),
          ]),
        ]),
      ),
    );
  }
}

// ── Add/Edit entry sheet (scoped to one person) ──────────────────────────────
class _EntrySheet extends StatefulWidget {
  final LendedPerson person;
  final LendedMoney? existing;
  const _EntrySheet({required this.person, this.existing});
  @override
  State<_EntrySheet> createState() => _EntrySheetState();
}

class _EntrySheetState extends State<_EntrySheet> {
  final _amtCtrl   = TextEditingController();
  final _notesCtrl = TextEditingController();

  String    _type             = 'lent';
  String?   _accountId;
  DateTime? _dueDate;
  bool      _reminderEnabled  = false;
  TimeOfDay _reminderTime     = const TimeOfDay(hour: 9, minute: 0);

  bool get isEdit => widget.existing != null;

  String get _reminderTimeStr =>
      '${_reminderTime.hour.toString().padLeft(2, '0')}:'
      '${_reminderTime.minute.toString().padLeft(2, '0')}';

  /// True when [_dueDate] is today and [_reminderTime] has already passed —
  /// the case where NotificationService falls back to a near-term reminder
  /// instead of the picked time (see scheduleLendedReminder /
  /// _fallbackDueTodayDate), since a system-computed recurring nextDate is
  /// never "today, earlier than now" the way a freely-picked dueDate can be.
  bool get _reminderTimeAlreadyPassedToday {
    if (_dueDate == null) return false;
    final now = DateTime.now();
    final isToday = _dueDate!.year == now.year &&
        _dueDate!.month == now.month &&
        _dueDate!.day == now.day;
    if (!isToday) return false;
    final target = DateTime(
        now.year, now.month, now.day, _reminderTime.hour, _reminderTime.minute);
    return target.isBefore(now);
  }

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
    _amtCtrl.dispose(); _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _toggleReminder(bool value) async {
    if (!value) {
      setState(() => _reminderEnabled = false);
      return;
    }
    if (_dueDate == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Set a due date first to enable reminders.'),
          duration: Duration(seconds: 3),
        ));
      }
      return;
    }
    final hasPermission = await LendedNotificationService().hasPermission();
    if (!hasPermission) {
      final granted = await LendedNotificationService().requestPermissions();
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
    final amount = double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0) return;
    final app = context.read<AppProvider>();

    final effectiveReminder = _reminderEnabled && _dueDate != null;

    if (isEdit) {
      final updated = widget.existing!.copyWith(
        amount:          amount,
        type:            _type,
        accountId:       _accountId,
        dueDate:         _dueDate,
        clearDueDate:    _dueDate == null,
        notes:           _notesCtrl.text.trim(),
        clearAccount:    _accountId == null,
        reminderEnabled: effectiveReminder,
        reminderTime:    _reminderTimeStr,
      );
      await app.updateLended(updated, widget.existing!);
    } else {
      await app.addLended(LendedMoney(
        id:              app.newId(),
        personId:        widget.person.id,
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
          Text(widget.person.name, style: TextStyle(fontSize: 13,
              fontWeight: FontWeight.w600,
              color: cs.onSurface.withValues(alpha: 0.55))),
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

          TextField(controller: _amtCtrl,
              autofocus: !isEdit,
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
                _reminderTimeAlreadyPassedToday
                    ? "That time today has already passed — you'll be "
                        'notified shortly instead.'
                    : 'Notification fires on '
                        '${DateFormat('d MMM yyyy').format(_dueDate!)} '
                        'at ${_reminderTime.format(context)}.',
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

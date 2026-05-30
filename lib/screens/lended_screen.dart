// lib/screens/lended_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class LendedScreen extends StatelessWidget {
  const LendedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    String fmt(double v) => formatAmount(v, app.settings.currency);

    final active   = app.lended.where((l) => !l.isSettled).toList();
    final settled  = app.lended.where((l) =>  l.isSettled).toList();
    final theyOwe  = active.where((l) => l.type == 'lent').fold(0.0, (s,l) => s+l.amount);
    final iOwe     = active.where((l) => l.type == 'borrowed').fold(0.0, (s,l) => s+l.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lent Money', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: Column(children: [
        // Summary bar
        if (app.lended.isNotEmpty)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            color: cs.primary,
            child: Row(children: [
              Expanded(child: _SumCol(label: 'They Owe Me', value: fmt(theyOwe),
                  color: cs.onPrimary.withValues(alpha: 0.9),
                  labelColor: cs.onPrimary.withValues(alpha: 0.65))),
              Expanded(child: _SumCol(label: 'I Owe Them', value: fmt(iOwe),
                  color: cs.onPrimary.withValues(alpha: 0.9),
                  labelColor: cs.onPrimary.withValues(alpha: 0.65))),
              Expanded(child: _SumCol(label: 'Net', value: fmt(theyOwe - iOwe),
                  color: cs.onPrimary,
                  labelColor: cs.onPrimary.withValues(alpha: 0.65))),
            ]),
          ),
        Expanded(child: app.lended.isEmpty
          ? const EmptyState(icon: Icons.handshake_outlined,
              message: 'No records', subMessage: 'Tap + to track lent or borrowed money')
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

  /// Public entry-point so other screens (e.g. TransactionsScreen) can open
  /// the lended sheet without importing internal helpers.
  static void openSheetFromExternal(BuildContext ctx, {LendedMoney? existing}) =>
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

class _SumCol extends StatelessWidget {
  final String label, value;
  final Color color;
  final Color? labelColor;
  const _SumCol({required this.label, required this.value,
      required this.color, this.labelColor});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(label, style: TextStyle(fontSize: 10,
        color: labelColor ?? Theme.of(context).colorScheme.onPrimaryContainer
            .withValues(alpha: 0.6))),
    const SizedBox(height: 2),
    Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800,
        color: color)),
  ]);
}

class _LendedCard extends StatelessWidget {
  final LendedMoney l;
  final String Function(double) fmt;
  const _LendedCard({required this.l, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final isLent = l.type == 'lent';
    final color  = isLent ? const Color(0xFF2E7D32) : const Color(0xFFC62828);

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
                child: Icon(isLent ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded, color: color)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                Text('Due ${DateFormat('d MMM yy').format(l.dueDate!)}',
                    style: TextStyle(fontSize: 10,
                        color: cs.onSurface.withValues(alpha: 0.5))),
            ]),
          ]),
          if (l.notes.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(l.notes, style: TextStyle(fontSize: 12,
                color: cs.onSurface.withValues(alpha: 0.6))),
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
                onPressed: () => context.read<AppProvider>().settleLended(l),
              ),
            const Spacer(),
            IconButton(icon: const Icon(Icons.edit_outlined, size: 18),
                onPressed: () => LendedScreen._openSheet(context, existing: l)),
            IconButton(icon: Icon(Icons.delete_outline_rounded, size: 18,
                color: cs.error),
                onPressed: () async {
                  if (await showDeleteConfirm(context, l.personName)
                      && context.mounted) {
                    context.read<AppProvider>().deleteLended(l.id);
                  }
                }),
          ]),
        ]),
      ),
    );
  }
}

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
  String    _type      = 'lent';
  String?   _accountId;
  DateTime? _dueDate;
  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _personCtrl.text = e.personName;
      _amtCtrl.text    = e.amount.toStringAsFixed(2);
      _notesCtrl.text  = e.notes;
      _type      = e.type;
      _accountId = e.accountId;
      _dueDate   = e.dueDate;
    }
  }

  @override
  void dispose() {
    _personCtrl.dispose(); _amtCtrl.dispose(); _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_personCtrl.text.trim().isEmpty) return;
    final amount = double.tryParse(_amtCtrl.text);
    if (amount == null || amount <= 0) return;
    final app = context.read<AppProvider>();

    if (isEdit) {
      final updated = widget.existing!.copyWith(
        personName: _personCtrl.text.trim(),
        amount: amount, type: _type,
        accountId: _accountId,
        dueDate: _dueDate, notes: _notesCtrl.text.trim(),
        clearAccount: _accountId == null,
      );
      await app.updateLended(updated, widget.existing!);
    } else {
      await app.addLended(LendedMoney(
        id: app.newId(), personName: _personCtrl.text.trim(),
        amount: amount, type: _type, accountId: _accountId,
        date: DateTime.now(), dueDate: _dueDate,
        notes: _notesCtrl.text.trim(),
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
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
                duration: const Duration(milliseconds: 140),
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
                duration: const Duration(milliseconds: 140),
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
              decoration: const InputDecoration(labelText: 'Person\'s Name',
                  prefixIcon: Icon(Icons.person_outline_rounded))),
          const SizedBox(height: 12),
          TextField(controller: _amtCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Amount', prefixText: '$sym ')),
          const SizedBox(height: 14),

          Text('Account (optional)', style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          AccountCardPicker(
            accounts: app.accounts.where((a) => !a.isGold).toList(),
            selectedId: _accountId, allowNone: true,
            onSelected: (id) => setState(() => _accountId = id),
          ),
          const SizedBox(height: 12),

          ListTile(contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event_outlined),
            title: Text(_dueDate != null
                ? 'Due: ${DateFormat('d MMM yyyy').format(_dueDate!)}'
                : 'No due date',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: _dueDate != null
                ? IconButton(icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _dueDate = null))
                : null,
            onTap: () async {
              final p = await showDatePicker(context: context,
                  initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 30)),
                  firstDate: DateTime.now(), lastDate: DateTime(2100));
              if (p != null) setState(() => _dueDate = p);
            },
          ),
          TextField(controller: _notesCtrl, maxLines: 2,
              decoration: const InputDecoration(labelText: 'Notes (optional)',
                  prefixIcon: Icon(Icons.sticky_note_2_outlined))),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _submit,
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
            child: Text(isEdit ? 'Save Changes' : 'Add Record'),
          ),
        ],
      )),
    );
  }
}

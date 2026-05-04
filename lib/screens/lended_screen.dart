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
    final app      = context.watch<AppProvider>();
    final currency = app.settings.currency;
    String fmt(double v) => formatAmount(v, currency);

    final lentOut  = app.lended.where((l) => l.type == 'lent'     && !l.isSettled).toList();
    final borrowed = app.lended.where((l) => l.type == 'borrowed' && !l.isSettled).toList();
    final settled  = app.lended.where((l) => l.isSettled).toList();

    final totalLent = lentOut .fold(0.0, (s, l) => s + l.amount);
    final totalOwed = borrowed.fold(0.0, (s, l) => s + l.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lent Money',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: const Color(0xFFE65100),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Summary bar
          Container(
            color: const Color(0xFFE65100),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(children: [
              _SumChip(label: 'They Owe Me',  value: fmt(totalLent), positive: true),
              const SizedBox(width: 10),
              _SumChip(label: 'I Owe Them',   value: fmt(totalOwed), positive: false),
              const SizedBox(width: 10),
              _SumChip(
                label: 'Net',
                value: fmt((totalLent - totalOwed).abs()),
                positive: totalLent >= totalOwed,
              ),
            ]),
          ),

          Expanded(
            child: app.lended.isEmpty
                ? const EmptyState(
                    icon: Icons.handshake_outlined,
                    message: 'No lending records',
                    subMessage: 'Track money you lent or borrowed',
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
                    children: [
                      if (lentOut.isNotEmpty) ...[
                        _GroupHeader(title: 'THEY OWE ME', color: const Color(0xFF2E7D32)),
                        ...lentOut .map((l) => _LendCard(l: l, app: app, fmt: fmt)),
                        const SizedBox(height: 8),
                      ],
                      if (borrowed.isNotEmpty) ...[
                        _GroupHeader(title: 'I OWE THEM', color: const Color(0xFFC62828)),
                        ...borrowed.map((l) => _LendCard(l: l, app: app, fmt: fmt)),
                        const SizedBox(height: 8),
                      ],
                      if (settled.isNotEmpty) ...[
                        _GroupHeader(title: 'SETTLED', color: Colors.grey),
                        ...settled .map((l) => _LendCard(l: l, app: app, fmt: fmt)),
                      ],
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE65100),
        foregroundColor: Colors.white,
        onPressed: () => _showSheet(context, app),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void openSheet(BuildContext ctx, AppProvider app,
      {LendedMoney? existing}) =>
      _showSheet(ctx, app, existing: existing);

  static void _showSheet(BuildContext ctx, AppProvider app,
      {LendedMoney? existing}) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _LendSheet(app: app, existing: existing),
    );
  }
}

class _SumChip extends StatelessWidget {
  final String label, value;
  final bool positive;
  const _SumChip({required this.label, required this.value, required this.positive});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: const TextStyle(
                    color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(value,
                style: const TextStyle(
                    color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis),
          ]),
        ),
      );
}

class _GroupHeader extends StatelessWidget {
  final String title;
  final Color color;
  const _GroupHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w800,
                color: color, letterSpacing: 1)),
      );
}

class _LendCard extends StatelessWidget {
  final LendedMoney l;
  final AppProvider app;
  final String Function(double) fmt;
  const _LendCard({required this.l, required this.app, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final isLent = l.type == 'lent';
    final accent = isLent ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    final acc    = l.accountId != null ? app.accountById(l.accountId!) : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: accent.withValues(alpha: 0.3), width: 1.5)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              l.isSettled ? Icons.check_circle_outline
                  : (isLent ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded),
              color: l.isSettled ? Colors.grey : accent, size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(
                    child: Text(l.personName,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14,
                            decoration: l.isSettled ? TextDecoration.lineThrough : null)),
                  ),
                  PillBadge(label: isLent ? 'I lent' : 'I owe', color: accent),
                  if (l.isOverdue) ...[
                    const SizedBox(width: 4),
                    const PillBadge(label: 'Overdue', color: Color(0xFFC62828)),
                  ],
                ]),
                const SizedBox(height: 2),
                Text(
                  DateFormat('d MMM yyyy').format(l.date) +
                      (l.dueDate != null
                          ? ' · Due: ${DateFormat('d MMM yyyy').format(l.dueDate!)}'
                          : ''),
                  style: TextStyle(fontSize: 11, color: cs.onSurface.withValues(alpha: 0.55)),
                ),
                if (acc != null)
                  Text('Account: ${acc.name}',
                      style: TextStyle(fontSize: 11, color: cs.onSurface.withValues(alpha: 0.5))),
                if (l.notes.isNotEmpty)
                  Text(l.notes,
                      style: TextStyle(
                          fontSize: 11, color: cs.onSurface.withValues(alpha: 0.5),
                          fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(fmt(l.amount),
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 15,
                      color: l.isSettled ? Colors.grey : accent)),
              const SizedBox(height: 4),
              if (!l.isSettled) ...[
                // Edit button
                GestureDetector(
                  onTap: () => LendedScreen._showSheet(context, app, existing: l),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: cs.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('Edit',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w700,
                            color: cs.primary)),
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => app.settleLendedItem(l.id),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Settled',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w700,
                            color: Color(0xFF2E7D32))),
                  ),
                ),
              ],
              const SizedBox(height: 2),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 18),
                color: cs.onSurface.withValues(alpha: 0.35),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () async {
                  final ok = await showDeleteConfirm(context, l.personName);
                  if (ok && context.mounted) app.deleteLendedItem(l.id);
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

// ─── Add / Edit Sheet ─────────────────────────────────────────────────────
class _LendSheet extends StatefulWidget {
  final AppProvider app;
  final LendedMoney? existing;
  const _LendSheet({required this.app, this.existing});

  @override
  State<_LendSheet> createState() => _LendSheetState();
}

class _LendSheetState extends State<_LendSheet> {
  late TextEditingController _personCtrl;
  late TextEditingController _amountCtrl;
  late TextEditingController _notesCtrl;
  late String _type;
  String? _accountId;
  DateTime? _dueDate;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final ex = widget.existing;
    _personCtrl = TextEditingController(text: ex?.personName ?? '');
    _amountCtrl = TextEditingController(
        text: ex != null ? ex.amount.toStringAsFixed(2) : '');
    _notesCtrl  = TextEditingController(text: ex?.notes ?? '');
    _type       = ex?.type ?? 'lent';
    _accountId  = ex?.accountId;
    _dueDate    = ex?.dueDate;
  }

  @override
  void dispose() {
    _personCtrl.dispose();
    _amountCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDue() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _submit() async {
    if (_personCtrl.text.trim().isEmpty) return;
    final amount = double.tryParse(_amountCtrl.text);
    if (amount == null || amount <= 0) return;

    if (isEdit) {
      final updated = widget.existing!.copyWith(
        personName: _personCtrl.text.trim(),
        amount:     amount,
        type:       _type,
        accountId:  _accountId,
        dueDate:    _dueDate,
        notes:      _notesCtrl.text.trim(),
      );
      await widget.app.updateLendedItemFull(updated, widget.existing!);
    } else {
      await widget.app.addLendedItem(LendedMoney(
        id:         widget.app.newId(),
        personName: _personCtrl.text.trim(),
        amount:     amount,
        type:       _type,
        accountId:  _accountId,
        date:       DateTime.now(),
        dueDate:    _dueDate,
        notes:      _notesCtrl.text.trim(),
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final currency = widget.app.settings.currency;
    final sym      = currencyInfo(currency).symbol;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 20, right: 20, top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isEdit ? 'Edit Lending Record' : 'Add Lending Record',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 18),

          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'lent',     label: Text('I Lent Money'),
                  icon: Icon(Icons.arrow_upward_rounded)),
              ButtonSegment(value: 'borrowed', label: Text('I Borrowed'),
                  icon: Icon(Icons.arrow_downward_rounded)),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() => _type = s.first),
          ),
          const SizedBox(height: 14),

          TextField(
            controller: _personCtrl,
            decoration: const InputDecoration(
                labelText: 'Person Name',
                prefixIcon: Icon(Icons.person_outline)),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: _amountCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: 'Amount', prefixText: '$sym '),
          ),
          const SizedBox(height: 12),

          // Account picker
          if (widget.app.accounts.isNotEmpty)
            DropdownButtonFormField<String>(
              initialValue: _accountId,
              decoration: const InputDecoration(
                labelText: 'From Account (optional)',
                prefixIcon: Icon(Icons.account_balance_wallet_outlined),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('No account')),
                ...widget.app.accounts.map((a) =>
                    DropdownMenuItem(value: a.id, child: Text(a.name))),
              ],
              onChanged: (v) => setState(() => _accountId = v),
            ),
          const SizedBox(height: 12),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today_outlined),
            title: Text(
              _dueDate != null
                  ? 'Due: ${DateFormat('d MMM yyyy').format(_dueDate!)}'
                  : 'No due date',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: _dueDate != null
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _dueDate = null))
                : null,
            onTap: _pickDue,
          ),
          const SizedBox(height: 4),

          TextField(
            controller: _notesCtrl,
            maxLines: 2,
            decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                prefixIcon: Icon(Icons.notes_outlined)),
          ),
          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: _submit,
            icon: Icon(isEdit ? Icons.save_outlined : Icons.add),
            label: Text(isEdit ? 'Save Changes' : 'Add Record'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: const Color(0xFFE65100),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
            ),
          ),
        ],
      ),
    );
  }
}

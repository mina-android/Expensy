// lib/screens/lended_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'lended_person_screen.dart';

/// Colour palette for [LendedPerson] avatars — same 10-colour rotation used
/// to auto-assign colours during the v9→v10 legacy backfill migration, kept
/// here too so newly-created people can pick from the same set.
const List<int> kLendedPersonColors = [
  0xFF6750A4, 0xFF1565C0, 0xFF2E7D32, 0xFFC62828, 0xFFE65100,
  0xFF00838F, 0xFF6A1B9A, 0xFF37474F, 0xFFAD1457, 0xFF827717,
  0xFF283593, 0xFF00695C, 0xFFEF6C00, 0xFF4527A0, 0xFF00838F,
];

class LendedScreen extends StatelessWidget {
  const LendedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final cs  = Theme.of(context).colorScheme;
    String fmt(double v) => formatAmount(v, app.settings.currency);

    // Net balances across all people (mirrors the old flat-list totals).
    double theyOwe = 0, iOwe = 0;
    for (final p in app.lendedPeople) {
      final bal = app.personBalance(p.id);
      if (bal > 0) theyOwe += bal; else iOwe += -bal;
    }

    // Sort: people with an overdue balance first, then by |balance| desc,
    // then alphabetically for settled/zero-balance people.
    final people = [...app.lendedPeople];
    people.sort((a, b) {
      final overdueA = app.personHasOverdue(a.id);
      final overdueB = app.personHasOverdue(b.id);
      if (overdueA != overdueB) return overdueA ? -1 : 1;
      final balA = app.personBalance(a.id).abs();
      final balB = app.personBalance(b.id).abs();
      if (balA != balB) return balB.compareTo(balA);
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lent Money',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      ),
      body: Column(children: [
        if (app.lendedPeople.isNotEmpty)
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
        Expanded(child: people.isEmpty
          ? const EmptyState(icon: Icons.handshake_outlined,
              message: 'No one yet',
              subMessage: 'Tap + to add a person you lend to or borrow from')
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
              itemCount: people.length,
              itemBuilder: (_, i) => _PersonCard(person: people[i], fmt: fmt),
            )),
      ]),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => _openPersonSheet(context),
        child: const Icon(Icons.person_add_alt_1_rounded),
      ),
    );
  }

  static void openPersonSheetFromExternal(BuildContext ctx) =>
      _openPersonSheet(ctx);

  static void _openPersonSheet(BuildContext ctx, {LendedPerson? existing}) {
    showModalBottomSheet(
      context: ctx, isScrollControlled: true, useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _PersonSheet(existing: existing),
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

// ── Person card ────────────────────────────────────────────────────────────────
class _PersonCard extends StatelessWidget {
  final LendedPerson person;
  final String Function(double) fmt;
  const _PersonCard({required this.person, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final app     = context.watch<AppProvider>();
    final cs      = Theme.of(context).colorScheme;
    final color   = Color(person.colorValue);
    final balance = app.personBalance(person.id);
    final entries = app.lendedFor(person.id);
    final activeCount = entries.where((l) => !l.isSettled).length;
    final overdue = app.personHasOverdue(person.id);

    final balColor = balance > 0
        ? const Color(0xFF2E7D32)
        : balance < 0
            ? const Color(0xFFC62828)
            : cs.onSurface.withValues(alpha: 0.5);
    final balLabel = balance > 0
        ? 'Owes you'
        : balance < 0
            ? 'You owe'
            : 'Settled up';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(context,
            ExpensyRoute(builder: (_) => LendedPersonScreen(person: person))),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(children: [
            Container(
              width: 46, height: 46,
              decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(23)),
              child: Center(child: Text(
                person.name.isNotEmpty ? person.name[0].toUpperCase() : '?',
                style: TextStyle(fontWeight: FontWeight.w800,
                    fontSize: 18, color: color),
              )),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Flexible(child: Text(person.name, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 15))),
                if (overdue) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        color: cs.errorContainer,
                        borderRadius: BorderRadius.circular(6)),
                    child: Text('OVERDUE', style: TextStyle(fontSize: 9,
                        fontWeight: FontWeight.w700, color: cs.onErrorContainer)),
                  ),
                ],
              ]),
              const SizedBox(height: 2),
              Text(
                activeCount == 0
                    ? 'No active records'
                    : '$activeCount active record${activeCount == 1 ? '' : 's'}',
                style: TextStyle(fontSize: 11,
                    color: cs.onSurface.withValues(alpha: 0.5)),
              ),
            ])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(fmt(balance.abs()), style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w800, color: balColor)),
              Text(balLabel, style: TextStyle(fontSize: 10,
                  fontWeight: FontWeight.w600, color: balColor)),
            ]),
            const Icon(Icons.chevron_right_rounded),
          ]),
        ),
      ),
    );
  }
}

// ── Add/Edit person sheet ────────────────────────────────────────────────────
class _PersonSheet extends StatefulWidget {
  final LendedPerson? existing;
  const _PersonSheet({this.existing});
  @override
  State<_PersonSheet> createState() => _PersonSheetState();
}

class _PersonSheetState extends State<_PersonSheet> {
  final _nameCtrl  = TextEditingController();
  final _notesCtrl = TextEditingController();
  int _color = kLendedPersonColors.first;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text  = e.name;
      _notesCtrl.text = e.notes;
      _color          = e.colorValue;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;
    final app = context.read<AppProvider>();

    if (isEdit) {
      await app.updateLendedPerson(widget.existing!.copyWith(
        name: name, colorValue: _color, notes: _notesCtrl.text.trim(),
      ));
    } else {
      await app.addLendedPerson(LendedPerson(
        id: app.newId(), name: name, colorValue: _color,
        notes: _notesCtrl.text.trim(),
      ));
    }
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
          Text(isEdit ? 'Edit Person' : 'Add Person',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          TextField(controller: _nameCtrl,
              autofocus: !isEdit,
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
            child: Text(isEdit ? 'Save Changes' : 'Add Person'),
          ),
        ],
      )),
    );
  }
}

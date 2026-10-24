import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../l10n/app_localizations.dart';
import '../utils/snackbar.dart';
import '../utils/notification_permissions.dart';
import 'fintech_components.dart';

class CertificateSheet extends StatefulWidget {
  final Certificate? existing;
  const CertificateSheet({super.key, this.existing});

  @override
  State<CertificateSheet> createState() => _CertificateSheetState();
}

class _CertificateSheetState extends State<CertificateSheet> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _amount;
  late String _currency;
  late DateTime _startDate;
  late DateTime _endDate;
  late double _interestRate;
  late String _collectionType;
  late int _collectionDay;
  double? _customPayoutAmount;
  String? _accountId;
  late bool _reminderEnabled;
  late String _reminderTime;
  late bool _reminderEarlyEnabled;
  late String _notes;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppProvider>();
    final ex = widget.existing;
    final bankAccounts = app.accounts.where((a) => a.type == 'bank').toList();

    _name = ex?.name ?? '';
    _amount = ex?.amount ?? 0.0;
    _currency = ex?.currency ?? app.settings.currency;
    _startDate = ex?.startDate ?? DateTime.now();
    _endDate = ex?.endDate ?? DateTime.now().add(const Duration(days: 365));
    _interestRate = ex?.interestRate ?? 15.0;
    _collectionType = ex?.collectionType ?? 'monthly';
    _collectionDay = ex?.collectionDay ?? _startDate.day;
    _customPayoutAmount = ex?.customPayoutAmount;
    _accountId = ex?.accountId ??
        (bankAccounts.isNotEmpty ? bankAccounts.first.id : null);
    _reminderEnabled = ex?.reminderEnabled ?? false;
    _reminderTime = ex?.reminderTime ?? '09:00';
    _reminderEarlyEnabled = ex?.reminderEarlyEnabled ?? false;
    _notes = ex?.notes ?? '';
  }

  double get _calculatedPeriodicYield {
    if (_customPayoutAmount != null && _customPayoutAmount! > 0) {
      return _customPayoutAmount!;
    }
    final annualReturn = _amount * (_interestRate / 100.0);
    switch (_collectionType) {
      case 'daily':
        return annualReturn / 365.0;
      case 'yearly':
        return annualReturn;
      case 'monthly':
      default:
        return annualReturn / 12.0;
    }
  }

  double get _calculatedTotalExpectedReturn {
    final days = _endDate.difference(_startDate).inDays;
    final years = days / 365.0;
    return _amount * (_interestRate / 100.0) * (years > 0 ? years : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final viewInsets = MediaQuery.of(context).viewInsets;
    final bankAccounts = app.accounts.where((a) => a.type == 'bank').toList();

    return Container(
      decoration: BoxDecoration(
        color: popupSurfaceColor(cs),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.fromBorderSide(popupBorderSide(cs)),
      ),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + viewInsets.bottom),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.existing == null
                        ? l10n.certificates_addCertificate
                        : l10n.certificates_editCertificate,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Name
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: l10n.certificates_name,
                  prefixIcon: const Icon(Icons.badge_outlined),
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? l10n.error_required
                    : null,
                onSaved: (val) => _name = val!.trim(),
              ),
              const SizedBox(height: 14),

              // Principal Amount & Currency
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      initialValue:
                          _amount > 0 ? _amount.toStringAsFixed(2) : '',
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: l10n.certificates_amount,
                        prefixText: '${currencyInfo(_currency).symbol} ',
                      ),
                      validator: (val) {
                        final parsed = double.tryParse(val ?? '');
                        if (parsed == null || parsed <= 0) {
                          return l10n.error_required;
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          _amount = double.tryParse(val) ?? 0.0;
                        });
                      },
                      onSaved: (val) => _amount = double.parse(val!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () async {
                        final picked = await showCurrencyPicker(context,
                            current: _currency);
                        if (picked != null) setState(() => _currency = picked);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: cs.outlineVariant.withValues(alpha: 0.5)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _currency,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 13),
                            ),
                            const Icon(Icons.arrow_drop_down_rounded, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Interest Rate & Custom Payout
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _interestRate.toString(),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: l10n.certificates_interestRate,
                        suffixText: '%',
                      ),
                      validator: (val) {
                        final parsed = double.tryParse(val ?? '');
                        if (parsed == null || parsed < 0) {
                          return l10n.error_required;
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          _interestRate = double.tryParse(val) ?? 0.0;
                        });
                      },
                      onSaved: (val) => _interestRate = double.parse(val!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      initialValue:
                          _customPayoutAmount?.toStringAsFixed(2) ?? '',
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Payout (override)',
                        prefixText: '${currencyInfo(_currency).symbol} ',
                      ),
                      onChanged: (val) {
                        setState(() {
                          _customPayoutAmount = double.tryParse(val);
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Collection Frequency & Day
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<String>(
                      initialValue: _collectionType,
                      borderRadius: BorderRadius.circular(16),
                      decoration: InputDecoration(
                        labelText: l10n.certificates_collectionType,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outlineVariant
                                  .withValues(alpha: 0.6)),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'monthly', child: Text('Monthly')),
                        DropdownMenuItem(value: 'daily', child: Text('Daily')),
                        DropdownMenuItem(
                            value: 'yearly', child: Text('Yearly')),
                      ],
                      onChanged: (v) =>
                          setState(() => _collectionType = v ?? 'monthly'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      initialValue: _collectionDay.toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Day (1-31)',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outlineVariant
                                  .withValues(alpha: 0.6)),
                        ),
                      ),
                      validator: (val) {
                        final parsed = int.tryParse(val ?? '');
                        if (parsed == null || parsed < 1 || parsed > 31) {
                          return '1-31';
                        }
                        return null;
                      },
                      onSaved: (val) => _collectionDay = int.parse(val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Linked Bank Account
              Text(
                l10n.certificates_linkedBankAccount,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1),
              ),
              const SizedBox(height: 8),
              if (bankAccounts.isEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.errorContainer.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'No Bank Accounts available. Please create a bank account to receive payouts.',
                    style: TextStyle(color: cs.onErrorContainer, fontSize: 12),
                  ),
                ),
              ] else ...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: bankAccounts.map((a) {
                      final sel = _accountId == a.id;
                      return GestureDetector(
                        onTap: () => setState(() {
                          _accountId = a.id;
                          _currency = a.currency;
                        }),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 140),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: sel ? cs.primary : cs.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.account_balance_outlined,
                                  size: 16,
                                  color: sel ? Colors.white : cs.onSurface),
                              const SizedBox(width: 6),
                              Text(
                                a.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: sel ? Colors.white : cs.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
              const SizedBox(height: 14),

              // Date pickers (Start Date & End Date)
              Row(
                children: [
                  Expanded(
                    child: FintechDateField(
                      label: l10n.certificates_startDate,
                      value: _startDate,
                      prefixIcon: Icons.calendar_today_rounded,
                      onDateSelected: (picked) {
                        setState(() {
                          _startDate = picked;
                          if (_endDate.isBefore(_startDate)) {
                            _endDate =
                                _startDate.add(const Duration(days: 365));
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FintechDateField(
                      label: l10n.certificates_endDate,
                      value: _endDate,
                      firstDate: _startDate,
                      prefixIcon: Icons.event_available_rounded,
                      onDateSelected: (picked) {
                        setState(() => _endDate = picked);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Yield Summary Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF00897B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: const Color(0xFF00897B).withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.certificates_periodicYield,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          formatAmount(_calculatedPeriodicYield, _currency),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF00897B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.certificates_expectedTotal,
                          style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                        Text(
                          formatAmount(
                              _calculatedTotalExpectedReturn, _currency),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: cs.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Reminder Switch
              FintechReminderToggle(
                value: _reminderEnabled,
                title: l10n.certificates_paymentReminder,
                activeColor: const Color(0xFF00897B),
                onChanged: (v) async {
                  if (v) {
                    final granted =
                        await NotificationPermissions.ensure(context);
                    if (!granted) return;
                  }
                  setState(() => _reminderEnabled = v);
                },
                expandedContent: Column(
                  children: [
                    // Reminder Time Picker Row
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        final parts = _reminderTime.split(':');
                        final initialTime = TimeOfDay(
                          hour: int.tryParse(parts.first) ?? 9,
                          minute: parts.length > 1
                              ? (int.tryParse(parts[1]) ?? 0)
                              : 0,
                        );
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: initialTime,
                        );
                        if (picked != null) {
                          final formatted =
                              '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                          setState(() => _reminderTime = formatted);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded,
                                    size: 20,
                                    color: const Color(0xFF00897B)),
                                const SizedBox(width: 10),
                                Text(
                                  l10n.certificates_reminderTime,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00897B)
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _reminderTime,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF00897B),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 16),
                    // 2 Days Before Switch
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(
                        l10n.certificates_reminder2DaysBefore,
                        style: const TextStyle(
                            fontSize: 13.5, fontWeight: FontWeight.w600),
                      ),
                      value: _reminderEarlyEnabled,
                      activeTrackColor: const Color(0xFF00897B),
                      onChanged: (v) =>
                          setState(() => _reminderEarlyEnabled = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Notes
              TextFormField(
                initialValue: _notes,
                decoration: InputDecoration(
                  labelText: l10n.lended_person_notesOptional,
                  prefixIcon: const Icon(Icons.notes_rounded),
                ),
                maxLines: 2,
                onSaved: (val) => _notes = val?.trim() ?? '',
              ),
              const SizedBox(height: 20),

              // Save Button
              FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  _formKey.currentState!.save();

                  if (_accountId == null || _accountId!.isEmpty) {
                    showAppSnackbar(
                        context, 'Please select a linked Bank Account.');
                    return;
                  }

                  if (widget.existing == null) {
                    final cert = Certificate(
                      id: app.newId(),
                      name: _name,
                      amount: _amount,
                      currency: _currency,
                      startDate: _startDate,
                      endDate: _endDate,
                      interestRate: _interestRate,
                      collectionType: _collectionType,
                      collectionDay: _collectionDay,
                      customPayoutAmount: _customPayoutAmount,
                      accountId: _accountId!,
                      reminderEnabled: _reminderEnabled,
                      reminderTime: _reminderTime,
                      reminderEarlyEnabled: _reminderEarlyEnabled,
                      notes: _notes,
                      createdAt: DateTime.now(),
                    );
                    await app.addCertificate(cert);
                  } else {
                    final updated = widget.existing!.copyWith(
                      name: _name,
                      amount: _amount,
                      currency: _currency,
                      startDate: _startDate,
                      endDate: _endDate,
                      interestRate: _interestRate,
                      collectionType: _collectionType,
                      collectionDay: _collectionDay,
                      customPayoutAmount: _customPayoutAmount,
                      accountId: _accountId!,
                      reminderEnabled: _reminderEnabled,
                      reminderTime: _reminderTime,
                      reminderEarlyEnabled: _reminderEarlyEnabled,
                      notes: _notes,
                    );
                    await app.updateCertificate(updated);
                  }

                  if (context.mounted) Navigator.pop(context);
                },
                child: Text(
                  widget.existing == null
                      ? l10n.certificates_addCertificate
                      : l10n.accounts_saveChanges,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

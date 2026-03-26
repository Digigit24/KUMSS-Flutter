import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Transaction', flex: 2),
      const AppTableColumn(label: 'Type', width: 100),
      const AppTableColumn(label: 'College', flex: 1),
      const AppTableColumn(label: 'Amount', width: 120),
      const AppTableColumn(label: 'Date', width: 120),
      const AppTableColumn(label: 'Status', width: 100),
    ];

    final transactions = [
      ['Fee Payment - Abebe Kebede', 'Income', 'Engineering', '\u20B945,000', 'Mar 25, 2026', 'completed'],
      ['Lab Equipment Purchase', 'Expense', 'Medicine', '\u20B92,50,000', 'Mar 24, 2026', 'pending'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Transactions',
            subtitle: 'View and manage all financial transactions',
            breadcrumbs: const ['Home', 'Finance', 'Transactions'],
            actions: [
              AppButton(label: 'Export', icon: Icons.download_rounded, variant: AppButtonVariant.outlined, onPressed: () {}),
              AppButton(label: 'Add Transaction', icon: Icons.add_rounded, onPressed: () => AppFormSheet.show(
                context,
                title: 'Add Transaction',
                subtitle: 'Record a new financial transaction',
                submitLabel: 'Add Transaction',
                submitIcon: Icons.add_rounded,
                fields: [
                  TextField(decoration: const InputDecoration(labelText: 'Description', hintText: 'e.g. Fee Payment - Student Name')),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Type'),
                    items: ['Income', 'Expense'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                    onChanged: (_) {},
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'College'),
                    items: ['Engineering', 'Medicine', 'Business', 'All'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (_) {},
                  ),
                  TextField(decoration: const InputDecoration(labelText: 'Amount', hintText: 'e.g. 45000'), keyboardType: TextInputType.number),
                  TextField(decoration: const InputDecoration(labelText: 'Date', hintText: 'e.g. Mar 25, 2026')),
                ],
              )),
            ],
          ),
          AppDataTable(
            columns: columns,
            rows: transactions.map((t) => [
              Row(children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: t[1] == 'Income' ? AppColors.successSurface : AppColors.errorSurface,
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                  child: Icon(
                    t[1] == 'Income' ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                    size: 18, color: t[1] == 'Income' ? AppColors.success : AppColors.error,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(t[0], style: AppTypography.labelLarge)),
              ]),
              StatusBadge(label: t[1], color: t[1] == 'Income' ? AppColors.success : AppColors.error),
              Text(t[2], style: AppTypography.bodySmall),
              Text(t[3], style: AppTypography.labelLarge.copyWith(
                color: t[1] == 'Income' ? AppColors.success : AppColors.error,
              )),
              Text(t[4], style: AppTypography.bodySmall),
              StatusBadge(
                label: t[5] == 'completed' ? 'Completed' : 'Pending',
                color: t[5] == 'completed' ? AppColors.success : AppColors.warning,
              ),
            ]).toList(),
            totalItems: transactions.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

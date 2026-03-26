import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Expense', flex: 2),
      const AppTableColumn(label: 'Category', flex: 1),
      const AppTableColumn(label: 'College', flex: 1),
      const AppTableColumn(label: 'Amount', width: 120),
      const AppTableColumn(label: 'Date', width: 120),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final expenses = [
      ['Office Supplies Purchase', 'Administrative', 'Engineering', '\u20B915,400', 'Mar 25, 2026'],
      ['Internet Bill - March', 'Utilities', 'All', '\u20B91,20,000', 'Mar 22, 2026'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Other Expenses',
            subtitle: 'Track miscellaneous expenses',
            breadcrumbs: const ['Home', 'Finance', 'Other Expenses'],
            actions: [AppButton(label: 'Add Expense', icon: Icons.add_rounded, onPressed: () => AppFormSheet.show(
              context,
              title: 'Add Expense',
              subtitle: 'Record a new expense',
              submitLabel: 'Add Expense',
              submitIcon: Icons.add_rounded,
              fields: [
                TextField(decoration: const InputDecoration(labelText: 'Expense Title', hintText: 'e.g. Office Supplies Purchase')),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: ['Administrative', 'Utilities', 'Maintenance', 'Travel', 'Equipment'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (_) {},
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'College'),
                  items: ['Engineering', 'Medicine', 'Business', 'All'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (_) {},
                ),
                TextField(decoration: const InputDecoration(labelText: 'Amount', hintText: 'e.g. 15400'), keyboardType: TextInputType.number),
                TextField(decoration: const InputDecoration(labelText: 'Date', hintText: 'e.g. Mar 25, 2026')),
              ],
            ))],
          ),
          AppDataTable(
            columns: columns,
            rows: expenses.map((e) => [
              Text(e[0], style: AppTypography.labelLarge),
              StatusBadge(label: e[1], color: AppColors.info),
              Text(e[2], style: AppTypography.bodySmall),
              Text(e[3], style: AppTypography.labelLarge.copyWith(color: AppColors.error)),
              Text(e[4], style: AppTypography.bodySmall),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
              ]),
            ]).toList(),
            totalItems: expenses.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

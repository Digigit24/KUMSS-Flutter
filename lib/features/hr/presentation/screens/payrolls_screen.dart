import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class PayrollsScreen extends StatelessWidget {
  const PayrollsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Payroll', flex: 2),
      const AppTableColumn(label: 'Period', width: 120),
      const AppTableColumn(label: 'Employees', width: 100),
      const AppTableColumn(label: 'Gross', width: 120),
      const AppTableColumn(label: 'Net', width: 120),
      const AppTableColumn(label: 'Status', width: 110),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final payrolls = [
      ['March 2026 - All Staff', 'Mar 2026', '156', '\u20B948,50,000', '\u20B939,20,000', 'draft'],
      ['February 2026 - All Staff', 'Feb 2026', '156', '\u20B948,00,000', '\u20B938,80,000', 'completed'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Payrolls',
            subtitle: 'Generate and process monthly payrolls',
            breadcrumbs: const ['Home', 'HR', 'Payrolls'],
            actions: [AppButton(label: 'Generate Payroll', icon: Icons.add_rounded, onPressed: () => AppFormSheet.show(
              context,
              title: 'Generate Payroll',
              subtitle: 'Generate monthly payroll for employees',
              submitLabel: 'Generate Payroll',
              submitIcon: Icons.play_arrow_rounded,
              fields: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Month'),
                  items: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                  onChanged: (_) {},
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Year'),
                  items: ['2024', '2025', '2026'].map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                  onChanged: (_) {},
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'College'),
                  items: ['All', 'Engineering', 'Medicine'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (_) {},
                ),
              ],
            ))],
          ),
          AppDataTable(
            columns: columns,
            rows: payrolls.map((p) => [
              Text(p[0], style: AppTypography.labelLarge),
              Text(p[1], style: AppTypography.bodySmall),
              Text(p[2], style: AppTypography.bodySmall),
              Text(p[3], style: AppTypography.bodySmall),
              Text(p[4], style: AppTypography.labelLarge.copyWith(color: AppColors.success)),
              StatusBadge(label: (p[5] as String)[0].toUpperCase() + (p[5] as String).substring(1),
                color: p[5] == 'completed' ? AppColors.success : p[5] == 'processed' ? AppColors.info : AppColors.warning),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.visibility_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                if (p[5] == 'draft') IconButton(icon: const Icon(Icons.play_arrow_rounded, size: 18), onPressed: () {}, tooltip: 'Process', style: IconButton.styleFrom(foregroundColor: AppColors.success)),
              ]),
            ]).toList(),
            totalItems: payrolls.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

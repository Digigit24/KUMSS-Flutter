import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class DeductionsScreen extends StatelessWidget {
  const DeductionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Deduction', flex: 2),
      const AppTableColumn(label: 'Type', width: 120),
      const AppTableColumn(label: 'Rate / Amount', width: 130),
      const AppTableColumn(label: 'Applies To', flex: 1),
      const AppTableColumn(label: 'Status', width: 100),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final deductions = [
      ['Provident Fund (PF)', 'Percentage', '12%', 'All Employees', true],
      ['Professional Tax', 'Fixed', '\u20B9200/month', 'All Employees', true],
      ['TDS', 'Percentage', 'As per slab', 'All Employees', true],
      ['ESI', 'Percentage', '0.75%', 'Below \u20B921,000', true],
      ['Loan Recovery', 'Fixed', 'Variable', 'Selected Staff', true],
      ['Insurance Premium', 'Fixed', '\u20B9500/month', 'Opted-in Staff', false],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Deductions',
            subtitle: 'Configure payroll deductions',
            breadcrumbs: const ['Home', 'HR', 'Deductions'],
            actions: [AppButton(label: 'Add Deduction', icon: Icons.add_rounded, onPressed: () {})],
          ),
          AppDataTable(
            columns: columns,
            rows: deductions.map((d) => [
              Text(d[0] as String, style: AppTypography.labelLarge),
              StatusBadge(label: d[1] as String, color: d[1] == 'Percentage' ? AppColors.accent : AppColors.secondary),
              Text(d[2] as String, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
              Text(d[3] as String, style: AppTypography.bodySmall),
              d[4] as bool ? StatusBadge.active() : StatusBadge.inactive(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
              ]),
            ]).toList(),
            totalItems: deductions.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

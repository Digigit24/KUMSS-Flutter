import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class PayslipsScreen extends StatelessWidget {
  const PayslipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Employee', flex: 2),
      const AppTableColumn(label: 'Department', flex: 1),
      const AppTableColumn(label: 'Period', width: 100),
      const AppTableColumn(label: 'Gross', width: 110),
      const AppTableColumn(label: 'Deductions', width: 110),
      const AppTableColumn(label: 'Net Pay', width: 110),
      const AppTableColumn(label: 'Actions', width: 80, textAlign: TextAlign.center),
    ];

    final payslips = [
      ['Dr. Abebe Kebede', 'CSE', 'Feb 2026', '\u20B91,20,000', '\u20B928,000', '\u20B992,000'],
      ['Fatima Hassan', 'Admin', 'Feb 2026', '\u20B985,000', '\u20B918,500', '\u20B966,500'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Payslips',
            subtitle: 'Access and distribute employee payslips',
            breadcrumbs: const ['Home', 'HR', 'Payslips'],
            actions: [AppButton(label: 'Bulk Download', icon: Icons.download_rounded, variant: AppButtonVariant.outlined, onPressed: () {})],
          ),
          AppDataTable(
            columns: columns,
            rows: payslips.map((p) => [
              Text(p[0], style: AppTypography.labelLarge),
              Text(p[1], style: AppTypography.bodySmall),
              Text(p[2], style: AppTypography.bodySmall),
              Text(p[3], style: AppTypography.bodySmall),
              Text(p[4], style: AppTypography.bodySmall.copyWith(color: AppColors.error)),
              Text(p[5], style: AppTypography.labelLarge.copyWith(color: AppColors.success)),
              IconButton(icon: const Icon(Icons.download_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.accent)),
            ]).toList(),
            totalItems: payslips.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

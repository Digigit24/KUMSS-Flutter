import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class AcademicYearsScreen extends StatelessWidget {
  const AcademicYearsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Academic Year', flex: 2),
      const AppTableColumn(label: 'Start Date', width: 120),
      const AppTableColumn(label: 'End Date', width: 120),
      const AppTableColumn(label: 'Sessions', width: 90),
      const AppTableColumn(label: 'Status', width: 100),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final years = [
      ['2025-26', 'Jul 1, 2025', 'Jun 30, 2026', '2', 'active'],
      ['2024-25', 'Jul 1, 2024', 'Jun 30, 2025', '2', 'completed'],
      ['2023-24', 'Jul 1, 2023', 'Jun 30, 2024', '2', 'completed'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Academic Years',
            subtitle: 'Define academic year periods',
            breadcrumbs: const ['Home', 'Settings', 'Academic Years'],
            actions: [AppButton(label: 'Add Year', icon: Icons.add_rounded, onPressed: () {})],
          ),
          AppDataTable(
            columns: columns,
            rows: years.map((y) => [
              Text(y[0], style: AppTypography.h4),
              Text(y[1], style: AppTypography.bodySmall),
              Text(y[2], style: AppTypography.bodySmall),
              Text(y[3], style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
              StatusBadge(label: y[4] == 'active' ? 'Active' : 'Completed', color: y[4] == 'active' ? AppColors.success : AppColors.textTertiary),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
              ]),
            ]).toList(),
            totalItems: years.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

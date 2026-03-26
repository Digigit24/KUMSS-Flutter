import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Class', flex: 2),
      const AppTableColumn(label: 'Program', flex: 1),
      const AppTableColumn(label: 'Year / Batch', width: 120),
      const AppTableColumn(label: 'Sections', width: 80),
      const AppTableColumn(label: 'Students', width: 100),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final classes = [
      ['B.Tech CSE - Year 1', 'B.Tech CS', '2025-26', '2', '120'],
      ['MBBS - Year 1', 'MBBS', '2025-26', '1', '90'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        PageHeader(title: 'Classes', subtitle: 'Set up class batches and year groups', breadcrumbs: const ['Home', 'Academic', 'Classes'],
          actions: [AppButton(label: 'Add Class', icon: Icons.add_rounded, onPressed: () {})]),
        AppDataTable(
          columns: columns,
          rows: classes.map((c) => [
            Text(c[0], style: AppTypography.labelLarge),
            Text(c[1], style: AppTypography.bodySmall),
            StatusBadge.info(label: c[2]),
            Text(c[3], style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
            Text(c[4], style: AppTypography.bodySmall),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
              IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
            ]),
          ]).toList(),
          totalItems: classes.length, onSearch: (_) {},
        ),
      ]),
    );
  }
}

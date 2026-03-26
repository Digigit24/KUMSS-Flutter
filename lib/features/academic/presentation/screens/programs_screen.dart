import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Program', flex: 2),
      const AppTableColumn(label: 'Faculty', flex: 1),
      const AppTableColumn(label: 'Duration', width: 100),
      const AppTableColumn(label: 'Students', width: 100),
      const AppTableColumn(label: 'Status', width: 100),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final programs = [
      ['B.Tech Computer Science', 'Computing & Informatics', '4 Years', '620', true],
      ['MBBS', 'Clinical Sciences', '5.5 Years', '380', true],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        PageHeader(title: 'Programs', subtitle: 'Manage degree and diploma programs', breadcrumbs: const ['Home', 'Academic', 'Programs'],
          actions: [AppButton(label: 'Add Program', icon: Icons.add_rounded, onPressed: () {})]),
        AppDataTable(
          columns: columns,
          rows: programs.map((p) => [
            Row(children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.accentSurface, borderRadius: AppSpacing.borderRadiusMd), child: const Icon(Icons.menu_book_rounded, size: 18, color: AppColors.accent)),
              const SizedBox(width: 10),
              Expanded(child: Text(p[0] as String, style: AppTypography.labelLarge)),
            ]),
            Text(p[1] as String, style: AppTypography.bodySmall),
            Text(p[2] as String, style: AppTypography.bodySmall),
            Text(p[3] as String, style: AppTypography.bodySmall),
            p[4] as bool ? StatusBadge.active() : StatusBadge.inactive(),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
              IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
            ]),
          ]).toList(),
          totalItems: programs.length, onSearch: (_) {},
        ),
      ]),
    );
  }
}

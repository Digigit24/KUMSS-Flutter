import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class SectionsScreen extends StatelessWidget {
  const SectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Section', flex: 1),
      const AppTableColumn(label: 'Class', flex: 2),
      const AppTableColumn(label: 'Class Teacher', flex: 1),
      const AppTableColumn(label: 'Capacity', width: 90),
      const AppTableColumn(label: 'Enrolled', width: 90),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final sections = [
      ['A', 'B.Tech CSE - Year 1', 'Dr. A. Verma', '60', '58'],
      ['B', 'B.Tech CSE - Year 1', 'Prof. B. Rao', '60', '62'],
      ['C', 'B.Tech CSE - Year 1', 'Dr. C. Kumar', '60', '60'],
      ['A', 'B.Tech CSE - Year 2', 'Dr. D. Reddy', '60', '55'],
      ['B', 'B.Tech CSE - Year 2', 'Prof. E. Nair', '60', '59'],
      ['A', 'MBA - Year 1', 'Dr. F. Mehta', '60', '58'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Sections',
            subtitle: 'Divide classes into sections',
            breadcrumbs: const ['Home', 'Academic', 'Sections'],
            actions: [AppButton(label: 'Add Section', icon: Icons.add_rounded, onPressed: () {})],
          ),
          AppDataTable(
            columns: columns,
            rows: sections.map((s) => [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: AppSpacing.borderRadiusSm),
                child: Center(child: Text(s[0], style: AppTypography.labelLarge.copyWith(color: AppColors.primary))),
              ),
              Text(s[1], style: AppTypography.bodySmall),
              Text(s[2], style: AppTypography.bodySmall),
              Text(s[3], style: AppTypography.bodySmall),
              Text(s[4], style: AppTypography.bodySmall.copyWith(
                color: int.parse(s[4]) > int.parse(s[3]) ? AppColors.error : AppColors.success,
                fontWeight: FontWeight.w600,
              )),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
              ]),
            ]).toList(),
            totalItems: sections.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

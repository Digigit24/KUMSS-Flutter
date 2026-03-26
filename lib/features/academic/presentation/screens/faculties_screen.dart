import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class FacultiesScreen extends StatelessWidget {
  const FacultiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Faculty', flex: 2),
      const AppTableColumn(label: 'College', flex: 1),
      const AppTableColumn(label: 'Dean', flex: 1),
      const AppTableColumn(label: 'Programs', width: 100),
      const AppTableColumn(label: 'Status', width: 100),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final faculties = [
      ['Faculty of Computing', 'Engineering', 'Dr. A. Verma', '4', true],
      ['Faculty of Civil', 'Engineering', 'Prof. B. Rao', '3', true],
      ['Faculty of Clinical Sciences', 'Medicine', 'Dr. C. Reddy', '5', true],
      ['Faculty of Management', 'Business', 'Dr. D. Mehta', '6', true],
      ['Faculty of Criminal Law', 'Law', 'Prof. E. Singh', '2', true],
      ['Faculty of Natural Sciences', 'Science', 'Dr. F. Nair', '4', false],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Faculties',
            subtitle: 'Manage academic faculties across colleges',
            breadcrumbs: const ['Home', 'Academic', 'Faculties'],
            actions: [AppButton(label: 'Add Faculty', icon: Icons.add_rounded, onPressed: () {})],
          ),
          AppDataTable(
            columns: columns,
            rows: faculties.map((f) => [
              Row(children: [
                Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: AppSpacing.borderRadiusMd), child: const Icon(Icons.domain_rounded, size: 18, color: AppColors.primary)),
                const SizedBox(width: 10),
                Expanded(child: Text(f[0] as String, style: AppTypography.labelLarge)),
              ]),
              Text(f[1] as String, style: AppTypography.bodySmall),
              Text(f[2] as String, style: AppTypography.bodySmall),
              Text(f[3] as String, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
              f[4] as bool ? StatusBadge.active() : StatusBadge.inactive(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
              ]),
            ]).toList(),
            totalItems: faculties.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

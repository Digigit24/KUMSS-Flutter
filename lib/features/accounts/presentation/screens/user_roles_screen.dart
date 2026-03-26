import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class UserRolesScreen extends StatelessWidget {
  const UserRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'User', flex: 2),
      const AppTableColumn(label: 'Role', flex: 1),
      const AppTableColumn(label: 'College', flex: 1),
      const AppTableColumn(label: 'Primary', width: 80),
      const AppTableColumn(label: 'Expires', width: 120),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final assignments = [
      ['Dr. Abebe Kebede', 'Teacher', 'Engineering', true, 'Never'],
      ['Fatima Hassan', 'College Admin', 'Medicine', true, 'Never'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        PageHeader(title: 'User-Role Assignments', subtitle: 'Map users to roles with college-level scoping', breadcrumbs: const ['Home', 'Accounts', 'User Roles'],
          actions: [AppButton(label: 'Assign Role', icon: Icons.add_rounded, onPressed: () {})]),
        AppDataTable(
          columns: columns,
          rows: assignments.map((a) => [
            Text(a[0] as String, style: AppTypography.labelLarge),
            StatusBadge.info(label: a[1] as String),
            Text(a[2] as String, style: AppTypography.bodySmall),
            Icon((a[3] as bool) ? Icons.star_rounded : Icons.star_border_rounded, size: 18, color: (a[3] as bool) ? AppColors.secondary : AppColors.textTertiary),
            Text(a[4] as String, style: AppTypography.bodySmall),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
              IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
            ]),
          ]).toList(),
          totalItems: assignments.length, onSearch: (_) {},
        ),
      ]),
    );
  }
}

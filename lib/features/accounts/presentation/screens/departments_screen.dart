import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class DepartmentsScreen extends StatelessWidget {
  const DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Department', flex: 2),
      const AppTableColumn(label: 'College', flex: 1),
      const AppTableColumn(label: 'Head', flex: 1),
      const AppTableColumn(label: 'Members', width: 100),
      const AppTableColumn(label: 'Status', width: 100),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final departments = [
      ['Computer Science & Engineering', 'Engineering', 'Dr. Abebe Kebede', '45', true],
      ['Internal Medicine', 'Medicine', 'Dr. Sara Tadesse', '52', true],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        PageHeader(title: 'Department Management', subtitle: 'Create and manage organizational departments', breadcrumbs: const ['Home', 'Accounts', 'Departments'],
          actions: [AppButton(label: 'Add Department', icon: Icons.add_rounded, onPressed: () => AppFormSheet.show(
            context,
            title: 'Add Department',
            subtitle: 'Create a new organizational department',
            submitLabel: 'Create Department',
            submitIcon: Icons.add_rounded,
            fields: [
              TextField(decoration: const InputDecoration(labelText: 'Department Name', hintText: 'e.g. Computer Science & Engineering')),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'College'),
                items: ['Engineering', 'Medicine', 'Business', 'Law'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (_) {},
              ),
              TextField(decoration: const InputDecoration(labelText: 'Head', hintText: 'e.g. Dr. Abebe Kebede')),
            ],
          ))]),
        AppDataTable(
          columns: columns,
          rows: departments.map((d) => [
            Row(children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.accentSurface, borderRadius: AppSpacing.borderRadiusMd), child: const Icon(Icons.corporate_fare_rounded, size: 18, color: AppColors.accent)),
              const SizedBox(width: 10),
              Expanded(child: Text(d[0] as String, style: AppTypography.labelLarge)),
            ]),
            Text(d[1] as String, style: AppTypography.bodySmall),
            Text(d[2] as String, style: AppTypography.bodySmall),
            Text(d[3] as String, style: AppTypography.bodySmall),
            d[4] as bool ? StatusBadge.active() : StatusBadge.inactive(),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
              IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
            ]),
          ]).toList(),
          totalItems: departments.length, onSearch: (_) {},
        ),
      ]),
    );
  }
}

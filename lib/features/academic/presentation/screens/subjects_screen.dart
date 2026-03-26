import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Subject', flex: 2),
      const AppTableColumn(label: 'Code', width: 100),
      const AppTableColumn(label: 'Program', flex: 1),
      const AppTableColumn(label: 'Credits', width: 80),
      const AppTableColumn(label: 'Type', width: 100),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final subjects = [
      ['Data Structures & Algorithms', 'CS201', 'B.Tech CS', '4', 'Core'],
      ['Human Anatomy', 'MD101', 'MBBS', '5', 'Core'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        PageHeader(title: 'Subjects', subtitle: 'Maintain the subject catalog', breadcrumbs: const ['Home', 'Academic', 'Subjects'],
          actions: [AppButton(label: 'Add Subject', icon: Icons.add_rounded, onPressed: () => AppFormSheet.show(
            context,
            title: 'Add Subject',
            subtitle: 'Add a new subject to the catalog',
            submitLabel: 'Create Subject',
            submitIcon: Icons.add_rounded,
            fields: [
              TextField(decoration: const InputDecoration(labelText: 'Subject Name', hintText: 'e.g. Data Structures & Algorithms')),
              TextField(decoration: const InputDecoration(labelText: 'Subject Code', hintText: 'e.g. CS201')),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Program'),
                items: ['B.Tech CS', 'MBBS', 'MBA', 'B.Tech EE'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (_) {},
              ),
              TextField(decoration: const InputDecoration(labelText: 'Credits', hintText: 'e.g. 4'), keyboardType: TextInputType.number),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Type'),
                items: ['Core', 'Elective'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (_) {},
              ),
            ],
          ))]),
        AppDataTable(
          columns: columns,
          rows: subjects.map((s) => [
            Text(s[0], style: AppTypography.labelLarge),
            Text(s[1], style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600, color: AppColors.accent)),
            Text(s[2], style: AppTypography.bodySmall),
            Text(s[3], style: AppTypography.bodySmall),
            StatusBadge(label: s[4], color: s[4] == 'Core' ? AppColors.info : AppColors.secondary),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
              IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
            ]),
          ]).toList(),
          totalItems: subjects.length, onSearch: (_) {},
        ),
      ]),
    );
  }
}

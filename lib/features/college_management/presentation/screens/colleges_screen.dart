import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class CollegesScreen extends StatelessWidget {
  const CollegesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;
    final columns = [
      const AppTableColumn(label: 'College', flex: 2),
      const AppTableColumn(label: 'Code', width: 80),
      const AppTableColumn(label: 'Students', width: 80),
      const AppTableColumn(label: 'Status', width: 80),
      const AppTableColumn(label: 'Actions', width: 80, textAlign: TextAlign.center),
    ];

    final colleges = [
      ['College of Engineering', 'COE', '1,240', true],
      ['College of Medicine', 'COM', '1,100', true],
    ];

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'College Management',
            subtitle: 'Manage all colleges in the institution',
            breadcrumbs: const ['Home', 'Core', 'Colleges'],
            actions: [AppButton(label: 'Add College', icon: Icons.add_rounded, onPressed: () => _showCollegeDialog(context))],
          ),
          ResponsiveGrid(
            children: [
              MetricCard(label: 'Total Colleges', value: '2', icon: Icons.apartment_rounded, iconColor: AppColors.accent, iconBgColor: AppColors.accentSurface),
              MetricCard(label: 'Active', value: '2', icon: Icons.check_circle_rounded, iconColor: AppColors.success, iconBgColor: AppColors.successSurface),
              MetricCard(label: 'Inactive', value: '0', icon: Icons.pause_circle_rounded, iconColor: AppColors.textTertiary, iconBgColor: AppColors.surfaceVariant),
              MetricCard(label: 'Total Students', value: '2,340', icon: Icons.people_rounded, iconColor: AppColors.info, iconBgColor: AppColors.infoSurface),
            ],
          ),
          const SizedBox(height: 20),
          AppDataTable(
            columns: columns,
            rows: colleges.map((c) => [
              Text(c[0] as String, style: AppTypography.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(c[1] as String, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
              Text(c[2] as String, style: AppTypography.bodySmall),
              c[3] as bool ? StatusBadge.active() : StatusBadge.inactive(),
              Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 16), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 32, minHeight: 32), style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 16), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 32, minHeight: 32), style: IconButton.styleFrom(foregroundColor: AppColors.error)),
              ]),
            ]).toList(),
            totalItems: colleges.length,
            onSearch: (_) {},
            searchHint: 'Search colleges...',
          ),
        ],
      ),
    );
  }

  void _showCollegeDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('Add New College'),
      content: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 400), child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(decoration: const InputDecoration(labelText: 'College Name', hintText: 'e.g. College of Engineering')),
        const SizedBox(height: 16),
        TextField(decoration: const InputDecoration(labelText: 'College Code', hintText: 'e.g. COE')),
        const SizedBox(height: 16),
        TextField(decoration: const InputDecoration(labelText: 'Short Name', hintText: 'e.g. Engineering')),
      ])),
      actions: [
        OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Create')),
      ],
    ));
  }
}

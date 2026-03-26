import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class CollegesScreen extends StatelessWidget {
  const CollegesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'College', flex: 2),
      const AppTableColumn(label: 'Code', width: 100),
      const AppTableColumn(label: 'Short Name', flex: 1),
      const AppTableColumn(label: 'Students', width: 100),
      const AppTableColumn(label: 'Status', width: 100),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final colleges = [
      ['College of Engineering', 'COE', 'Engineering', '1,240', true],
      ['College of Medicine', 'COM', 'Medicine', '1,100', true],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'College Management',
            subtitle: 'Manage all colleges in the institution',
            breadcrumbs: const ['Home', 'Core', 'Colleges'],
            actions: [
              AppButton(label: 'Add College', icon: Icons.add_rounded, onPressed: () => _showCollegeDialog(context)),
            ],
          ),
          Row(
            children: [
              _buildStat('Total Colleges', '2', Icons.apartment_rounded, AppColors.accent),
              const SizedBox(width: 16),
              _buildStat('Active', '2', Icons.check_circle_rounded, AppColors.success),
              const SizedBox(width: 16),
              _buildStat('Inactive', '0', Icons.pause_circle_rounded, AppColors.textTertiary),
              const SizedBox(width: 16),
              _buildStat('Total Students', '2,340', Icons.people_rounded, AppColors.info),
            ].map((w) => Expanded(child: w)).toList(),
          ),
          const SizedBox(height: 24),
          AppDataTable(
            columns: columns,
            rows: colleges.map((c) => [
              Row(children: [
                Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: AppSpacing.borderRadiusMd), child: const Icon(Icons.apartment_rounded, size: 18, color: AppColors.primary)),
                const SizedBox(width: 10),
                Expanded(child: Text(c[0] as String, style: AppTypography.labelLarge)),
              ]),
              Text(c[1] as String, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
              Text(c[2] as String, style: AppTypography.bodySmall),
              Text(c[3] as String, style: AppTypography.bodySmall),
              c[4] as bool ? StatusBadge.active() : StatusBadge.inactive(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, tooltip: 'Edit', style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, tooltip: 'Delete', style: IconButton.styleFrom(foregroundColor: AppColors.error)),
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

  Widget _buildStat(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppSpacing.borderRadiusLg, border: Border.all(color: AppColors.border)),
      child: Row(children: [
        Container(width: 40, height: 40, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusMd), child: Icon(icon, size: 20, color: color)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: AppTypography.metricSmall),
          Text(label, style: AppTypography.caption),
        ]),
      ]),
    );
  }

  void _showCollegeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add New College'),
        content: SizedBox(width: 480, child: Column(mainAxisSize: MainAxisSize.min, children: [
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
      ),
    );
  }
}

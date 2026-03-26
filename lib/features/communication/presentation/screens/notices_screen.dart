import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Notice', flex: 3),
      const AppTableColumn(label: 'Published', width: 120),
      const AppTableColumn(label: 'Target', flex: 1),
      const AppTableColumn(label: 'Priority', width: 100),
      const AppTableColumn(label: 'Status', width: 100),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final notices = [
      ['Exam Schedule for April 2026', 'Mar 25, 2026', 'All Students', 'high', 'Published'],
      ['Fee Payment Deadline Extended', 'Mar 23, 2026', 'All', 'urgent', 'Published'],
      ['Campus Wi-Fi Maintenance', 'Mar 22, 2026', 'All', 'medium', 'Published'],
      ['Library Extended Hours', 'Mar 20, 2026', 'All Students', 'low', 'Draft'],
      ['Summer Internship Opportunities', 'Mar 18, 2026', 'Engineering', 'medium', 'Published'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Notices',
            subtitle: 'Broadcast notices to users',
            breadcrumbs: const ['Home', 'Communication', 'Notices'],
            actions: [AppButton(label: 'Create Notice', icon: Icons.add_rounded, onPressed: () {})],
          ),
          AppDataTable(
            columns: columns,
            rows: notices.map((n) => [
              Row(children: [
                Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.warningSurface, borderRadius: AppSpacing.borderRadiusMd), child: const Icon(Icons.campaign_rounded, size: 18, color: AppColors.warning)),
                const SizedBox(width: 10),
                Expanded(child: Text(n[0], style: AppTypography.labelLarge)),
              ]),
              Text(n[1], style: AppTypography.bodySmall),
              Text(n[2], style: AppTypography.bodySmall),
              StatusBadge.priority(n[3]),
              StatusBadge(label: n[4], color: n[4] == 'Published' ? AppColors.success : AppColors.textTertiary),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
              ]),
            ]).toList(),
            totalItems: notices.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

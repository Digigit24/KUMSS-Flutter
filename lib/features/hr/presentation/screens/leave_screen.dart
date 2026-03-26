import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Employee', flex: 2),
      const AppTableColumn(label: 'Type', width: 120),
      const AppTableColumn(label: 'From', width: 110),
      const AppTableColumn(label: 'To', width: 110),
      const AppTableColumn(label: 'Days', width: 60),
      const AppTableColumn(label: 'Status', width: 100),
      const AppTableColumn(label: 'Actions', width: 120, textAlign: TextAlign.center),
    ];

    final leaves = [
      ['Dr. Abebe Kebede', 'Sick Leave', 'Mar 26', 'Mar 27', '2', 'pending'],
      ['Fatima Hassan', 'Earned Leave', 'Apr 1', 'Apr 5', '5', 'approved'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Leave Management',
            subtitle: 'Manage leave types, requests, and approvals',
            breadcrumbs: const ['Home', 'HR', 'Leave'],
            actions: [AppButton(label: 'Leave Types', icon: Icons.settings_rounded, variant: AppButtonVariant.outlined, onPressed: () {})],
          ),
          AppDataTable(
            columns: columns,
            rows: leaves.map((l) => [
              Text(l[0], style: AppTypography.labelLarge),
              StatusBadge(label: l[1], color: l[1] == 'Sick Leave' ? AppColors.error : l[1] == 'Casual Leave' ? AppColors.info : AppColors.success),
              Text(l[2], style: AppTypography.bodySmall),
              Text(l[3], style: AppTypography.bodySmall),
              Text(l[4], style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
              l[5] == 'approved' ? StatusBadge.approved() : l[5] == 'rejected' ? StatusBadge.rejected() : StatusBadge.pending(),
              l[5] == 'pending'
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(icon: const Icon(Icons.check_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.success)),
                    IconButton(icon: const Icon(Icons.close_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
                  ])
                : const SizedBox(),
            ]).toList(),
            totalItems: leaves.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class ActivityLogsScreen extends StatelessWidget {
  const ActivityLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    final columns = [
      const AppTableColumn(label: 'Action', flex: 2),
      const AppTableColumn(label: 'User', flex: 1),
      const AppTableColumn(label: 'Module', width: 120),
      const AppTableColumn(label: 'College', flex: 1),
      const AppTableColumn(label: 'IP Address', width: 130),
      const AppTableColumn(label: 'Time', width: 140),
    ];

    final logs = [
      ['Created new student record', 'Super Admin', 'Students', 'Engineering', '192.168.1.100', 'Mar 26, 10:30 AM'],
      ['Approved indent #1024', 'Super Admin', 'Store', 'Medicine', '192.168.1.100', 'Mar 26, 10:15 AM'],
    ];

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Activity Logs',
            subtitle: 'Complete audit trail of all actions',
            breadcrumbs: const ['Home', 'Settings', 'Activity Logs'],
            actions: [
              AppButton(label: 'Export Logs', icon: Icons.download_rounded, variant: AppButtonVariant.outlined, onPressed: () {}),
            ],
          ),
          // Filters
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: isMobile
                ? Column(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Module', isDense: true),
                        items: ['All Modules', 'Auth', 'Students', 'Store', 'HR', 'Academic', 'Core']
                          .map((m) => DropdownMenuItem(value: m, child: Text(m, style: AppTypography.bodySmall))).toList(),
                        onChanged: (_) {},
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'User', isDense: true),
                        items: ['All Users', 'Super Admin', 'Amit Kumar', 'Dr. Rahul S.', 'Priya Patel']
                          .map((u) => DropdownMenuItem(value: u, child: Text(u, style: AppTypography.bodySmall))).toList(),
                        onChanged: (_) {},
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Date Range', isDense: true),
                        items: ['Today', 'Last 7 Days', 'Last 30 Days', 'Custom']
                          .map((d) => DropdownMenuItem(value: d, child: Text(d, style: AppTypography.bodySmall))).toList(),
                        onChanged: (_) {},
                      ),
                    ],
                  )
                : Row(
                    children: [
                      SizedBox(width: 200, child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Module', isDense: true),
                        items: ['All Modules', 'Auth', 'Students', 'Store', 'HR', 'Academic', 'Core']
                          .map((m) => DropdownMenuItem(value: m, child: Text(m, style: AppTypography.bodySmall))).toList(),
                        onChanged: (_) {},
                      )),
                      const SizedBox(width: 12),
                      SizedBox(width: 200, child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'User', isDense: true),
                        items: ['All Users', 'Super Admin', 'Amit Kumar', 'Dr. Rahul S.', 'Priya Patel']
                          .map((u) => DropdownMenuItem(value: u, child: Text(u, style: AppTypography.bodySmall))).toList(),
                        onChanged: (_) {},
                      )),
                      const SizedBox(width: 12),
                      SizedBox(width: 200, child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Date Range', isDense: true),
                        items: ['Today', 'Last 7 Days', 'Last 30 Days', 'Custom']
                          .map((d) => DropdownMenuItem(value: d, child: Text(d, style: AppTypography.bodySmall))).toList(),
                        onChanged: (_) {},
                      )),
                    ],
                  ),
          ),
          AppDataTable(
            columns: columns,
            rows: logs.map((l) => [
              Row(children: [
                Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    color: l[2] == 'Auth' ? AppColors.info : l[2] == 'Store' ? AppColors.success : AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(l[0], style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
              ]),
              Text(l[1], style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              StatusBadge(label: l[2], color: AppColors.info),
              Text(l[3], style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(l[4], style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(l[5], style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
            ]).toList(),
            totalItems: logs.length,
            onSearch: (_) {},
            searchHint: 'Search logs...',
          ),
        ],
      ),
    );
  }
}

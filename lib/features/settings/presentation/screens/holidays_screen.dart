import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class HolidaysScreen extends StatelessWidget {
  const HolidaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Holiday', flex: 2),
      const AppTableColumn(label: 'Date', width: 130),
      const AppTableColumn(label: 'Day', width: 100),
      const AppTableColumn(label: 'Type', width: 120),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final holidays = [
      ['Republic Day', 'Jan 26, 2026', 'Monday', 'National'],
      ['Holi', 'Mar 10, 2026', 'Tuesday', 'Festival'],
      ['Good Friday', 'Apr 3, 2026', 'Friday', 'Religious'],
      ['May Day', 'May 1, 2026', 'Friday', 'National'],
      ['Independence Day', 'Aug 15, 2026', 'Saturday', 'National'],
      ['Gandhi Jayanti', 'Oct 2, 2026', 'Friday', 'National'],
      ['Diwali', 'Oct 20, 2026', 'Tuesday', 'Festival'],
      ['Christmas', 'Dec 25, 2026', 'Friday', 'Festival'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Holiday Calendar',
            subtitle: 'Define holidays for academic calendar',
            breadcrumbs: const ['Home', 'Settings', 'Holidays'],
            actions: [AppButton(label: 'Add Holiday', icon: Icons.add_rounded, onPressed: () {})],
          ),
          AppDataTable(
            columns: columns,
            rows: holidays.map((h) => [
              Row(children: [
                Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.secondarySurface, borderRadius: AppSpacing.borderRadiusMd), child: const Icon(Icons.celebration_rounded, size: 18, color: AppColors.secondary)),
                const SizedBox(width: 10),
                Expanded(child: Text(h[0], style: AppTypography.labelLarge)),
              ]),
              Text(h[1], style: AppTypography.bodySmall),
              Text(h[2], style: AppTypography.bodySmall),
              StatusBadge(label: h[3], color: h[3] == 'National' ? AppColors.info : h[3] == 'Festival' ? AppColors.secondary : AppColors.accent),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
              ]),
            ]).toList(),
            totalItems: holidays.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

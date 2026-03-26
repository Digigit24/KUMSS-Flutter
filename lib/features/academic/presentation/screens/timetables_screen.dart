import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class TimetablesScreen extends StatelessWidget {
  const TimetablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    final times = ['9:00', '10:00', '11:00', '12:00', '1:00', '2:00', '3:00', '4:00'];

    final sampleSlots = {
      '0-0': _Slot('DS & Algo', 'Dr. Verma', AppColors.accent),
      '0-1': _Slot('DBMS', 'Prof. Rao', AppColors.info),
      '0-3': _Slot('ML Lab', 'Dr. Kumar', AppColors.success),
      '1-0': _Slot('DBMS', 'Prof. Rao', AppColors.info),
      '1-2': _Slot('DS & Algo', 'Dr. Verma', AppColors.accent),
      '2-1': _Slot('Networks', 'Dr. Nair', AppColors.secondary),
      '2-3': _Slot('DS & Algo', 'Dr. Verma', AppColors.accent),
      '3-0': _Slot('ML', 'Dr. Reddy', AppColors.error),
      '3-2': _Slot('Networks', 'Dr. Nair', AppColors.secondary),
      '4-1': _Slot('DBMS Lab', 'Prof. Rao', AppColors.info),
      '4-3': _Slot('ML', 'Dr. Reddy', AppColors.error),
      '5-0': _Slot('Sports', 'Coach', AppColors.success),
    };

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Timetables',
            subtitle: 'Generate and manage class schedules',
            breadcrumbs: const ['Home', 'Academic', 'Timetables'],
            actions: [
              AppButton(label: 'Auto Generate', icon: Icons.auto_fix_high_rounded, variant: AppButtonVariant.outlined, onPressed: () {}),
              AppButton(label: 'Add Slot', icon: Icons.add_rounded, onPressed: () => AppFormSheet.show(
                context,
                title: 'Add Slot',
                subtitle: 'Add a new timetable slot',
                submitLabel: 'Add Slot',
                submitIcon: Icons.add_rounded,
                fields: [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Day'),
                    items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'].map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                    onChanged: (_) {},
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Time'),
                    items: ['9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                    onChanged: (_) {},
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Subject'),
                    items: ['DS & Algo', 'DBMS', 'Networks', 'ML', 'ML Lab', 'DBMS Lab'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (_) {},
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Teacher'),
                    items: ['Dr. Verma', 'Prof. Rao', 'Dr. Kumar', 'Dr. Nair', 'Dr. Reddy'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                    onChanged: (_) {},
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Room'),
                    items: ['Room 101', 'Room 201', 'Lab 301', 'Room 102'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                    onChanged: (_) {},
                  ),
                ],
              )),
            ],
          ),
          // Class selector
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: isMobile ? double.infinity : 240,
              child: DropdownButtonFormField<String>(
                value: 'B.Tech CSE - Year 2, Section A',
                decoration: const InputDecoration(labelText: 'Select Class'),
                items: ['B.Tech CSE - Year 2, Section A', 'B.Tech CSE - Year 2, Section B', 'MBA - Year 1, Section A']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c, style: AppTypography.bodySmall, overflow: TextOverflow.ellipsis, maxLines: 1)))
                    .toList(),
                onChanged: (_) {},
              ),
            ),
          ),
          // Timetable grid
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppSpacing.borderRadiusLg,
              border: Border.all(color: AppColors.border),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 0,
                horizontalMargin: 0,
                headingRowColor: WidgetStateProperty.all(AppColors.surfaceVariant),
                columns: [
                  DataColumn(label: SizedBox(width: 100, child: Padding(padding: const EdgeInsets.all(12), child: Text('Day', style: AppTypography.overline)))),
                  ...times.map((t) => DataColumn(label: SizedBox(width: 120, child: Center(child: Text(t, style: AppTypography.overline))))),
                ],
                rows: List.generate(days.length, (dayIdx) {
                  return DataRow(
                    cells: [
                      DataCell(SizedBox(width: 100, child: Padding(padding: const EdgeInsets.all(12), child: Text(days[dayIdx], style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w600))))),
                      ...List.generate(times.length, (timeIdx) {
                        final slot = sampleSlots['$dayIdx-$timeIdx'];
                        return DataCell(
                          SizedBox(
                            width: 120,
                            child: slot != null
                                ? Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: slot.color.withValues(alpha: 0.1),
                                      borderRadius: AppSpacing.borderRadiusSm,
                                      border: Border.all(color: slot.color.withValues(alpha: 0.3)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(slot.subject, style: AppTypography.tag.copyWith(color: slot.color, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                                        Text(slot.teacher, style: AppTypography.caption.copyWith(fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        );
                      }),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Slot {
  final String subject, teacher;
  final Color color;
  const _Slot(this.subject, this.teacher, this.color);
}

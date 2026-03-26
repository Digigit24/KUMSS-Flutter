import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class ClassroomsScreen extends StatelessWidget {
  const ClassroomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    final columns = [
      const AppTableColumn(label: 'Room', flex: 1),
      const AppTableColumn(label: 'Building', flex: 1),
      const AppTableColumn(label: 'Type', width: 120),
      const AppTableColumn(label: 'Capacity', width: 90),
      const AppTableColumn(label: 'Facilities', flex: 1),
      const AppTableColumn(label: 'Status', width: 100),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final rooms = [
      ['Room 101', 'Block A', 'Lecture Hall', '120', 'Projector, AC, Mic', true],
      ['Room 201', 'Block A', 'Classroom', '60', 'Projector, AC', true],
      ['Lab 301', 'Block B', 'Computer Lab', '40', 'PCs, Projector, AC', true],
      ['Room 102', 'Block A', 'Seminar Hall', '200', 'Projector, AC, Sound System', true],
      ['Lab 401', 'Block C', 'Science Lab', '30', 'Lab Equipment, Fume Hood', false],
      ['Room 501', 'Block D', 'Classroom', '60', 'Whiteboard, AC', true],
    ];

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Classrooms',
            subtitle: 'Manage physical classrooms and venues',
            breadcrumbs: const ['Home', 'Academic', 'Classrooms'],
            actions: [AppButton(label: 'Add Room', icon: Icons.add_rounded, onPressed: () {})],
          ),
          AppDataTable(
            columns: columns,
            rows: rooms.map((r) => [
              Row(children: [
                Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.infoSurface, borderRadius: AppSpacing.borderRadiusMd), child: const Icon(Icons.meeting_room_rounded, size: 18, color: AppColors.info)),
                const SizedBox(width: 10),
                Expanded(child: Text(r[0] as String, style: AppTypography.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
              ]),
              Text(r[1] as String, style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              StatusBadge(label: r[2] as String, color: AppColors.accent),
              Text(r[3] as String, style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(r[4] as String, style: AppTypography.caption, overflow: TextOverflow.ellipsis, maxLines: 1),
              r[5] as bool ? StatusBadge.active() : StatusBadge.inactive(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
              ]),
            ]).toList(),
            totalItems: rooms.length,
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}

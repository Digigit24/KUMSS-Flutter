import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    final events = [
      _Event('Annual Sports Day', 'Apr 12, 2026', 'All Day', 'All Colleges', 450, AppColors.success, Icons.sports_rounded),
      _Event('Guest Lecture - AI in Medicine', 'Mar 30, 2026', '2:00 PM', 'Medicine', 120, AppColors.info, Icons.school_rounded),
    ];

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Events',
            subtitle: 'Create and manage events',
            breadcrumbs: const ['Home', 'Communication', 'Events'],
            actions: [AppButton(label: 'Create Event', icon: Icons.add_rounded, onPressed: () {})],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 1.4 : 1.4,
            ),
            itemCount: events.length,
            itemBuilder: (_, i) {
              final e = events[i];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppSpacing.borderRadiusLg, border: Border.all(color: AppColors.border), boxShadow: AppColors.shadowSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(width: 44, height: 44, decoration: BoxDecoration(color: e.color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusMd), child: Icon(e.icon, size: 22, color: e.color)),
                      const SizedBox(width: 12),
                      Expanded(child: Text(e.title, style: AppTypography.h4, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ]),
                    const SizedBox(height: 12),
                    Row(children: [
                      const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.textTertiary),
                      const SizedBox(width: 6),
                      Flexible(child: Text(e.date, style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
                      const SizedBox(width: 12),
                      const Icon(Icons.access_time_rounded, size: 14, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Flexible(child: Text(e.time, style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ]),
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.apartment_rounded, size: 14, color: AppColors.textTertiary),
                      const SizedBox(width: 6),
                      Flexible(child: Text(e.college, style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ]),
                    const Spacer(),
                    Row(children: [
                      const Icon(Icons.people_rounded, size: 14, color: AppColors.textTertiary),
                      const SizedBox(width: 6),
                      Flexible(child: Text('${e.registrations} registrations', style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis)),
                      const Spacer(),
                      IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                    ]),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Event {
  final String title, date, time, college;
  final int registrations;
  final Color color;
  final IconData icon;
  const _Event(this.title, this.date, this.time, this.college, this.registrations, this.color, this.icon);
}

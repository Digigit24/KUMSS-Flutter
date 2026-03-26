import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class HostelScreen extends StatelessWidget {
  const HostelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hostels = [
      _Hostel('Boys Hostel A', 'Engineering', 200, 185, 'Mr. Dawit Getachew', AppColors.accent),
      _Hostel('Girls Hostel A', 'Medicine', 180, 175, 'Mrs. Hiwot Tesfaye', AppColors.success),
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Hostel Management',
            subtitle: 'Hostel setup, room allocation, and fee management',
            breadcrumbs: const ['Home', 'Hostel'],
            actions: [AppButton(label: 'Add Hostel', icon: Icons.add_rounded, onPressed: () {})],
          ),
          Row(
            children: [
              Expanded(child: MetricCard(label: 'Total Rooms', value: '380', icon: Icons.hotel_rounded, iconColor: AppColors.accent, iconBgColor: AppColors.accentSurface)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'Occupied', value: '360', icon: Icons.bed_rounded, iconColor: AppColors.success, iconBgColor: AppColors.successSurface, trend: '95%', trendUp: true)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'Available', value: '20', icon: Icons.check_circle_rounded, iconColor: AppColors.info, iconBgColor: AppColors.infoSurface)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'Fee Collected', value: '\u20B912.5L', icon: Icons.account_balance_wallet_rounded, iconColor: AppColors.secondary, iconBgColor: AppColors.secondarySurface)),
            ],
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1.5),
            itemCount: hostels.length,
            itemBuilder: (_, i) {
              final h = hostels[i];
              final occupancy = (h.occupied / h.capacity * 100);
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppSpacing.borderRadiusLg, border: Border.all(color: AppColors.border), boxShadow: AppColors.shadowSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(width: 40, height: 40, decoration: BoxDecoration(color: h.color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusMd), child: Icon(Icons.hotel_rounded, size: 20, color: h.color)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(h.name, style: AppTypography.h4),
                        Text(h.college, style: AppTypography.caption),
                      ])),
                    ]),
                    const SizedBox(height: 12),
                    Text('Warden: ${h.warden}', style: AppTypography.bodySmall),
                    const Spacer(),
                    Row(children: [
                      Text('${h.occupied}/${h.capacity} rooms', style: AppTypography.labelMedium),
                      const SizedBox(width: 8),
                      Text('(${occupancy.toStringAsFixed(0)}%)', style: AppTypography.caption.copyWith(color: occupancy > 90 ? AppColors.error : AppColors.success)),
                    ]),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: AppSpacing.borderRadiusFull,
                      child: LinearProgressIndicator(value: h.occupied / h.capacity, backgroundColor: AppColors.surfaceVariant, valueColor: AlwaysStoppedAnimation(occupancy > 90 ? AppColors.warning : AppColors.success), minHeight: 6),
                    ),
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

class _Hostel {
  final String name, college, warden;
  final int capacity, occupied;
  final Color color;
  const _Hostel(this.name, this.college, this.capacity, this.occupied, this.warden, this.color);
}

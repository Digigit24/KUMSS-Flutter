import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class DrilldownScreen extends StatelessWidget {
  const DrilldownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Fee Analytics Drilldown',
            subtitle: 'Hierarchical fee analytics with drill-down capability',
            breadcrumbs: ['Home', 'Finance', 'Drilldown'],
          ),
          // Breadcrumb path
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Row(
              children: [
                const Icon(Icons.filter_list_rounded, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Flexible(child: _drillCrumb('All Colleges', true)),
                const Icon(Icons.chevron_right, size: 16, color: AppColors.textTertiary),
                Flexible(child: _drillCrumb('Engineering', false)),
              ],
            ),
          ),
          // Drill-down cards
          ...[
            _DrillItem('Tuition Fee', '\u20B945,00,000', '\u20B939,42,000', 87.6, 620),
            _DrillItem('Lab Fee', '\u20B96,00,000', '\u20B95,70,000', 95.0, 620),
          ].map((item) => _buildDrillCard(item, isMobile)),
        ],
      ),
    );
  }

  Widget _drillCrumb(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        label,
        style: AppTypography.labelMedium.copyWith(
          color: isActive ? AppColors.accent : AppColors.textSecondary,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDrillCard(_DrillItem item, bool isMobile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
        boxShadow: AppColors.shadowSm,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: isMobile ? 350 : 600),
          child: Row(
            children: [
              SizedBox(
                width: isMobile ? 120 : 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: AppTypography.h3, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text('${item.studentCount} students', style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Total', style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(item.total, style: AppTypography.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Collected', style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(item.collected, style: AppTypography.labelLarge.copyWith(color: AppColors.success), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${item.percentage}%', style: AppTypography.labelMedium.copyWith(
                      color: item.percentage >= 90 ? AppColors.success : item.percentage >= 80 ? AppColors.warning : AppColors.error,
                      fontWeight: FontWeight.w600,
                    ), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: AppSpacing.borderRadiusFull,
                      child: LinearProgressIndicator(
                        value: item.percentage / 100,
                        backgroundColor: AppColors.surfaceVariant,
                        valueColor: AlwaysStoppedAnimation(
                          item.percentage >= 90 ? AppColors.success : item.percentage >= 80 ? AppColors.warning : AppColors.error,
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded),
                onPressed: () {},
                tooltip: 'Drill down',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrillItem {
  final String name, total, collected;
  final double percentage;
  final int studentCount;
  const _DrillItem(this.name, this.total, this.collected, this.percentage, this.studentCount);
}

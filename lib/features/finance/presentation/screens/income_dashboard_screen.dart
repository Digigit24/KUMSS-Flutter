import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class IncomeDashboardScreen extends StatelessWidget {
  const IncomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(title: 'Income Dashboard', subtitle: 'Revenue and income tracking across all colleges', breadcrumbs: ['Home', 'Income Dashboard']),
          ResponsiveGrid(children: [
            MetricCard(label: 'Total Income', value: '\u20B9 1.8 Cr', icon: Icons.account_balance_wallet_rounded, iconColor: AppColors.success, iconBgColor: AppColors.successSurface),
            MetricCard(label: 'This Month', value: '\u20B9 18L', icon: Icons.calendar_today_rounded, iconColor: AppColors.accent, iconBgColor: AppColors.accentSurface),
            MetricCard(label: 'Pending Dues', value: '\u20B9 24L', icon: Icons.pending_actions_rounded, iconColor: AppColors.warning, iconBgColor: AppColors.warningSurface),
            MetricCard(label: 'Collection Rate', value: '87.4%', icon: Icons.trending_up_rounded, iconColor: AppColors.info, iconBgColor: AppColors.infoSurface),
          ]),
          const SizedBox(height: 20),
          AppCard(
            title: 'College-wise Income',
            subtitle: 'Revenue breakdown by college',
            child: Column(children: [
              _buildIncomeRow('Engineering', '\u20B995L', '\u20B983L', 87.5),
              const SizedBox(height: 12),
              _buildIncomeRow('Medicine', '\u20B985L', '\u20B976L', 89.8),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeRow(String college, String total, String collected, double percent) {
    return Row(children: [
      Expanded(flex: 2, child: Text(college, style: AppTypography.labelMedium.copyWith(color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis)),
      Expanded(child: Text(total, style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis)),
      Expanded(child: Text(collected, style: AppTypography.caption.copyWith(color: AppColors.success), maxLines: 1, overflow: TextOverflow.ellipsis)),
      SizedBox(
        width: 100,
        child: Row(children: [
          Expanded(child: ClipRRect(borderRadius: AppSpacing.borderRadiusFull, child: LinearProgressIndicator(value: percent / 100, backgroundColor: AppColors.surfaceVariant, valueColor: const AlwaysStoppedAnimation(AppColors.accent), minHeight: 6))),
          const SizedBox(width: 6),
          Text('${percent}%', style: AppTypography.caption.copyWith(fontSize: 10)),
        ]),
      ),
    ]);
  }
}

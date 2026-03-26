import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class IncomeDashboardScreen extends StatelessWidget {
  const IncomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Income Dashboard',
            subtitle: 'Revenue and income tracking across all colleges',
            breadcrumbs: ['Home', 'Income Dashboard'],
          ),
          Row(
            children: [
              Expanded(child: MetricCard(label: 'Total Income', value: '\u20B9 4.2 Cr', icon: Icons.account_balance_wallet_rounded, iconColor: AppColors.success, iconBgColor: AppColors.successSurface)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'This Month', value: '\u20B9 42L', icon: Icons.calendar_today_rounded, iconColor: AppColors.accent, iconBgColor: AppColors.accentSurface)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'Pending Dues', value: '\u20B9 68L', icon: Icons.pending_actions_rounded, iconColor: AppColors.warning, iconBgColor: AppColors.warningSurface)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'Collection Rate', value: '87.4%', icon: Icons.trending_up_rounded, iconColor: AppColors.info, iconBgColor: AppColors.infoSurface)),
            ],
          ),
          const SizedBox(height: 24),
          // College-wise income
          AppCard(
            title: 'College-wise Income',
            subtitle: 'Revenue breakdown by college',
            child: Column(
              children: [
                _buildIncomeRow('Engineering', '\u20B91.2Cr', '\u20B91.05Cr', 87.5),
                _buildIncomeRow('Medicine', '\u20B998L', '\u20B988L', 89.8),
                _buildIncomeRow('Business', '\u20B985L', '\u20B974L', 87.1),
                _buildIncomeRow('Law', '\u20B952L', '\u20B945L', 86.5),
                _buildIncomeRow('Science', '\u20B965L', '\u20B958L', 89.2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeRow(String college, String total, String collected, double percent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(college, style: AppTypography.labelLarge)),
          Expanded(child: Text(total, style: AppTypography.bodySmall)),
          Expanded(child: Text(collected, style: AppTypography.bodySmall.copyWith(color: AppColors.success))),
          SizedBox(
            width: 160,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: AppSpacing.borderRadiusFull,
                    child: LinearProgressIndicator(value: percent / 100, backgroundColor: AppColors.surfaceVariant, valueColor: const AlwaysStoppedAnimation(AppColors.accent), minHeight: 6),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${percent}%', style: AppTypography.labelSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

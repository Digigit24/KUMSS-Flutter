import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class FinanceReportsScreen extends StatelessWidget {
  const FinanceReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      _Report('Fee Collection Report', 'Summary of fee collection across all colleges', Icons.receipt_long_rounded, AppColors.accent),
      _Report('Expense Analysis', 'Monthly expense breakdown by category', Icons.pie_chart_rounded, AppColors.error),
      _Report('Revenue Trends', 'Year-over-year revenue comparison', Icons.trending_up_rounded, AppColors.success),
      _Report('Outstanding Dues', 'Students with pending fee payments', Icons.warning_rounded, AppColors.warning),
      _Report('Budget vs Actual', 'Budget utilization analysis', Icons.compare_arrows_rounded, AppColors.info),
      _Report('Salary Report', 'Monthly salary disbursement summary', Icons.payments_rounded, AppColors.secondary),
      _Report('Tax Summary', 'GST and TDS summary for FY', Icons.description_rounded, AppColors.primary),
      _Report('Audit Trail', 'Financial transaction audit log', Icons.history_rounded, AppColors.textSecondary),
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Financial Reports',
            subtitle: 'Generate and export financial reports',
            breadcrumbs: ['Home', 'Finance', 'Reports'],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
            ),
            itemCount: reports.length,
            itemBuilder: (_, i) {
              final r = reports[i];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppSpacing.borderRadiusLg,
                  border: Border.all(color: AppColors.border),
                  boxShadow: AppColors.shadowSm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(color: r.color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusMd),
                      child: Icon(r.icon, size: 22, color: r.color),
                    ),
                    const SizedBox(height: 12),
                    Text(r.title, style: AppTypography.h4),
                    const SizedBox(height: 4),
                    Expanded(child: Text(r.description, style: AppTypography.caption, maxLines: 2, overflow: TextOverflow.ellipsis)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        AppButton(label: 'Generate', size: AppButtonSize.sm, onPressed: () {}),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.download_rounded, size: 18),
                          onPressed: () {},
                          style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary),
                        ),
                      ],
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

class _Report {
  final String title, description;
  final IconData icon;
  final Color color;
  const _Report(this.title, this.description, this.icon, this.color);
}

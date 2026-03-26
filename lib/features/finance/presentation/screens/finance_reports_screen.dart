import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class FinanceReportsScreen extends StatelessWidget {
  const FinanceReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    final reports = [
      _Report('Fee Collection Report', 'Summary of fee collection across all colleges', Icons.receipt_long_rounded, AppColors.accent),
      _Report('Expense Analysis', 'Monthly expense breakdown by category', Icons.pie_chart_rounded, AppColors.error),
    ];

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 1.5 : 1.5,
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
                    Text(r.title, style: AppTypography.h4, maxLines: 1, overflow: TextOverflow.ellipsis),
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

import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class SalaryStructuresScreen extends StatelessWidget {
  const SalaryStructuresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    final structures = [
      _Structure('Professor Grade', '\u20B91,20,000', '\u20B91,50,000', 28, true),
      _Structure('Administrative Staff', '\u20B935,000', '\u20B950,000', 45, true),
    ];

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Salary Structures',
            subtitle: 'Define salary structure templates',
            breadcrumbs: const ['Home', 'HR', 'Salary Structures'],
            actions: [AppButton(label: 'Create Structure', icon: Icons.add_rounded, onPressed: () {})],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 1.8 : 1.8,
            ),
            itemCount: structures.length,
            itemBuilder: (_, i) {
              final s = structures[i];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppSpacing.borderRadiusLg, border: Border.all(color: AppColors.border), boxShadow: AppColors.shadowSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(child: Text(s.name, style: AppTypography.h4, maxLines: 1, overflow: TextOverflow.ellipsis)),
                      s.isActive ? StatusBadge.active() : StatusBadge.inactive(),
                    ]),
                    const SizedBox(height: 12),
                    Row(children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Min', style: AppTypography.caption),
                        Text(s.minSalary, style: AppTypography.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ]),
                      const SizedBox(width: 24),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Max', style: AppTypography.caption),
                        Text(s.maxSalary, style: AppTypography.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ]),
                    ]),
                    const Spacer(),
                    Row(children: [
                      Icon(Icons.people_rounded, size: 14, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Flexible(child: Text('${s.employees} employees', style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis)),
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

class _Structure {
  final String name, minSalary, maxSalary;
  final int employees;
  final bool isActive;
  const _Structure(this.name, this.minSalary, this.maxSalary, this.employees, this.isActive);
}

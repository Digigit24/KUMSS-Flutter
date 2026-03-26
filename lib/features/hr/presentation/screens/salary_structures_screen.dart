import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class SalaryStructuresScreen extends StatelessWidget {
  const SalaryStructuresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final structures = [
      _Structure('Professor Grade', '\u20B91,20,000', '\u20B91,50,000', 45, true),
      _Structure('Associate Professor', '\u20B985,000', '\u20B91,10,000', 82, true),
      _Structure('Assistant Professor', '\u20B960,000', '\u20B980,000', 156, true),
      _Structure('Administrative Staff', '\u20B935,000', '\u20B950,000', 120, true),
      _Structure('Support Staff', '\u20B920,000', '\u20B930,000', 85, true),
      _Structure('Contract Faculty', '\u20B940,000', '\u20B955,000', 38, false),
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1.8),
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
                      Expanded(child: Text(s.name, style: AppTypography.h4)),
                      s.isActive ? StatusBadge.active() : StatusBadge.inactive(),
                    ]),
                    const SizedBox(height: 12),
                    Row(children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Min', style: AppTypography.caption),
                        Text(s.minSalary, style: AppTypography.labelLarge),
                      ]),
                      const SizedBox(width: 24),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Max', style: AppTypography.caption),
                        Text(s.maxSalary, style: AppTypography.labelLarge),
                      ]),
                    ]),
                    const Spacer(),
                    Row(children: [
                      Icon(Icons.people_rounded, size: 14, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Text('${s.employees} employees', style: AppTypography.caption),
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

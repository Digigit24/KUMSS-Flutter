import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = [
      _Role('Super Admin', 'Full system access', 'Global', true, 1, 'All'),
      _Role('College Admin', 'College-level administration', 'College', true, 5, '24'),
      _Role('Teacher', 'Academic functions', 'College', true, 847, '12'),
      _Role('Student', 'Student portal access', 'College', true, 12458, '8'),
      _Role('Accountant', 'Financial operations', 'Global', true, 8, '15'),
      _Role('Hostel Manager', 'Hostel operations', 'Global', true, 5, '10'),
      _Role('Clerk', 'Administrative tasks', 'Global', true, 12, '8'),
      _Role('Librarian', 'Library management', 'College', true, 10, '6'),
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Role Management',
            subtitle: 'Define and manage roles with specific permission sets',
            breadcrumbs: const ['Home', 'Accounts', 'Roles'],
            actions: [
              AppButton(
                label: 'Create Role',
                icon: Icons.add_rounded,
                onPressed: () {},
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.2,
            ),
            itemCount: roles.length,
            itemBuilder: (_, i) {
              final r = roles[i];
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
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primarySurface,
                            borderRadius: AppSpacing.borderRadiusMd,
                          ),
                          child: const Icon(Icons.admin_panel_settings_rounded, size: 20, color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(r.name, style: AppTypography.h4),
                              Text(r.scope, style: AppTypography.caption),
                            ],
                          ),
                        ),
                        r.isActive ? StatusBadge.active() : StatusBadge.inactive(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(r.description, style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    Row(
                      children: [
                        _statChip(Icons.people_rounded, '${r.userCount}'),
                        const SizedBox(width: 12),
                        _statChip(Icons.security_rounded, '${r.permissionCount} perms'),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.edit_rounded, size: 18),
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

  Widget _statChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textTertiary),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

class _Role {
  final String name, description, scope;
  final bool isActive;
  final int userCount;
  final String permissionCount;
  const _Role(this.name, this.description, this.scope, this.isActive, this.userCount, this.permissionCount);
}

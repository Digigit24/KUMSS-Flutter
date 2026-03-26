import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    final roles = [
      _Role('Super Admin', 'Full system access across all colleges', 'Global', true, 1, 'All'),
      _Role('College Admin', 'College-level administration and oversight', 'College', true, 2, '24'),
    ];

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Role Management',
            subtitle: 'Define and manage roles with specific permission sets',
            breadcrumbs: const ['Home', 'Accounts', 'Roles'],
            actions: [AppButton(label: 'Create Role', icon: Icons.add_rounded, onPressed: () {})],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 1.8 : 2.2,
            ),
            itemCount: roles.length,
            itemBuilder: (_, i) {
              final r = roles[i];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppSpacing.borderRadiusLg, border: Border.all(color: AppColors.border), boxShadow: AppColors.shadowSm),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: AppSpacing.borderRadiusMd), child: const Icon(Icons.admin_panel_settings_rounded, size: 20, color: AppColors.primary)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(r.name, style: AppTypography.h4, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(r.scope, style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ])),
                    r.isActive ? StatusBadge.active() : StatusBadge.inactive(),
                  ]),
                  const SizedBox(height: 12),
                  Text(r.description, style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  Row(children: [
                    _statChip(Icons.people_rounded, '${r.userCount}'),
                    const SizedBox(width: 12),
                    _statChip(Icons.security_rounded, '${r.permissionCount} perms'),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                  ]),
                ]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _statChip(IconData icon, String label) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, size: 14, color: AppColors.textTertiary), const SizedBox(width: 4),
    Text(label, style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
  ]);
}

class _Role {
  final String name, description, scope;
  final bool isActive;
  final int userCount;
  final String permissionCount;
  const _Role(this.name, this.description, this.scope, this.isActive, this.userCount, this.permissionCount);
}

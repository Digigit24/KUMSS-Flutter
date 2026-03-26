import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    final modules = [
      _Module('User Management', Icons.people_rounded, ['view', 'create', 'edit', 'delete', 'manage_permissions', 'reset_password']),
      _Module('Student Management', Icons.school_rounded, ['view', 'create', 'edit', 'delete', 'access_sensitive_data']),
      _Module('Teacher Management', Icons.person_rounded, ['view', 'create', 'edit', 'delete', 'assign_courses']),
      _Module('Attendance', Icons.fact_check_rounded, ['view', 'mark', 'edit']),
      _Module('Fees', Icons.payments_rounded, ['view', 'create', 'edit', 'delete', 'collect']),
      _Module('Library', Icons.local_library_rounded, ['view', 'manage_books', 'manage_issues']),
      _Module('Store', Icons.store_rounded, ['view', 'create_indent', 'approve', 'manage_inventory']),
      _Module('Finance', Icons.account_balance_rounded, ['view', 'create', 'edit', 'delete', 'export']),
      _Module('HR', Icons.badge_rounded, ['view', 'manage_leave', 'manage_payroll', 'manage_deductions']),
      _Module('Reports', Icons.assessment_rounded, ['view', 'export']),
      _Module('System Settings', Icons.settings_rounded, ['view', 'manage']),
    ];

    final scopes = ['mine', 'team', 'department', 'all'];
    final flags = [
      _Flag('hideSensitiveFields', 'Hide sensitive data columns', Icons.visibility_off_rounded),
      _Flag('showAdvancedFilters', 'Enable advanced filtering', Icons.filter_alt_rounded),
      _Flag('canExport', 'Allow data export', Icons.download_rounded),
      _Flag('canImport', 'Allow data import', Icons.upload_rounded),
      _Flag('canBulkEdit', 'Enable bulk editing', Icons.edit_note_rounded),
      _Flag('canBulkDelete', 'Enable bulk deletion', Icons.delete_sweep_rounded),
    ];

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Permissions Reference',
            subtitle: 'Every permission in the system, organized by module',
            breadcrumbs: ['Home', 'System', 'Permissions'],
          ),
          // Scope legend
          AppCard(
            title: 'Permission Scopes',
            child: isMobile
                ? Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: scopes.map((s) {
                      final color = s == 'all' ? AppColors.error : s == 'department' ? AppColors.accent : s == 'team' ? AppColors.success : AppColors.info;
                      return SizedBox(
                        width: (MediaQuery.of(context).size.width - 32 - 40 - 12) / 2,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.06),
                            borderRadius: AppSpacing.borderRadiusMd,
                            border: Border.all(color: color.withValues(alpha: 0.2)),
                          ),
                          child: Column(
                            children: [
                              Text(s.toUpperCase(), style: AppTypography.labelMedium.copyWith(color: color, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text(
                                s == 'mine' ? 'Only own data' : s == 'team' ? 'Team-level data' : s == 'department' ? 'Department-wide' : 'All data (Super Admin)',
                                style: AppTypography.caption,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : Row(
                    children: scopes.map((s) {
                      final color = s == 'all' ? AppColors.error : s == 'department' ? AppColors.accent : s == 'team' ? AppColors.success : AppColors.info;
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.06),
                            borderRadius: AppSpacing.borderRadiusMd,
                            border: Border.all(color: color.withValues(alpha: 0.2)),
                          ),
                          child: Column(
                            children: [
                              Text(s.toUpperCase(), style: AppTypography.labelMedium.copyWith(color: color, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text(
                                s == 'mine' ? 'Only own data' : s == 'team' ? 'Team-level data' : s == 'department' ? 'Department-wide' : 'All data (Super Admin)',
                                style: AppTypography.caption,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),
          const SizedBox(height: 24),
          // Module permissions
          ...modules.map((m) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppSpacing.borderRadiusLg,
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: AppSpacing.borderRadiusMd),
                        child: Icon(m.icon, size: 18, color: AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(m.name, style: AppTypography.h4, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: m.actions.map((a) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.accentSurface,
                          borderRadius: AppSpacing.borderRadiusSm,
                          border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                        ),
                        child: Text(a, style: AppTypography.tag.copyWith(color: AppColors.accentDark, fontWeight: FontWeight.w500)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 24),
          // UI-Level permission flags
          AppCard(
            title: 'UI-Level Permission Flags',
            subtitle: 'Flags that control UI behavior',
            child: Column(
              children: flags.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(f.icon, size: 18, color: AppColors.textSecondary),
                    const SizedBox(width: 12),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(f.name, style: AppTypography.labelLarge.copyWith(fontFamily: 'monospace', fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text(f.description, style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    )),
                    Switch(value: f.name == 'canExport' || f.name == 'showAdvancedFilters', onChanged: (_) {}),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Module {
  final String name;
  final IconData icon;
  final List<String> actions;
  const _Module(this.name, this.icon, this.actions);
}

class _Flag {
  final String name, description;
  final IconData icon;
  const _Flag(this.name, this.description, this.icon);
}

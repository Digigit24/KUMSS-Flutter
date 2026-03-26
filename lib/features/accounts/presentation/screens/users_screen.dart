import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'User', flex: 2),
      const AppTableColumn(label: 'Email', flex: 2),
      const AppTableColumn(label: 'Type', width: 130),
      const AppTableColumn(label: 'College', flex: 1),
      const AppTableColumn(label: 'Status', width: 100),
      const AppTableColumn(label: 'Actions', width: 140, textAlign: TextAlign.center),
    ];

    final users = [
      ['Dr. Abebe Kebede', 'AK', 'abebe.k@kumss.edu.et', 'teacher', 'Engineering', true],
      ['Fatima Hassan', 'FH', 'fatima.h@kumss.edu.et', 'college_admin', 'Medicine', true],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'User Management',
            subtitle: 'Manage all user accounts across the institution',
            breadcrumbs: const ['Home', 'Accounts', 'Users'],
            actions: [
              AppButton(label: 'Export', icon: Icons.download_rounded, variant: AppButtonVariant.outlined, onPressed: () {}),
              AppButton(label: 'Add User', icon: Icons.person_add_rounded, onPressed: () => AppFormSheet.show(
                context,
                title: 'Add User',
                subtitle: 'Create a new user account',
                submitLabel: 'Create User',
                submitIcon: Icons.person_add_rounded,
                fields: [
                  TextField(decoration: const InputDecoration(labelText: 'First Name', hintText: 'Enter first name')),
                  TextField(decoration: const InputDecoration(labelText: 'Last Name', hintText: 'Enter last name')),
                  TextField(decoration: const InputDecoration(labelText: 'Email', hintText: 'user@kumss.edu.et')),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'User Type'),
                    items: ['Super Admin', 'College Admin', 'Teacher', 'Student', 'Staff'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                    onChanged: (_) {},
                  ),
                  TextField(decoration: const InputDecoration(labelText: 'Password', hintText: 'Enter password'), obscureText: true),
                ],
              )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Wrap(spacing: 8, children: [
              _filterChip('All Users', true),
              _filterChip('Teacher', false),
              _filterChip('College Admin', false),
              _filterChip('Student', false),
            ]),
          ),
          AppDataTable(
            columns: columns,
            rows: users.map((u) => [
              Row(children: [
                Container(width: 36, height: 36, decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: AppSpacing.borderRadiusMd),
                  child: Center(child: Text(u[1] as String, style: AppTypography.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.w600)))),
                const SizedBox(width: 10),
                Expanded(child: Text(u[0] as String, style: AppTypography.labelLarge)),
              ]),
              Text(u[2] as String, style: AppTypography.bodySmall),
              _userTypeBadge(u[3] as String),
              Text(u[4] as String, style: AppTypography.bodySmall),
              u[5] as bool ? StatusBadge.active() : StatusBadge.inactive(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.vpn_key_rounded, size: 18), onPressed: () {}, tooltip: 'Reset Password', style: IconButton.styleFrom(foregroundColor: AppColors.warning)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
              ]),
            ]).toList(),
            totalItems: users.length,
            onSearch: (_) {},
            searchHint: 'Search users by name or email...',
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool selected) => FilterChip(label: Text(label), selected: selected, onSelected: (_) {}, selectedColor: AppColors.primarySurface, checkmarkColor: AppColors.primary);

  Widget _userTypeBadge(String type) {
    final color = switch (type) { 'super_admin' => AppColors.error, 'college_admin' => AppColors.accent, 'teacher' => AppColors.info, 'student' => AppColors.success, _ => AppColors.textTertiary };
    final label = type.replaceAll('_', ' ').split(' ').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ');
    return StatusBadge(label: label, color: color);
  }

}

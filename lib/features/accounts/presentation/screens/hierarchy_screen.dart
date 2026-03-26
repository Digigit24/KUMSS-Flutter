import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class HierarchyScreen extends StatelessWidget {
  const HierarchyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Role Hierarchy',
            subtitle: 'Visualize role relationships and permission inheritance',
            breadcrumbs: ['Home', 'Accounts', 'Hierarchy'],
          ),
          AppCard(
            title: 'Organization Hierarchy',
            subtitle: 'Permissions flow downward',
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: isMobile ? 350 : 600),
                  child: Column(
                    children: [
                      _buildHierarchyNode('Super Admin', 'Full access', Icons.shield_rounded, AppColors.error, 0, isMobile),
                      _buildConnector(),
                      Wrap(
                        spacing: isMobile ? 8 : 16,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildHierarchyNode('College Admin', 'College-level', Icons.admin_panel_settings_rounded, AppColors.accent, 1, isMobile),
                          _buildHierarchyNode('Chief Accountant', 'Finance global', Icons.account_balance_rounded, AppColors.secondary, 1, isMobile),
                          _buildHierarchyNode('Hostel Manager', 'Hostel global', Icons.hotel_rounded, AppColors.info, 1, isMobile),
                        ],
                      ),
                      _buildConnector(),
                      Wrap(
                        spacing: isMobile ? 8 : 16,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildHierarchyNode('Teacher', 'Academic', Icons.school_rounded, AppColors.success, 2, isMobile),
                          _buildHierarchyNode('Accountant', 'Finance', Icons.receipt_rounded, AppColors.secondary, 2, isMobile),
                          _buildHierarchyNode('Clerk', 'Admin tasks', Icons.edit_note_rounded, AppColors.textTertiary, 2, isMobile),
                          _buildHierarchyNode('Librarian', 'Library', Icons.local_library_rounded, AppColors.info, 2, isMobile),
                        ],
                      ),
                      _buildConnector(),
                      _buildHierarchyNode('Student', 'Limited access', Icons.person_rounded, AppColors.textTertiary, 3, isMobile),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchyNode(String role, String scope, IconData icon, Color color, int level, bool isMobile) {
    return Container(
      width: isMobile ? 120 : 160,
      padding: EdgeInsets.all(isMobile ? 10 : 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Container(
            width: isMobile ? 36 : 44,
            height: isMobile ? 36 : 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: isMobile ? 18 : 22, color: color),
          ),
          const SizedBox(height: 8),
          Text(role, style: AppTypography.labelLarge, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 2),
          Text(scope, style: AppTypography.caption, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildConnector() {
    return Container(
      width: 2,
      height: 24,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: AppColors.border,
    );
  }
}

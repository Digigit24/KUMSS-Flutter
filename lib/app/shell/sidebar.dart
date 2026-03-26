import 'package:flutter/material.dart';
import '../../core/theme/theme_exports.dart';

/// Navigation item definition for sidebar.
class NavItem {
  final String label;
  final IconData icon;
  final String route;
  final List<NavItem>? children;

  const NavItem({
    required this.label,
    required this.icon,
    required this.route,
    this.children,
  });
}

/// All sidebar navigation items for the Super Admin.
class SidebarNav {
  static const List<NavItem> items = [
    NavItem(label: 'Dashboard', icon: Icons.dashboard_rounded, route: '/dashboard'),
    NavItem(
      label: 'Colleges',
      icon: Icons.apartment_rounded,
      route: '/core/colleges',
    ),
    NavItem(
      label: 'Accounts',
      icon: Icons.people_rounded,
      route: '/accounts',
      children: [
        NavItem(label: 'Users', icon: Icons.person_rounded, route: '/accounts/users'),
        NavItem(label: 'Roles', icon: Icons.admin_panel_settings_rounded, route: '/accounts/roles'),
        NavItem(label: 'User Roles', icon: Icons.assignment_ind_rounded, route: '/accounts/user-roles'),
        NavItem(label: 'Departments', icon: Icons.corporate_fare_rounded, route: '/accounts/departments'),
        NavItem(label: 'Hierarchy', icon: Icons.account_tree_rounded, route: '/accounts/hierarchy'),
      ],
    ),
    NavItem(
      label: 'Academic',
      icon: Icons.school_rounded,
      route: '/academic',
      children: [
        NavItem(label: 'Faculties', icon: Icons.domain_rounded, route: '/academic/faculties'),
        NavItem(label: 'Programs', icon: Icons.menu_book_rounded, route: '/academic/programs'),
        NavItem(label: 'Classes', icon: Icons.class_rounded, route: '/academic/classes'),
        NavItem(label: 'Sections', icon: Icons.grid_view_rounded, route: '/academic/sections'),
        NavItem(label: 'Subjects', icon: Icons.subject_rounded, route: '/academic/subjects'),
        NavItem(label: 'Timetables', icon: Icons.calendar_view_week_rounded, route: '/academic/timetables'),
        NavItem(label: 'Classrooms', icon: Icons.meeting_room_rounded, route: '/academic/classrooms'),
        NavItem(label: 'Setup Wizard', icon: Icons.auto_fix_high_rounded, route: '/academic/setup-wizard'),
      ],
    ),
    NavItem(
      label: 'Store',
      icon: Icons.store_rounded,
      route: '/store',
      children: [
        NavItem(label: 'CEO Approvals', icon: Icons.verified_rounded, route: '/store/super-admin-approvals'),
        NavItem(label: 'Indents Pipeline', icon: Icons.list_alt_rounded, route: '/store/indents-pipeline'),
        NavItem(label: 'Inventory', icon: Icons.inventory_2_rounded, route: '/store/inventory'),
        NavItem(label: 'Procurement', icon: Icons.shopping_cart_rounded, route: '/store/procurement-pipeline'),
        NavItem(label: 'College Stores', icon: Icons.storefront_rounded, route: '/store/college-stores'),
        NavItem(label: 'Central Stores', icon: Icons.warehouse_rounded, route: '/store/central-stores'),
      ],
    ),
    NavItem(
      label: 'Finance',
      icon: Icons.account_balance_rounded,
      route: '/finance',
      children: [
        NavItem(label: 'Dashboard', icon: Icons.dashboard_customize_rounded, route: '/finance/dashboard'),
        NavItem(label: 'Transactions', icon: Icons.receipt_long_rounded, route: '/finance/transactions'),
        NavItem(label: 'Expenses', icon: Icons.money_off_rounded, route: '/finance/other-expenses'),
        NavItem(label: 'Reports', icon: Icons.assessment_rounded, route: '/finance/reports'),
        NavItem(label: 'Drilldown', icon: Icons.pie_chart_rounded, route: '/finance/drilldown'),
        NavItem(label: 'Income', icon: Icons.trending_up_rounded, route: '/income-dashboard'),
      ],
    ),
    NavItem(
      label: 'HR & Payroll',
      icon: Icons.badge_rounded,
      route: '/hr',
      children: [
        NavItem(label: 'Leave', icon: Icons.event_busy_rounded, route: '/hr/leave'),
        NavItem(label: 'Salary Structures', icon: Icons.account_balance_wallet_rounded, route: '/hr/salary-structures'),
        NavItem(label: 'Payrolls', icon: Icons.payments_rounded, route: '/hr/payrolls'),
        NavItem(label: 'Payslips', icon: Icons.description_rounded, route: '/hr/payslips'),
        NavItem(label: 'Deductions', icon: Icons.remove_circle_outline_rounded, route: '/hr/deductions'),
      ],
    ),
    NavItem(
      label: 'Hostel',
      icon: Icons.hotel_rounded,
      route: '/hostel',
    ),
    NavItem(
      label: 'Library',
      icon: Icons.local_library_rounded,
      route: '/library',
    ),
    NavItem(
      label: 'Communication',
      icon: Icons.campaign_rounded,
      route: '/communication',
      children: [
        NavItem(label: 'Bulk Messages', icon: Icons.send_rounded, route: '/communication/bulk-messages'),
        NavItem(label: 'Events', icon: Icons.event_rounded, route: '/communication/events'),
        NavItem(label: 'Notices', icon: Icons.notifications_rounded, route: '/communication/notices'),
        NavItem(label: 'Templates', icon: Icons.text_snippet_rounded, route: '/communication/message-templates'),
      ],
    ),
    NavItem(
      label: 'Settings',
      icon: Icons.settings_rounded,
      route: '/settings',
      children: [
        NavItem(label: 'System Settings', icon: Icons.tune_rounded, route: '/core/system-settings'),
        NavItem(label: 'Academic Years', icon: Icons.date_range_rounded, route: '/core/academic-years'),
        NavItem(label: 'Holidays', icon: Icons.celebration_rounded, route: '/core/holidays'),
        NavItem(label: 'Activity Logs', icon: Icons.history_rounded, route: '/core/activity-logs'),
        NavItem(label: 'Permissions', icon: Icons.security_rounded, route: '/system/permissions'),
      ],
    ),
  ];
}

/// The main sidebar navigation widget with expand/collapse support.
class AppSidebar extends StatefulWidget {
  final String currentRoute;
  final ValueChanged<String> onNavigate;
  final bool isCollapsed;
  final VoidCallback onToggleCollapse;

  const AppSidebar({
    super.key,
    required this.currentRoute,
    required this.onNavigate,
    required this.isCollapsed,
    required this.onToggleCollapse,
  });

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  String? _expandedSection;

  @override
  void initState() {
    super.initState();
    // Auto-expand the section containing the current route
    for (final item in SidebarNav.items) {
      if (item.children != null) {
        for (final child in item.children!) {
          if (widget.currentRoute.startsWith(child.route)) {
            _expandedSection = item.label;
            break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.isCollapsed
        ? AppSpacing.sidebarCollapsedWidth
        : AppSpacing.sidebarWidth;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: width,
      decoration: const BoxDecoration(
        gradient: AppColors.sidebarGradient,
      ),
      child: Column(
        children: [
          _buildLogo(),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              children: SidebarNav.items
                  .map((item) => _buildNavItem(item))
                  .toList(),
            ),
          ),
          _buildCollapseButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: AppSpacing.headerHeight,
      padding: EdgeInsets.symmetric(
        horizontal: widget.isCollapsed ? 16 : 20,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: AppSpacing.borderRadiusSm,
            ),
            child: const Icon(
              Icons.school_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          if (!widget.isCollapsed) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KUMSS',
                    style: AppTypography.h3.copyWith(
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    'ERP System',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.sidebarText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavItem(NavItem item) {
    final isActive = widget.currentRoute == item.route ||
        (item.children != null &&
            item.children!.any((c) => widget.currentRoute.startsWith(c.route)));
    final isExpanded = _expandedSection == item.label;
    final hasChildren = item.children != null && item.children!.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: Material(
            color: Colors.transparent,
            borderRadius: AppSpacing.borderRadiusMd,
            child: InkWell(
              borderRadius: AppSpacing.borderRadiusMd,
              onTap: () {
                if (hasChildren) {
                  setState(() {
                    _expandedSection =
                        isExpanded ? null : item.label;
                  });
                } else {
                  widget.onNavigate(item.route);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isCollapsed ? 12 : 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.sidebarItemActive
                      : Colors.transparent,
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      size: 20,
                      color: isActive
                          ? AppColors.sidebarIconActive
                          : AppColors.sidebarIcon,
                    ),
                    if (!widget.isCollapsed) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.label,
                          style: AppTypography.bodySmall.copyWith(
                            color: isActive
                                ? AppColors.sidebarTextActive
                                : AppColors.sidebarText,
                            fontWeight:
                                isActive ? FontWeight.w500 : FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasChildren)
                        AnimatedRotation(
                          turns: isExpanded ? 0.25 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 16,
                            color: AppColors.sidebarIcon,
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        // Children
        if (hasChildren && isExpanded && !widget.isCollapsed)
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 4),
            child: Column(
              children: item.children!.map((child) {
                final childActive =
                    widget.currentRoute.startsWith(child.route);
                return Container(
                  margin: const EdgeInsets.only(bottom: 1),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: AppSpacing.borderRadiusSm,
                    child: InkWell(
                      borderRadius: AppSpacing.borderRadiusSm,
                      onTap: () => widget.onNavigate(child.route),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: childActive
                              ? AppColors.accent.withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: AppSpacing.borderRadiusSm,
                          border: childActive
                              ? Border(
                                  left: BorderSide(
                                    color: AppColors.accent,
                                    width: 2,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              child.icon,
                              size: 16,
                              color: childActive
                                  ? AppColors.accentLight
                                  : AppColors.sidebarIcon,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                child.label,
                                style: AppTypography.caption.copyWith(
                                  color: childActive
                                      ? AppColors.accentLight
                                      : AppColors.sidebarText,
                                  fontWeight: childActive
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildCollapseButton() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppSpacing.borderRadiusMd,
        child: InkWell(
          borderRadius: AppSpacing.borderRadiusMd,
          onTap: widget.onToggleCollapse,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              mainAxisAlignment: widget.isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Icon(
                  widget.isCollapsed
                      ? Icons.chevron_right_rounded
                      : Icons.chevron_left_rounded,
                  size: 20,
                  color: AppColors.sidebarIcon,
                ),
                if (!widget.isCollapsed) ...[
                  const SizedBox(width: 12),
                  Text(
                    'Collapse',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.sidebarText,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

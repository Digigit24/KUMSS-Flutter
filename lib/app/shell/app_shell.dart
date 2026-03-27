import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/theme_exports.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import 'sidebar.dart';
import 'app_header.dart';

/// Bottom nav tab definition.
class _BottomTab {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;

  const _BottomTab(this.label, this.icon, this.activeIcon, this.route);
}

const _bottomTabs = [
  _BottomTab('Home', Icons.dashboard_outlined, Icons.dashboard_rounded, '/dashboard'),
  _BottomTab('Academic', Icons.school_outlined, Icons.school_rounded, '/academic/faculties'),
  _BottomTab('Finance', Icons.account_balance_outlined, Icons.account_balance_rounded, '/finance/dashboard'),
  _BottomTab('HR', Icons.badge_outlined, Icons.badge_rounded, '/hr/leave'),
  _BottomTab('More', Icons.menu_outlined, Icons.menu_rounded, '_more'),
];

/// The main application shell with sidebar + header + content area.
/// Mobile: bottom nav bar + drawer for "More". Desktop: sidebar.
class AppShell extends StatefulWidget {
  final Widget child;
  final String currentRoute;
  final ValueChanged<String> onNavigate;

  const AppShell({
    super.key,
    required this.child,
    required this.currentRoute,
    required this.onNavigate,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _sidebarCollapsed = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  int _getActiveTabIndex() {
    for (int i = 0; i < _bottomTabs.length - 1; i++) {
      final tab = _bottomTabs[i];
      if (widget.currentRoute == tab.route ||
          widget.currentRoute.startsWith(tab.route.split('/').take(2).join('/'))) {
        return i;
      }
    }
    // If current route doesn't match any tab, it's in "More"
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppSpacing.mobileBreakpoint;
    final isTablet = screenWidth >= AppSpacing.mobileBreakpoint &&
        screenWidth < AppSpacing.desktopBreakpoint;

    final authState = context.watch<AuthBloc>().state;
    final user =
        authState is AuthAuthenticated ? authState.user : UserModel.demoSuperAdmin;

    if (isMobile) {
      return _buildMobileLayout(user);
    }

    if (isTablet && !_sidebarCollapsed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _sidebarCollapsed = true);
      });
    }

    return _buildDesktopLayout(user);
  }

  Widget _buildDesktopLayout(UserModel user) {
    return Scaffold(
      body: Row(
        children: [
          AppSidebar(
            currentRoute: widget.currentRoute,
            onNavigate: widget.onNavigate,
            isCollapsed: _sidebarCollapsed,
            onToggleCollapse: () =>
                setState(() => _sidebarCollapsed = !_sidebarCollapsed),
          ),
          Expanded(
            child: Column(
              children: [
                AppHeader(user: user),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(UserModel user) {
    final activeIndex = _getActiveTabIndex();

    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: AppSpacing.sidebarWidth,
        child: AppSidebar(
          currentRoute: widget.currentRoute,
          onNavigate: (route) {
            _scaffoldKey.currentState?.closeDrawer();
            widget.onNavigate(route);
          },
          isCollapsed: false,
          onToggleCollapse: () {
            _scaffoldKey.currentState?.closeDrawer();
          },
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppHeader(
              user: user,
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            Expanded(child: widget.child),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: Row(
              children: List.generate(_bottomTabs.length, (i) {
                final tab = _bottomTabs[i];
                final isActive = i == activeIndex;

                return Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (tab.route == '_more') {
                          _scaffoldKey.currentState?.openDrawer();
                        } else {
                          widget.onNavigate(tab.route);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isActive ? tab.activeIcon : tab.icon,
                            size: 22,
                            color: isActive
                                ? AppColors.accent
                                : AppColors.textTertiary,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tab.label,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight:
                                  isActive ? FontWeight.w600 : FontWeight.w400,
                              color: isActive
                                  ? AppColors.accent
                                  : AppColors.textTertiary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

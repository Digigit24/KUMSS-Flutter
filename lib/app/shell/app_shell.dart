import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/theme_exports.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import 'sidebar.dart';
import 'app_header.dart';

/// The main application shell with sidebar + header + content area.
/// Handles responsive behavior: sidebar on desktop, drawer on mobile.
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppSpacing.mobileBreakpoint;
    final isTablet = screenWidth >= AppSpacing.mobileBreakpoint &&
        screenWidth < AppSpacing.desktopBreakpoint;

    // Get current user
    final authState = context.watch<AuthBloc>().state;
    final user =
        authState is AuthAuthenticated ? authState.user : UserModel.demoSuperAdmin;

    if (isMobile) {
      return _buildMobileLayout(user);
    }

    // Auto-collapse on tablet
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
                Expanded(
                  child: widget.child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(UserModel user) {
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
      body: Column(
        children: [
          AppHeader(
            user: user,
            onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/shell/app_shell.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/college_management/presentation/screens/colleges_screen.dart';
import '../../features/accounts/presentation/screens/users_screen.dart';
import '../../features/accounts/presentation/screens/roles_screen.dart';
import '../../features/accounts/presentation/screens/user_roles_screen.dart';
import '../../features/accounts/presentation/screens/departments_screen.dart';
import '../../features/accounts/presentation/screens/hierarchy_screen.dart';
import '../../features/academic/presentation/screens/faculties_screen.dart';
import '../../features/academic/presentation/screens/programs_screen.dart';
import '../../features/academic/presentation/screens/classes_screen.dart';
import '../../features/academic/presentation/screens/sections_screen.dart';
import '../../features/academic/presentation/screens/subjects_screen.dart';
import '../../features/academic/presentation/screens/timetables_screen.dart';
import '../../features/academic/presentation/screens/classrooms_screen.dart';
import '../../features/academic/presentation/screens/setup_wizard_screen.dart';
import '../../features/store/presentation/screens/super_admin_approvals_screen.dart';
import '../../features/store/presentation/screens/indents_pipeline_screen.dart';
import '../../features/store/presentation/screens/inventory_screen.dart';
import '../../features/finance/presentation/screens/finance_dashboard_screen.dart';
import '../../features/finance/presentation/screens/transactions_screen.dart';
import '../../features/finance/presentation/screens/expenses_screen.dart';
import '../../features/finance/presentation/screens/finance_reports_screen.dart';
import '../../features/finance/presentation/screens/drilldown_screen.dart';
import '../../features/finance/presentation/screens/income_dashboard_screen.dart';
import '../../features/hr/presentation/screens/leave_screen.dart';
import '../../features/hr/presentation/screens/salary_structures_screen.dart';
import '../../features/hr/presentation/screens/payrolls_screen.dart';
import '../../features/hr/presentation/screens/payslips_screen.dart';
import '../../features/hr/presentation/screens/deductions_screen.dart';
import '../../features/hostel/presentation/screens/hostel_screen.dart';
import '../../features/library/presentation/screens/library_screen.dart';
import '../../features/communication/presentation/screens/bulk_messages_screen.dart';
import '../../features/communication/presentation/screens/events_screen.dart';
import '../../features/communication/presentation/screens/notices_screen.dart';
import '../../features/communication/presentation/screens/message_templates_screen.dart';
import '../../features/settings/presentation/screens/system_settings_screen.dart';
import '../../features/settings/presentation/screens/academic_years_screen.dart';
import '../../features/settings/presentation/screens/holidays_screen.dart';
import '../../features/reports/presentation/screens/activity_logs_screen.dart';
import '../../features/permissions/presentation/screens/permissions_screen.dart';
import '../widgets/placeholder_screen.dart';

/// Application router using GoRouter with shell route for the main layout.
class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  late final GoRouter router = GoRouter(
    initialLocation: '/dashboard',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isAuthenticated = authBloc.state is AuthAuthenticated;
      final isLoginPage = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoginPage) return '/login';
      if (isAuthenticated && isLoginPage) return '/dashboard';
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(
            currentRoute: state.matchedLocation,
            onNavigate: (route) => context.go(route),
            child: child,
          );
        },
        routes: [
          // ─── Dashboard ──────────────────────────────────
          GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),

          // ─── Colleges ───────────────────────────────────
          GoRoute(path: '/core/colleges', builder: (_, __) => const CollegesScreen()),

          // ─── Accounts ───────────────────────────────────
          GoRoute(path: '/accounts/users', builder: (_, __) => const UsersScreen()),
          GoRoute(path: '/accounts/roles', builder: (_, __) => const RolesScreen()),
          GoRoute(path: '/accounts/user-roles', builder: (_, __) => const UserRolesScreen()),
          GoRoute(path: '/accounts/departments', builder: (_, __) => const DepartmentsScreen()),
          GoRoute(path: '/accounts/hierarchy', builder: (_, __) => const HierarchyScreen()),
          GoRoute(path: '/accounts/user-profiles', builder: (_, __) => const PlaceholderScreen(title: 'User Profiles', breadcrumbs: ['Home', 'Accounts', 'Profiles'], icon: Icons.person_rounded)),

          // ─── Academic ───────────────────────────────────
          GoRoute(path: '/academic/faculties', builder: (_, __) => const FacultiesScreen()),
          GoRoute(path: '/academic/programs', builder: (_, __) => const ProgramsScreen()),
          GoRoute(path: '/academic/classes', builder: (_, __) => const ClassesScreen()),
          GoRoute(path: '/academic/sections', builder: (_, __) => const SectionsScreen()),
          GoRoute(path: '/academic/subjects', builder: (_, __) => const SubjectsScreen()),
          GoRoute(path: '/academic/optional-subjects', builder: (_, __) => const PlaceholderScreen(title: 'Optional Subjects', breadcrumbs: ['Home', 'Academic', 'Optional Subjects'], icon: Icons.playlist_add_check_rounded)),
          GoRoute(path: '/academic/subject-assignments', builder: (_, __) => const PlaceholderScreen(title: 'Subject Assignments', breadcrumbs: ['Home', 'Academic', 'Subject Assignments'], icon: Icons.assignment_ind_rounded)),
          GoRoute(path: '/academic/classrooms', builder: (_, __) => const ClassroomsScreen()),
          GoRoute(path: '/academic/class-times', builder: (_, __) => const PlaceholderScreen(title: 'Class Times', breadcrumbs: ['Home', 'Academic', 'Class Times'], icon: Icons.schedule_rounded)),
          GoRoute(path: '/academic/timetables', builder: (_, __) => const TimetablesScreen()),
          GoRoute(path: '/academic/lab-schedules', builder: (_, __) => const PlaceholderScreen(title: 'Lab Schedules', breadcrumbs: ['Home', 'Academic', 'Lab Schedules'], icon: Icons.science_rounded)),
          GoRoute(path: '/academic/class-teachers', builder: (_, __) => const PlaceholderScreen(title: 'Class Teachers', breadcrumbs: ['Home', 'Academic', 'Class Teachers'], icon: Icons.person_pin_rounded)),
          GoRoute(path: '/academic/setup-wizard', builder: (_, __) => const SetupWizardScreen()),

          // ─── Store ──────────────────────────────────────
          GoRoute(path: '/store/super-admin-approvals', builder: (_, __) => const SuperAdminApprovalsScreen()),
          GoRoute(path: '/store/indents-pipeline', builder: (_, __) => const IndentsPipelineScreen()),
          GoRoute(path: '/store/approvals', builder: (_, __) => const PlaceholderScreen(title: 'Unified Approvals', breadcrumbs: ['Home', 'Store', 'Approvals'], icon: Icons.approval_rounded)),
          GoRoute(path: '/store/college-approvals', builder: (_, __) => const PlaceholderScreen(title: 'College Approvals', breadcrumbs: ['Home', 'Store', 'College Approvals'], icon: Icons.verified_rounded)),
          GoRoute(path: '/store/inventory', builder: (_, __) => const InventoryScreen()),
          GoRoute(path: '/store/procurement-pipeline', builder: (_, __) => const PlaceholderScreen(title: 'Procurement Pipeline', breadcrumbs: ['Home', 'Store', 'Procurement'], icon: Icons.shopping_cart_rounded)),
          GoRoute(path: '/store/hierarchy', builder: (_, __) => const PlaceholderScreen(title: 'Store Hierarchy', breadcrumbs: ['Home', 'Store', 'Hierarchy'], icon: Icons.account_tree_rounded)),
          GoRoute(path: '/store/college-stores', builder: (_, __) => const PlaceholderScreen(title: 'College Stores', breadcrumbs: ['Home', 'Store', 'College Stores'], icon: Icons.storefront_rounded)),
          GoRoute(path: '/store/central-stores', builder: (_, __) => const PlaceholderScreen(title: 'Central Stores', breadcrumbs: ['Home', 'Store', 'Central Stores'], icon: Icons.warehouse_rounded)),
          GoRoute(path: '/store/central-inventory', builder: (_, __) => const PlaceholderScreen(title: 'Central Inventory', breadcrumbs: ['Home', 'Store', 'Central Inventory'], icon: Icons.inventory_rounded)),

          // ─── Finance ────────────────────────────────────
          GoRoute(path: '/finance/dashboard', builder: (_, __) => const FinanceDashboardScreen()),
          GoRoute(path: '/finance/transactions', builder: (_, __) => const TransactionsScreen()),
          GoRoute(path: '/finance/other-expenses', builder: (_, __) => const ExpensesScreen()),
          GoRoute(path: '/finance/app-summary', builder: (_, __) => const PlaceholderScreen(title: 'App Summary', breadcrumbs: ['Home', 'Finance', 'App Summary'], icon: Icons.summarize_rounded)),
          GoRoute(path: '/finance/reports', builder: (_, __) => const FinanceReportsScreen()),
          GoRoute(path: '/finance/drilldown', builder: (_, __) => const DrilldownScreen()),
          GoRoute(path: '/income-dashboard', builder: (_, __) => const IncomeDashboardScreen()),

          // ─── HR ─────────────────────────────────────────
          GoRoute(path: '/hr/leave', builder: (_, __) => const LeaveScreen()),
          GoRoute(path: '/hr/deductions', builder: (_, __) => const DeductionsScreen()),
          GoRoute(path: '/hr/salary-structures', builder: (_, __) => const SalaryStructuresScreen()),
          GoRoute(path: '/hr/salary-components', builder: (_, __) => const PlaceholderScreen(title: 'Salary Components', breadcrumbs: ['Home', 'HR', 'Salary Components'], icon: Icons.monetization_on_rounded)),
          GoRoute(path: '/hr/payrolls', builder: (_, __) => const PayrollsScreen()),
          GoRoute(path: '/hr/payroll-items', builder: (_, __) => const PlaceholderScreen(title: 'Payroll Items', breadcrumbs: ['Home', 'HR', 'Payroll Items'], icon: Icons.receipt_rounded)),
          GoRoute(path: '/hr/payslips', builder: (_, __) => const PayslipsScreen()),

          // ─── Hostel & Library ───────────────────────────
          GoRoute(path: '/hostel', builder: (_, __) => const HostelScreen()),
          GoRoute(path: '/library', builder: (_, __) => const LibraryScreen()),

          // ─── Communication ──────────────────────────────
          GoRoute(path: '/communication/bulk-messages', builder: (_, __) => const BulkMessagesScreen()),
          GoRoute(path: '/communication/events', builder: (_, __) => const EventsScreen()),
          GoRoute(path: '/communication/event-registrations', builder: (_, __) => const PlaceholderScreen(title: 'Event Registrations', breadcrumbs: ['Home', 'Communication', 'Registrations'], icon: Icons.how_to_reg_rounded)),
          GoRoute(path: '/communication/notices', builder: (_, __) => const NoticesScreen()),
          GoRoute(path: '/communication/notification-rules', builder: (_, __) => const PlaceholderScreen(title: 'Notification Rules', breadcrumbs: ['Home', 'Communication', 'Rules'], icon: Icons.rule_rounded)),
          GoRoute(path: '/communication/message-templates', builder: (_, __) => const MessageTemplatesScreen()),
          GoRoute(path: '/communication/notice-visibility', builder: (_, __) => const PlaceholderScreen(title: 'Notice Visibility', breadcrumbs: ['Home', 'Communication', 'Visibility'], icon: Icons.visibility_rounded)),

          // ─── Settings ───────────────────────────────────
          GoRoute(path: '/core/system-settings', builder: (_, __) => const SystemSettingsScreen()),
          GoRoute(path: '/core/notification-settings', builder: (_, __) => const PlaceholderScreen(title: 'Notification Settings', breadcrumbs: ['Home', 'Settings', 'Notifications'], icon: Icons.notifications_active_rounded)),
          GoRoute(path: '/core/academic-years', builder: (_, __) => const AcademicYearsScreen()),
          GoRoute(path: '/core/academic-sessions', builder: (_, __) => const PlaceholderScreen(title: 'Academic Sessions', breadcrumbs: ['Home', 'Settings', 'Sessions'], icon: Icons.event_note_rounded)),
          GoRoute(path: '/core/holidays', builder: (_, __) => const HolidaysScreen()),
          GoRoute(path: '/core/weekends', builder: (_, __) => const PlaceholderScreen(title: 'Weekend Configuration', breadcrumbs: ['Home', 'Settings', 'Weekends'], icon: Icons.weekend_rounded)),
          GoRoute(path: '/core/activity-logs', builder: (_, __) => const ActivityLogsScreen()),
          GoRoute(path: '/core/organization-hierarchy', builder: (_, __) => const PlaceholderScreen(title: 'Organization Hierarchy', breadcrumbs: ['Home', 'Settings', 'Org Hierarchy'], icon: Icons.account_tree_rounded)),

          // ─── Permissions ────────────────────────────────
          GoRoute(path: '/system/permissions', builder: (_, __) => const PermissionsScreen()),
        ],
      ),
    ],
  );
}

/// Converts a [Stream] into a [ChangeNotifier] for GoRouter's refreshListenable.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

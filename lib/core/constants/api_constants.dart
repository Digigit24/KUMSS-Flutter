/// API endpoint constants for the KUMSS ERP system.
class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.kumss.edu.et/api/v1';

  // ─── Auth ──────────────────────────────────────────────────
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String profile = '/auth/profile';

  // ─── Colleges ──────────────────────────────────────────────
  static const String colleges = '/core/colleges';

  // ─── Users & Roles ────────────────────────────────────────
  static const String users = '/accounts/users';
  static const String roles = '/accounts/roles';
  static const String userRoles = '/accounts/user-roles';
  static const String departments = '/accounts/departments';
  static const String roleHierarchy = '/accounts/hierarchy';
  static const String userProfiles = '/accounts/user-profiles';
  static const String permissions = '/accounts/permissions';

  // ─── Academic ──────────────────────────────────────────────
  static const String faculties = '/academic/faculties';
  static const String programs = '/academic/programs';
  static const String classes = '/academic/classes';
  static const String sections = '/academic/sections';
  static const String subjects = '/academic/subjects';
  static const String optionalSubjects = '/academic/optional-subjects';
  static const String subjectAssignments = '/academic/subject-assignments';
  static const String classrooms = '/academic/classrooms';
  static const String classTimes = '/academic/class-times';
  static const String timetables = '/academic/timetables';
  static const String labSchedules = '/academic/lab-schedules';
  static const String classTeachers = '/academic/class-teachers';
  static const String academicYears = '/core/academic-years';
  static const String academicSessions = '/core/academic-sessions';

  // ─── Store ─────────────────────────────────────────────────
  static const String storeApprovals = '/store/super-admin-approvals';
  static const String indentsPipeline = '/store/indents-pipeline';
  static const String inventory = '/store/inventory';
  static const String procurement = '/store/procurement-pipeline';
  static const String storeHierarchy = '/store/hierarchy';
  static const String collegeStores = '/store/college-stores';
  static const String centralStores = '/store/central-stores';
  static const String centralInventory = '/store/central-inventory';

  // ─── Finance ──────────────────────────────────────────────
  static const String financeTransactions = '/finance/transactions';
  static const String otherExpenses = '/finance/other-expenses';
  static const String financeReports = '/finance/reports';
  static const String financeDrilldown = '/finance/drilldown';

  // ─── HR ───────────────────────────────────────────────────
  static const String leave = '/hr/leave';
  static const String deductions = '/hr/deductions';
  static const String salaryStructures = '/hr/salary-structures';
  static const String salaryComponents = '/hr/salary-components';
  static const String payrolls = '/hr/payrolls';
  static const String payrollItems = '/hr/payroll-items';
  static const String payslips = '/hr/payslips';

  // ─── Communication ────────────────────────────────────────
  static const String bulkMessages = '/communication/bulk-messages';
  static const String events = '/communication/events';
  static const String eventRegistrations = '/communication/event-registrations';
  static const String notices = '/communication/notices';
  static const String notificationRules = '/communication/notification-rules';
  static const String messageTemplates = '/communication/message-templates';

  // ─── Settings ─────────────────────────────────────────────
  static const String systemSettings = '/core/system-settings';
  static const String notificationSettings = '/core/notification-settings';
  static const String holidays = '/core/holidays';
  static const String weekends = '/core/weekends';
  static const String organizationHierarchy = '/core/organization-hierarchy';
  static const String activityLogs = '/core/activity-logs';

  // ─── Dashboard ────────────────────────────────────────────
  static const String dashboardStats = '/dashboard/stats';
  static const String dashboardActivities = '/dashboard/activities';
  static const String dashboardAlerts = '/dashboard/alerts';
}

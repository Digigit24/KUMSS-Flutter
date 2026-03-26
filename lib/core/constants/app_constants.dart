/// Application-wide constants.
class AppConstants {
  AppConstants._();

  static const String appName = 'KUMSS ERP';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Enterprise Resource Planning System';

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'current_user';
  static const String selectedCollegeKey = 'selected_college';
  static const String sidebarCollapsedKey = 'sidebar_collapsed';

  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 100;

  // User types
  static const String userTypeSuperAdmin = 'super_admin';
  static const String userTypeCollegeAdmin = 'college_admin';
  static const String userTypeTeacher = 'teacher';
  static const String userTypeStudent = 'student';
  static const String userTypeStaff = 'staff';
  static const String userTypeAccountant = 'accountant';
  static const String userTypeClerk = 'clerk';

  // Priorities
  static const String priorityLow = 'low';
  static const String priorityMedium = 'medium';
  static const String priorityHigh = 'high';
  static const String priorityUrgent = 'urgent';

  // Statuses
  static const String statusActive = 'active';
  static const String statusInactive = 'inactive';
  static const String statusPending = 'pending';
  static const String statusApproved = 'approved';
  static const String statusRejected = 'rejected';
}

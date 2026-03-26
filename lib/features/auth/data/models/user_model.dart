/// User model representing an authenticated user in the KUMSS ERP.
class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String userType;
  final bool isSuperuser;
  final bool isActive;
  final String? phone;
  final String? avatarUrl;
  final int? collegeId;
  final String? collegeName;
  final List<String> permissions;

  const UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userType,
    this.isSuperuser = false,
    this.isActive = true,
    this.phone,
    this.avatarUrl,
    this.collegeId,
    this.collegeName,
    this.permissions = const [],
  });

  String get fullName => '$firstName $lastName';
  String get initials =>
      '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
          .toUpperCase();

  bool get isSuperAdmin =>
      userType == 'super_admin' || isSuperuser;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      userType: json['user_type'] as String? ?? '',
      isSuperuser: json['is_superuser'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
      phone: json['phone'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      collegeId: json['college_id'] as int?,
      collegeName: json['college_name'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'user_type': userType,
        'is_superuser': isSuperuser,
        'is_active': isActive,
        'phone': phone,
        'avatar_url': avatarUrl,
        'college_id': collegeId,
        'college_name': collegeName,
        'permissions': permissions,
      };

  /// Demo super admin user for development.
  static UserModel get demoSuperAdmin => const UserModel(
        id: 1,
        email: 'admin@kumss.edu.et',
        firstName: 'Super',
        lastName: 'Admin',
        userType: 'super_admin',
        isSuperuser: true,
        permissions: ['all'],
      );
}

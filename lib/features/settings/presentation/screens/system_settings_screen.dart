import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class SystemSettingsScreen extends StatelessWidget {
  const SystemSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'System Settings',
            subtitle: 'Global system configuration',
            breadcrumbs: ['Home', 'Settings', 'System'],
          ),
          _buildSection('General', [
            _SettingItem('Institution Name', 'KUMSS University', Icons.business_rounded),
            _SettingItem('Default Currency', 'INR (\u20B9)', Icons.currency_rupee_rounded),
            _SettingItem('Timezone', 'Asia/Kolkata (IST)', Icons.schedule_rounded),
            _SettingItem('Date Format', 'DD/MM/YYYY', Icons.calendar_today_rounded),
          ]),
          const SizedBox(height: 20),
          _buildSection('Academic', [
            _SettingItem('Default Academic Year', '2025-26', Icons.date_range_rounded),
            _SettingItem('Grading System', '10-point CGPA', Icons.grade_rounded),
            _SettingItem('Attendance Threshold', '75%', Icons.fact_check_rounded),
            _SettingItem('Max Subjects per Semester', '8', Icons.subject_rounded),
          ]),
          const SizedBox(height: 20),
          _buildSection('Security', [
            _SettingItem('Session Timeout', '30 minutes', Icons.timer_rounded),
            _SettingItem('Password Policy', 'Strong (8+ chars, mixed)', Icons.lock_rounded),
            _SettingItem('Two-Factor Auth', 'Enabled for admins', Icons.security_rounded),
            _SettingItem('Login Attempts', '5 before lockout', Icons.block_rounded),
          ]),
          const SizedBox(height: 20),
          _buildSection('Notifications', [
            _SettingItem('Email Notifications', 'Enabled', Icons.email_rounded),
            _SettingItem('SMS Gateway', 'Configured (Twilio)', Icons.sms_rounded),
            _SettingItem('Push Notifications', 'Enabled', Icons.notifications_rounded),
          ]),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(label: 'Reset to Defaults', variant: AppButtonVariant.outlined, onPressed: () {}),
              const SizedBox(width: 8),
              AppButton(label: 'Save Settings', icon: Icons.save_rounded, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<_SettingItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(title, style: AppTypography.h3),
          ),
          const Divider(height: 1),
          ...items.map((item) => _buildSettingRow(item)),
        ],
      ),
    );
  }

  Widget _buildSettingRow(_SettingItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderLight)),
      ),
      child: Row(
        children: [
          Icon(item.icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(child: Text(item.label, style: AppTypography.bodyMedium)),
          Text(item.value, style: AppTypography.labelMedium.copyWith(color: AppColors.textSecondary)),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.edit_rounded, size: 16),
            onPressed: () {},
            style: IconButton.styleFrom(foregroundColor: AppColors.accent),
          ),
        ],
      ),
    );
  }
}

class _SettingItem {
  final String label, value;
  final IconData icon;
  const _SettingItem(this.label, this.value, this.icon);
}

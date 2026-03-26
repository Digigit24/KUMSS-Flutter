import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class MessageTemplatesScreen extends StatelessWidget {
  const MessageTemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final templates = [
      _Template('Fee Payment Reminder', 'Automated fee reminder sent to students', 'SMS', true),
      _Template('Exam Schedule', 'Exam date notification template', 'Email', true),
      _Template('Leave Approval', 'Notification when leave is approved', 'Push', true),
      _Template('Event Invitation', 'Generic event invitation template', 'All', true),
      _Template('Password Reset', 'Account password reset link', 'Email', true),
      _Template('Welcome Message', 'New student/staff welcome message', 'Email', false),
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Message Templates',
            subtitle: 'Manage reusable message templates',
            breadcrumbs: const ['Home', 'Communication', 'Templates'],
            actions: [AppButton(label: 'Create Template', icon: Icons.add_rounded, onPressed: () {})],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 2),
            itemCount: templates.length,
            itemBuilder: (_, i) {
              final t = templates[i];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppSpacing.borderRadiusLg, border: Border.all(color: AppColors.border)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    const Icon(Icons.text_snippet_rounded, size: 20, color: AppColors.accent),
                    const SizedBox(width: 8),
                    Expanded(child: Text(t.name, style: AppTypography.h4)),
                    t.isActive ? StatusBadge.active() : StatusBadge.inactive(),
                  ]),
                  const SizedBox(height: 8),
                  Text(t.description, style: AppTypography.caption, maxLines: 2),
                  const Spacer(),
                  Row(children: [
                    StatusBadge(label: t.channel, color: AppColors.info),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                  ]),
                ]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Template {
  final String name, description, channel;
  final bool isActive;
  const _Template(this.name, this.description, this.channel, this.isActive);
}

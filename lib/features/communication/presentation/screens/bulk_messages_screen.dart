import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class BulkMessagesScreen extends StatelessWidget {
  const BulkMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Bulk Messages',
            subtitle: 'Send mass messages to users across colleges',
            breadcrumbs: const ['Home', 'Communication', 'Bulk Messages'],
            actions: [AppButton(label: 'New Message', icon: Icons.send_rounded, onPressed: () {})],
          ),
          // Compose form
          AppCard(
            title: 'Compose Message',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Recipient Group'),
                    items: ['All Students', 'All Staff', 'Engineering', 'Medicine', 'Custom Group']
                      .map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                    onChanged: (_) {},
                  )),
                  const SizedBox(width: 16),
                  Expanded(child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Channel'),
                    items: ['SMS', 'Email', 'Push Notification', 'All Channels']
                      .map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (_) {},
                  )),
                ]),
                const SizedBox(height: 16),
                const TextField(decoration: InputDecoration(labelText: 'Subject', hintText: 'Enter message subject')),
                const SizedBox(height: 16),
                const TextField(maxLines: 5, decoration: InputDecoration(labelText: 'Message Body', hintText: 'Type your message here...', alignLabelWithHint: true)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(label: 'Save Draft', variant: AppButtonVariant.outlined, onPressed: () {}),
                    const SizedBox(width: 8),
                    AppButton(label: 'Send Now', icon: Icons.send_rounded, onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Recent messages
          AppCard(
            title: 'Recent Messages',
            child: Column(
              children: [
                _buildMessageItem('Exam Schedule Notification', 'All Students', 'Mar 25, 2026', 'Delivered', 12458),
                _buildMessageItem('Fee Payment Reminder', 'Engineering', 'Mar 23, 2026', 'Delivered', 3240),
                _buildMessageItem('Holiday Notice', 'All Staff', 'Mar 20, 2026', 'Delivered', 847),
                _buildMessageItem('Event Invitation', 'All', 'Mar 18, 2026', 'Failed', 13305),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(String subject, String to, String date, String status, int recipients) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant.withValues(alpha: 0.3),
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        child: Row(
          children: [
            Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.accentSurface, borderRadius: AppSpacing.borderRadiusMd), child: const Icon(Icons.email_rounded, size: 18, color: AppColors.accent)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(subject, style: AppTypography.labelLarge),
              Text('To: $to  |  $recipients recipients', style: AppTypography.caption),
            ])),
            Text(date, style: AppTypography.caption),
            const SizedBox(width: 12),
            StatusBadge(label: status, color: status == 'Delivered' ? AppColors.success : AppColors.error),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class SuperAdminApprovalsScreen extends StatelessWidget {
  const SuperAdminApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final indents = [
      _Indent('IND-2851', 'Lab Equipment - Oscilloscopes (10)', 'Engineering', 'urgent', '\u20B92,50,000', 'Dr. A. Verma', '2 hours ago'),
      _Indent('IND-2849', 'Office Supplies - Stationery Bulk', 'Medicine', 'medium', '\u20B945,000', 'Priya Patel', '5 hours ago'),
      _Indent('IND-2847', 'Computer Systems - Dell Optiplex (25)', 'Business', 'high', '\u20B912,50,000', 'Amit Kumar', '1 day ago'),
      _Indent('IND-2845', 'Library Books - Reference Collection', 'Law', 'low', '\u20B91,80,000', 'Prof. E. Singh', '1 day ago'),
      _Indent('IND-2843', 'Furniture - Classroom Desks (50)', 'Science', 'high', '\u20B93,75,000', 'Dr. F. Nair', '2 days ago'),
      _Indent('IND-2840', 'Chemicals - Lab Reagents', 'Medicine', 'medium', '\u20B968,000', 'Dr. S. Reddy', '3 days ago'),
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'CEO Approvals',
            subtitle: 'Review and approve/reject store indent requests from all colleges',
            breadcrumbs: ['Home', 'Store', 'CEO Approvals'],
          ),
          // Stats
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                _buildApprovalStat('Pending', '${indents.length}', AppColors.warning, Icons.hourglass_top_rounded),
                const SizedBox(width: 16),
                _buildApprovalStat('Approved Today', '12', AppColors.success, Icons.check_circle_rounded),
                const SizedBox(width: 16),
                _buildApprovalStat('Rejected Today', '3', AppColors.error, Icons.cancel_rounded),
                const SizedBox(width: 16),
                _buildApprovalStat('Total Value', '\u20B920.68L', AppColors.accent, Icons.account_balance_wallet_rounded),
              ].map((w) => Expanded(child: w)).toList(),
            ),
          ),
          // Indent cards
          ...indents.map((indent) => _buildIndentCard(context, indent)),
        ],
      ),
    );
  }

  Widget _buildApprovalStat(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusMd),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppTypography.metricSmall),
              Text(label, style: AppTypography.caption),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndentCard(BuildContext context, _Indent indent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
        boxShadow: AppColors.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(indent.id, style: AppTypography.h4.copyWith(color: AppColors.accent)),
              const SizedBox(width: 12),
              StatusBadge.priority(indent.priority),
              const SizedBox(width: 12),
              StatusBadge.pending(),
              const Spacer(),
              Text(indent.time, style: AppTypography.caption),
            ],
          ),
          const SizedBox(height: 12),
          Text(indent.description, style: AppTypography.bodyMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              _detailChip(Icons.apartment_rounded, indent.college),
              const SizedBox(width: 16),
              _detailChip(Icons.person_rounded, indent.requestedBy),
              const SizedBox(width: 16),
              _detailChip(Icons.account_balance_wallet_rounded, indent.amount),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(
                label: 'Reject',
                variant: AppButtonVariant.outlined,
                icon: Icons.close_rounded,
                size: AppButtonSize.sm,
                onPressed: () => _showRejectDialog(context, indent.id),
              ),
              const SizedBox(width: 8),
              AppButton(
                label: 'Approve',
                icon: Icons.check_rounded,
                size: AppButtonSize.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textTertiary),
        const SizedBox(width: 6),
        Text(label, style: AppTypography.bodySmall),
      ],
    );
  }

  void _showRejectDialog(BuildContext context, String indentId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Reject $indentId'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Please provide a reason for rejection:', style: AppTypography.bodySmall),
              const SizedBox(height: 12),
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter reason for rejection (required)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }
}

class _Indent {
  final String id, description, college, priority, amount, requestedBy, time;
  const _Indent(this.id, this.description, this.college, this.priority, this.amount, this.requestedBy, this.time);
}

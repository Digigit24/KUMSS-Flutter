import 'package:flutter/material.dart';
import '../theme/theme_exports.dart';

enum BadgeVariant { filled, outlined, soft }

/// A pill-shaped status badge with semantic coloring.
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final BadgeVariant variant;
  final IconData? icon;
  final double? fontSize;

  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
    this.variant = BadgeVariant.soft,
    this.icon,
    this.fontSize,
  });

  factory StatusBadge.active({String label = 'Active'}) => StatusBadge(
        label: label,
        color: AppColors.success,
      );

  factory StatusBadge.inactive({String label = 'Inactive'}) => StatusBadge(
        label: label,
        color: AppColors.textTertiary,
      );

  factory StatusBadge.pending({String label = 'Pending'}) => StatusBadge(
        label: label,
        color: AppColors.warning,
      );

  factory StatusBadge.approved({String label = 'Approved'}) => StatusBadge(
        label: label,
        color: AppColors.success,
      );

  factory StatusBadge.rejected({String label = 'Rejected'}) => StatusBadge(
        label: label,
        color: AppColors.error,
      );

  factory StatusBadge.info({required String label}) => StatusBadge(
        label: label,
        color: AppColors.info,
      );

  factory StatusBadge.priority(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return StatusBadge(
          label: 'Urgent',
          color: AppColors.priorityUrgent,
          variant: BadgeVariant.filled,
        );
      case 'high':
        return StatusBadge(label: 'High', color: AppColors.priorityHigh);
      case 'medium':
        return StatusBadge(label: 'Medium', color: AppColors.priorityMedium);
      default:
        return StatusBadge(label: 'Low', color: AppColors.priorityLow);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Border? border;

    switch (variant) {
      case BadgeVariant.filled:
        bgColor = color;
        textColor = Colors.white;
        break;
      case BadgeVariant.outlined:
        bgColor = Colors.transparent;
        textColor = color;
        border = Border.all(color: color, width: 1);
        break;
      case BadgeVariant.soft:
        bgColor = color.withValues(alpha: 0.1);
        textColor = color;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppSpacing.borderRadiusFull,
        border: border,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTypography.tag.copyWith(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

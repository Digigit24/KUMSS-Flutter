import 'package:flutter/material.dart';
import '../theme/theme_exports.dart';

/// Dashboard metric card with icon, value, label, and optional trend.
class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBgColor;
  final String? trend;
  final bool? trendUp;
  final VoidCallback? onTap;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor,
    this.iconBgColor,
    this.trend,
    this.trendUp,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
        boxShadow: AppColors.shadowSm,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppSpacing.borderRadiusLg,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSpacing.borderRadiusLg,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: iconBgColor ?? AppColors.primarySurface,
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                      child: Icon(
                        icon,
                        size: 18,
                        color: iconColor ?? AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    if (trend != null) _buildTrend(),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  value,
                  style: AppTypography.metricSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: AppTypography.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrend() {
    final isUp = trendUp ?? true;
    final color = isUp ? AppColors.success : AppColors.error;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 3),
          Text(
            trend!,
            style: AppTypography.tag.copyWith(color: color, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

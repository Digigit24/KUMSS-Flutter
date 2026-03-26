import 'package:flutter/material.dart';
import '../theme/theme_exports.dart';

/// A consistent page header with title, breadcrumb, and actions.
class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<String>? breadcrumbs;
  final List<Widget>? actions;

  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.breadcrumbs,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (breadcrumbs != null && breadcrumbs!.isNotEmpty) ...[
            _buildBreadcrumbs(),
            const SizedBox(height: 8),
          ],
          if (isMobile) ...[
            Text(title, style: AppTypography.h1, maxLines: 2, overflow: TextOverflow.ellipsis),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle!, style: AppTypography.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
            if (actions != null) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: actions!,
              ),
            ],
          ] else
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTypography.h1),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(subtitle!, style: AppTypography.bodySmall),
                      ],
                    ],
                  ),
                ),
                if (actions != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!
                        .map((a) => Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: a,
                            ))
                        .toList(),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: breadcrumbs!.asMap().entries.map((entry) {
          final isLast = entry.key == breadcrumbs!.length - 1;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                entry.value,
                style: AppTypography.caption.copyWith(
                  color: isLast ? AppColors.textSecondary : AppColors.textTertiary,
                  fontWeight: isLast ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.chevron_right, size: 14, color: AppColors.textTertiary),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

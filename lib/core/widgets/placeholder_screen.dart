import 'package:flutter/material.dart';
import '../theme/theme_exports.dart';
import 'widget_exports.dart';

/// A placeholder screen used for routes that are defined but not yet
/// fully implemented with custom UI.
class PlaceholderScreen extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<String> breadcrumbs;
  final IconData icon;

  const PlaceholderScreen({
    super.key,
    required this.title,
    this.subtitle,
    this.breadcrumbs = const [],
    this.icon = Icons.construction_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: title,
            subtitle: subtitle ?? 'This module is under development',
            breadcrumbs: breadcrumbs,
          ),
          EmptyState(
            icon: icon,
            title: '$title Module',
            subtitle: 'This feature is being built. The full implementation\nwill include complete CRUD operations and analytics.',
          ),
        ],
      ),
    );
  }
}

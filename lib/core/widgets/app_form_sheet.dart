import 'package:flutter/material.dart';
import '../theme/theme_exports.dart';

/// A styled bottom sheet with a title, form fields, and action buttons.
/// Use [AppFormSheet.show] to display it from any screen.
class AppFormSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> fields;
  final String submitLabel;
  final IconData? submitIcon;
  final VoidCallback? onSubmit;
  final Color? submitColor;

  const AppFormSheet({
    super.key,
    required this.title,
    this.subtitle,
    required this.fields,
    this.submitLabel = 'Save',
    this.submitIcon,
    this.onSubmit,
    this.submitColor,
  });

  /// Show this bottom sheet from any context.
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    String? subtitle,
    required List<Widget> fields,
    String submitLabel = 'Save',
    IconData? submitIcon,
    Color? submitColor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AppFormSheet(
        title: title,
        subtitle: subtitle,
        fields: fields,
        submitLabel: submitLabel,
        submitIcon: submitIcon,
        submitColor: submitColor,
        onSubmit: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 8, 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTypography.h2),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(subtitle!, style: AppTypography.caption),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, size: 22),
                  style: IconButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          // Form fields
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 16 + bottomInset),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < fields.length; i++) ...[
                    fields[i],
                    if (i < fields.length - 1) const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),
          // Actions
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: onSubmit ?? () => Navigator.pop(context),
                    icon: Icon(submitIcon ?? Icons.check_rounded, size: 18),
                    label: Text(submitLabel),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      backgroundColor:
                          submitColor ?? AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

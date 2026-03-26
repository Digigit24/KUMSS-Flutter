import 'package:flutter/material.dart';
import '../theme/theme_exports.dart';
import 'widget_exports.dart';

/// A generic CRUD list screen template used across all modules.
/// Provides consistent layout: header, search, table, pagination, add/edit dialogs.
class CrudListScreen extends StatefulWidget {
  final String title;
  final String? subtitle;
  final List<String> breadcrumbs;
  final List<AppTableColumn> columns;
  final List<List<Widget>> rows;
  final String entityName;
  final int totalItems;
  final VoidCallback? onAdd;
  final List<Widget>? extraActions;
  final bool isLoading;

  const CrudListScreen({
    super.key,
    required this.title,
    this.subtitle,
    required this.breadcrumbs,
    required this.columns,
    required this.rows,
    required this.entityName,
    this.totalItems = 0,
    this.onAdd,
    this.extraActions,
    this.isLoading = false,
  });

  @override
  State<CrudListScreen> createState() => _CrudListScreenState();
}

class _CrudListScreenState extends State<CrudListScreen> {
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: widget.title,
            subtitle: widget.subtitle,
            breadcrumbs: widget.breadcrumbs,
            actions: [
              if (widget.extraActions != null) ...widget.extraActions!,
              if (widget.onAdd != null)
                AppButton(
                  label: 'Add ${widget.entityName}',
                  icon: Icons.add_rounded,
                  onPressed: widget.onAdd,
                ),
            ],
          ),
          AppDataTable(
            columns: widget.columns,
            rows: widget.rows,
            totalItems: widget.totalItems > 0
                ? widget.totalItems
                : widget.rows.length,
            currentPage: _currentPage,
            pageSize: 10,
            isLoading: widget.isLoading,
            onPageChanged: (page) => setState(() => _currentPage = page),
            onSearch: (query) {
              // Search handled by parent
            },
            searchHint: 'Search ${widget.entityName.toLowerCase()}s...',
            emptyMessage: 'No ${widget.entityName.toLowerCase()}s found',
          ),
        ],
      ),
    );
  }
}

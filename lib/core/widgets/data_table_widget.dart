import 'package:flutter/material.dart';
import '../theme/theme_exports.dart';

/// Column definition for the reusable data table.
class AppTableColumn {
  final String label;
  final double? width;
  final double? flex;
  final bool sortable;
  final TextAlign textAlign;

  const AppTableColumn({
    required this.label,
    this.width,
    this.flex,
    this.sortable = false,
    this.textAlign = TextAlign.left,
  });
}

/// A full-featured data table with search, pagination, and actions.
class AppDataTable extends StatefulWidget {
  final List<AppTableColumn> columns;
  final List<List<Widget>> rows;
  final int totalItems;
  final int currentPage;
  final int pageSize;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<String>? onSearch;
  final String? searchHint;
  final List<Widget>? actions;
  final bool isLoading;
  final String? emptyMessage;
  final Widget? emptyIcon;

  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.totalItems = 0,
    this.currentPage = 1,
    this.pageSize = 10,
    this.onPageChanged,
    this.onSearch,
    this.searchHint,
    this.actions,
    this.isLoading = false,
    this.emptyMessage,
    this.emptyIcon,
  });

  @override
  State<AppDataTable> createState() => _AppDataTableState();
}

class _AppDataTableState extends State<AppDataTable> {
  final _searchController = TextEditingController();

  int get totalPages => (widget.totalItems / widget.pageSize).ceil();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
        boxShadow: AppColors.shadowSm,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToolbar(),
          const Divider(height: 1),
          if (widget.isLoading)
            const Padding(
              padding: EdgeInsets.all(48),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (widget.rows.isEmpty)
            _buildEmpty()
          else
            _buildTable(),
          if (widget.totalItems > widget.pageSize) ...[
            const Divider(height: 1),
            _buildPagination(),
          ],
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    final isMobile =
        MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.onSearch != null)
                  TextField(
                    controller: _searchController,
                    onChanged: widget.onSearch,
                    decoration: InputDecoration(
                      hintText: widget.searchHint ?? 'Search...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      isDense: true,
                    ),
                  ),
                if (widget.actions != null) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.actions!,
                  ),
                ],
              ],
            )
          : Row(
              children: [
                if (widget.onSearch != null)
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: _searchController,
                      onChanged: widget.onSearch,
                      decoration: InputDecoration(
                        hintText: widget.searchHint ?? 'Search...',
                        prefixIcon: const Icon(Icons.search, size: 20),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        isDense: true,
                      ),
                    ),
                  ),
                const Spacer(),
                if (widget.actions != null)
                  Row(
                    children: widget.actions!
                        .map((a) =>
                            Padding(padding: const EdgeInsets.only(left: 8), child: a))
                        .toList(),
                  ),
              ],
            ),
    );
  }

  Widget _buildTable() {
    // Calculate total fixed width from columns
    double totalFixed = 0;
    int flexCount = 0;
    for (final col in widget.columns) {
      if (col.width != null) {
        totalFixed += col.width!;
      } else {
        flexCount++;
      }
    }
    // Ensure minimum width for flex columns (100px each) + fixed + padding
    final minTableWidth = totalFixed + (flexCount * 100) + 32;

    return LayoutBuilder(
      builder: (context, constraints) {
        final tableWidth =
            constraints.maxWidth > minTableWidth ? constraints.maxWidth : minTableWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: tableWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeaderRow(),
                ...widget.rows.asMap().entries.map(
                      (entry) => _buildDataRow(entry.value, entry.key),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      color: AppColors.surfaceVariant,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: widget.columns.map((col) {
          final child = Text(
            col.label.toUpperCase(),
            style: AppTypography.overline.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: col.textAlign,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
          if (col.width != null) {
            return SizedBox(width: col.width, child: child);
          }
          return Expanded(flex: col.flex?.toInt() ?? 1, child: child);
        }).toList(),
      ),
    );
  }

  Widget _buildDataRow(List<Widget> cells, int index) {
    return Container(
      decoration: BoxDecoration(
        color: index.isEven
            ? AppColors.surface
            : AppColors.surfaceVariant.withValues(alpha: 0.3),
        border: const Border(
          bottom: BorderSide(color: AppColors.borderLight),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: List.generate(widget.columns.length, (i) {
          final col = widget.columns[i];
          if (i >= cells.length) return const Expanded(child: SizedBox());
          if (col.width != null) {
            return SizedBox(width: col.width, child: cells[i]);
          }
          return Expanded(
            flex: col.flex?.toInt() ?? 1,
            child: cells[i],
          );
        }),
      ),
    );
  }

  Widget _buildEmpty() {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.emptyIcon ??
                Icon(
                  Icons.inbox_outlined,
                  size: 48,
                  color: AppColors.textTertiary.withValues(alpha: 0.5),
                ),
            const SizedBox(height: 16),
            Text(
              widget.emptyMessage ?? 'No data found',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Flexible(
            child: Text(
              'Showing ${((widget.currentPage - 1) * widget.pageSize) + 1}'
              '–${(widget.currentPage * widget.pageSize).clamp(0, widget.totalItems)}'
              ' of ${widget.totalItems}',
              style: AppTypography.caption,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _paginationButton(
                Icons.chevron_left,
                widget.currentPage > 1
                    ? () => widget.onPageChanged?.call(widget.currentPage - 1)
                    : null,
              ),
              const SizedBox(width: 4),
              _paginationButton(
                Icons.chevron_right,
                widget.currentPage < totalPages
                    ? () => widget.onPageChanged?.call(widget.currentPage + 1)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paginationButton(IconData icon, VoidCallback? onPressed) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          foregroundColor:
              onPressed != null ? AppColors.textSecondary : AppColors.border,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusSm,
            side: const BorderSide(color: AppColors.border),
          ),
        ),
      ),
    );
  }
}

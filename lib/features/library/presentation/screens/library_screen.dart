import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    final columns = [
      const AppTableColumn(label: 'Book', flex: 2),
      const AppTableColumn(label: 'Author', flex: 1),
      const AppTableColumn(label: 'Category', width: 120),
      const AppTableColumn(label: 'Copies', width: 70),
      const AppTableColumn(label: 'Avail', width: 60),
      const AppTableColumn(label: 'Actions', width: 80, textAlign: TextAlign.center),
    ];

    final books = [
      ['Introduction to Algorithms', 'Cormen et al.', 'Computer Science', '15', '3'],
      ['Gray\'s Anatomy', 'Henry Gray', 'Medicine', '10', '0'],
    ];

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(title: 'Library Management', subtitle: 'Book catalog, issues, returns, and fine management', breadcrumbs: const ['Home', 'Library'],
            actions: [AppButton(label: 'Add Book', icon: Icons.add_rounded, onPressed: () => AppFormSheet.show(
              context,
              title: 'Add Book',
              subtitle: 'Add a new book to the catalog',
              submitLabel: 'Add Book',
              submitIcon: Icons.add_rounded,
              fields: [
                TextField(decoration: const InputDecoration(labelText: 'Book Title', hintText: 'e.g. Introduction to Algorithms')),
                TextField(decoration: const InputDecoration(labelText: 'Author', hintText: 'e.g. Cormen et al.')),
                TextField(decoration: const InputDecoration(labelText: 'ISBN', hintText: 'e.g. 978-0-262-03384-8')),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: ['Computer Science', 'Medicine', 'Engineering', 'Business', 'General'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (_) {},
                ),
                TextField(decoration: const InputDecoration(labelText: 'Total Copies', hintText: 'e.g. 15'), keyboardType: TextInputType.number),
              ],
            ))]),
          ResponsiveGrid(children: [
            MetricCard(label: 'Total Books', value: '4,580', icon: Icons.menu_book_rounded, iconColor: AppColors.accent, iconBgColor: AppColors.accentSurface),
            MetricCard(label: 'Issued', value: '240', icon: Icons.bookmark_rounded, iconColor: AppColors.success, iconBgColor: AppColors.successSurface),
            MetricCard(label: 'Overdue', value: '12', icon: Icons.warning_rounded, iconColor: AppColors.error, iconBgColor: AppColors.errorSurface),
            MetricCard(label: 'Fines', value: '\u20B93,200', icon: Icons.payments_rounded, iconColor: AppColors.secondary, iconBgColor: AppColors.secondarySurface),
          ]),
          const SizedBox(height: 20),
          AppDataTable(
            columns: columns,
            rows: books.map((b) => [
              Text(b[0], style: AppTypography.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(b[1], style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              StatusBadge(label: b[2], color: AppColors.info),
              Text(b[3], style: AppTypography.bodySmall),
              Text(b[4], style: AppTypography.bodySmall.copyWith(color: int.parse(b[4]) == 0 ? AppColors.error : AppColors.success, fontWeight: FontWeight.w600)),
              Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 16), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 32, minHeight: 32), style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 16), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 32, minHeight: 32), style: IconButton.styleFrom(foregroundColor: AppColors.error)),
              ]),
            ]).toList(),
            totalItems: books.length,
            onSearch: (_) {},
            searchHint: 'Search by title, author...',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Book', flex: 2),
      const AppTableColumn(label: 'Author', flex: 1),
      const AppTableColumn(label: 'ISBN', width: 140),
      const AppTableColumn(label: 'Category', width: 120),
      const AppTableColumn(label: 'Copies', width: 80),
      const AppTableColumn(label: 'Available', width: 80),
      const AppTableColumn(label: 'Actions', width: 100, textAlign: TextAlign.center),
    ];

    final books = [
      ['Introduction to Algorithms', 'Cormen et al.', '978-0262033848', 'Computer Science', '15', '3'],
      ['Gray\'s Anatomy', 'Henry Gray', '978-0702052309', 'Medicine', '10', '0'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Library Management',
            subtitle: 'Book catalog, issues, returns, and fine management',
            breadcrumbs: const ['Home', 'Library'],
            actions: [
              AppButton(label: 'Issue Book', icon: Icons.library_add_rounded, variant: AppButtonVariant.outlined, onPressed: () {}),
              AppButton(label: 'Add Book', icon: Icons.add_rounded, onPressed: () {}),
            ],
          ),
          Row(
            children: [
              Expanded(child: MetricCard(label: 'Total Books', value: '4,580', icon: Icons.menu_book_rounded, iconColor: AppColors.accent, iconBgColor: AppColors.accentSurface)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'Issued', value: '240', icon: Icons.bookmark_rounded, iconColor: AppColors.success, iconBgColor: AppColors.successSurface)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'Overdue', value: '12', icon: Icons.warning_rounded, iconColor: AppColors.error, iconBgColor: AppColors.errorSurface)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'Fines Collected', value: '\u20B93,200', icon: Icons.payments_rounded, iconColor: AppColors.secondary, iconBgColor: AppColors.secondarySurface)),
            ],
          ),
          const SizedBox(height: 24),
          AppDataTable(
            columns: columns,
            rows: books.map((b) => [
              Row(children: [
                Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: AppSpacing.borderRadiusMd), child: const Icon(Icons.book_rounded, size: 18, color: AppColors.primary)),
                const SizedBox(width: 10),
                Expanded(child: Text(b[0], style: AppTypography.labelLarge)),
              ]),
              Text(b[1], style: AppTypography.bodySmall),
              Text(b[2], style: AppTypography.caption),
              StatusBadge(label: b[3], color: AppColors.info),
              Text(b[4], style: AppTypography.bodySmall),
              Text(b[5], style: AppTypography.bodySmall.copyWith(
                color: int.parse(b[5]) == 0 ? AppColors.error : AppColors.success,
                fontWeight: FontWeight.w600,
              )),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(icon: const Icon(Icons.edit_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18), onPressed: () {}, style: IconButton.styleFrom(foregroundColor: AppColors.error)),
              ]),
            ]).toList(),
            totalItems: books.length,
            onSearch: (_) {},
            searchHint: 'Search by title, author, ISBN...',
          ),
        ],
      ),
    );
  }
}

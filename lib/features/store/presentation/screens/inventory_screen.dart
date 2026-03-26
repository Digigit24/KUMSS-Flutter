import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = [
      const AppTableColumn(label: 'Item', flex: 2),
      const AppTableColumn(label: 'Category', flex: 1),
      const AppTableColumn(label: 'Store', flex: 1),
      const AppTableColumn(label: 'Qty', width: 80),
      const AppTableColumn(label: 'Min Qty', width: 80),
      const AppTableColumn(label: 'Unit Price', width: 100),
      const AppTableColumn(label: 'Status', width: 100),
    ];

    final items = [
      ['Dell Optiplex 7090', 'Electronics', 'Central', '42', '10', '\u20B955,000', 'ok'],
      ['Chemical Reagent Kit', 'Lab Supplies', 'Medicine', '8', '20', '\u20B92,200', 'critical'],
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Inventory',
            subtitle: 'Stock and inventory management',
            breadcrumbs: const ['Home', 'Store', 'Inventory'],
            actions: [
              AppButton(label: 'Export', icon: Icons.download_rounded, variant: AppButtonVariant.outlined, onPressed: () {}),
              AppButton(label: 'Add Item', icon: Icons.add_rounded, onPressed: () {}),
            ],
          ),
          AppDataTable(
            columns: columns,
            rows: items.map((item) => [
              Text(item[0], style: AppTypography.labelLarge),
              Text(item[1], style: AppTypography.bodySmall),
              Text(item[2], style: AppTypography.bodySmall),
              Text(item[3], style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
              Text(item[4], style: AppTypography.bodySmall),
              Text(item[5], style: AppTypography.bodySmall),
              _stockBadge(item[6]),
            ]).toList(),
            totalItems: items.length,
            onSearch: (_) {},
            searchHint: 'Search inventory...',
          ),
        ],
      ),
    );
  }

  Widget _stockBadge(String status) {
    return switch (status) {
      'ok' => const StatusBadge(label: 'In Stock', color: AppColors.success),
      'low' => const StatusBadge(label: 'Low Stock', color: AppColors.warning),
      'critical' => const StatusBadge(label: 'Critical', color: AppColors.error),
      _ => const StatusBadge(label: 'Unknown', color: AppColors.textTertiary),
    };
  }
}

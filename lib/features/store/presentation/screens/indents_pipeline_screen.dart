import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class IndentsPipelineScreen extends StatelessWidget {
  const IndentsPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stages = [
      _Stage('Draft', AppColors.textTertiary, ['IND-2855', 'IND-2856']),
      _Stage('Submitted', AppColors.info, ['IND-2852', 'IND-2853', 'IND-2854']),
      _Stage('College Approved', AppColors.accent, ['IND-2849', 'IND-2851']),
      _Stage('CEO Pending', AppColors.warning, ['IND-2847', 'IND-2845']),
      _Stage('Approved', AppColors.success, ['IND-2840', 'IND-2838', 'IND-2835']),
      _Stage('Procured', AppColors.primary, ['IND-2830']),
    ];

    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Indents Pipeline',
            subtitle: 'End-to-end indent workflow tracking',
            breadcrumbs: ['Home', 'Store', 'Indents Pipeline'],
          ),
          SizedBox(
            height: 500,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: stages.map((stage) {
                  return Container(
                    width: 220,
                    margin: const EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stage header
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: stage.color.withValues(alpha: 0.1),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            border: Border.all(color: stage.color.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8, height: 8,
                                decoration: BoxDecoration(color: stage.color, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 8),
                              Text(stage.name, style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w600, color: stage.color)),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: stage.color.withValues(alpha: 0.15), borderRadius: AppSpacing.borderRadiusFull),
                                child: Text('${stage.items.length}', style: AppTypography.tag.copyWith(color: stage.color, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                        // Cards
                        ...stage.items.map((item) => Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: AppSpacing.borderRadiusMd,
                            border: Border.all(color: AppColors.border),
                            boxShadow: AppColors.shadowSm,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item, style: AppTypography.labelMedium.copyWith(color: AppColors.accent)),
                              const SizedBox(height: 4),
                              Text('Equipment request', style: AppTypography.caption),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.apartment_rounded, size: 12, color: AppColors.textTertiary),
                                  const SizedBox(width: 4),
                                  Text('Engineering', style: AppTypography.caption),
                                ],
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stage {
  final String name;
  final Color color;
  final List<String> items;
  const _Stage(this.name, this.color, this.items);
}

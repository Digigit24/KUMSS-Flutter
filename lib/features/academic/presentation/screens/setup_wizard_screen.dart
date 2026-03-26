import 'package:flutter/material.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class SetupWizardScreen extends StatefulWidget {
  const SetupWizardScreen({super.key});

  @override
  State<SetupWizardScreen> createState() => _SetupWizardScreenState();
}

class _SetupWizardScreenState extends State<SetupWizardScreen> {
  int _currentStep = 0;

  final _steps = [
    _WizardStep('Academic Year', 'Define academic year period', Icons.date_range_rounded),
    _WizardStep('Sessions', 'Set up semesters/terms', Icons.calendar_month_rounded),
    _WizardStep('Faculties', 'Create faculties', Icons.domain_rounded),
    _WizardStep('Programs', 'Add degree programs', Icons.menu_book_rounded),
    _WizardStep('Classes', 'Define class batches', Icons.class_rounded),
    _WizardStep('Sections', 'Create sections', Icons.grid_view_rounded),
    _WizardStep('Subjects', 'Add subject catalog', Icons.subject_rounded),
    _WizardStep('Review', 'Verify and finalize', Icons.fact_check_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Academic Setup Wizard',
            subtitle: 'Quick setup for a new academic year',
            breadcrumbs: ['Home', 'Academic', 'Setup Wizard'],
          ),
          // Step indicator
          Container(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppSpacing.borderRadiusLg,
              border: Border.all(color: AppColors.border),
              boxShadow: AppColors.shadowSm,
            ),
            child: Column(
              children: [
                // Step progress bar
                isMobile
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(_steps.length, (i) => _buildStepCircle(i)),
                        ),
                      )
                    : Row(
                        children: List.generate(_steps.length, (i) {
                          final isCompleted = i < _currentStep;
                          final isCurrent = i == _currentStep;
                          return Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: isCompleted
                                        ? AppColors.success
                                        : isCurrent
                                            ? AppColors.primary
                                            : AppColors.surfaceVariant,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: isCompleted
                                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                                        : Text(
                                            '${i + 1}',
                                            style: AppTypography.labelSmall.copyWith(
                                              color: isCurrent ? Colors.white : AppColors.textTertiary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),
                                if (i < _steps.length - 1)
                                  Expanded(
                                    child: Container(
                                      height: 2,
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      color: isCompleted ? AppColors.success : AppColors.border,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }),
                      ),
                const SizedBox(height: 8),
                // Step labels
                if (!isMobile)
                  Row(
                    children: _steps.map((s) {
                      final i = _steps.indexOf(s);
                      final isCurrent = i == _currentStep;
                      return Expanded(
                        child: Text(
                          s.title,
                          style: AppTypography.caption.copyWith(
                            color: isCurrent ? AppColors.primary : AppColors.textTertiary,
                            fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                if (isMobile)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Step ${_currentStep + 1}: ${_steps[_currentStep].title}',
                      style: AppTypography.labelMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                const SizedBox(height: 32),
                // Current step content
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isMobile ? 20 : 32),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant.withValues(alpha: 0.3),
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(_steps[_currentStep].icon, size: 28, color: AppColors.primary),
                      ),
                      const SizedBox(height: 16),
                      Text(_steps[_currentStep].title, style: AppTypography.h2),
                      const SizedBox(height: 8),
                      Text(_steps[_currentStep].description, style: AppTypography.bodySmall),
                      const SizedBox(height: 24),
                      // Placeholder form
                      SizedBox(
                        width: isMobile ? double.infinity : 400,
                        child: Column(
                          children: [
                            const TextField(decoration: InputDecoration(labelText: 'Name', hintText: 'Enter name')),
                            const SizedBox(height: 16),
                            const TextField(decoration: InputDecoration(labelText: 'Code', hintText: 'Enter code')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Navigation buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      label: 'Previous',
                      icon: Icons.arrow_back_rounded,
                      variant: AppButtonVariant.outlined,
                      onPressed: _currentStep > 0
                          ? () => setState(() => _currentStep--)
                          : null,
                    ),
                    AppButton(
                      label: _currentStep == _steps.length - 1 ? 'Complete Setup' : 'Next',
                      icon: _currentStep == _steps.length - 1
                          ? Icons.check_rounded
                          : Icons.arrow_forward_rounded,
                      onPressed: () {
                        if (_currentStep < _steps.length - 1) {
                          setState(() => _currentStep++);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int i) {
    final isCompleted = i < _currentStep;
    final isCurrent = i == _currentStep;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isCompleted
                ? AppColors.success
                : isCurrent
                    ? AppColors.primary
                    : AppColors.surfaceVariant,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : Text(
                    '${i + 1}',
                    style: AppTypography.labelSmall.copyWith(
                      color: isCurrent ? Colors.white : AppColors.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        if (i < _steps.length - 1)
          Container(
            width: 24,
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: isCompleted ? AppColors.success : AppColors.border,
          ),
      ],
    );
  }
}

class _WizardStep {
  final String title, description;
  final IconData icon;
  const _WizardStep(this.title, this.description, this.icon);
}

import 'package:flutter/material.dart';
import '../theme/theme_exports.dart';

enum AppButtonVariant { primary, secondary, outlined, ghost, danger }
enum AppButtonSize { sm, md, lg }

/// A versatile button with multiple variants and sizes.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final height = switch (size) {
      AppButtonSize.sm => AppSpacing.buttonHeightSm,
      AppButtonSize.md => AppSpacing.buttonHeightMd,
      AppButtonSize.lg => AppSpacing.buttonHeightLg,
    };

    final textStyle = switch (size) {
      AppButtonSize.sm => AppTypography.buttonSmall,
      AppButtonSize.md => AppTypography.buttonMedium,
      AppButtonSize.lg => AppTypography.buttonLarge,
    };

    final horizontalPad = switch (size) {
      AppButtonSize.sm => 12.0,
      AppButtonSize.md => 20.0,
      AppButtonSize.lg => 24.0,
    };

    final (bgColor, fgColor, borderSide) = switch (variant) {
      AppButtonVariant.primary => (
          AppColors.primary,
          AppColors.white,
          BorderSide.none,
        ),
      AppButtonVariant.secondary => (
          AppColors.accent,
          AppColors.white,
          BorderSide.none,
        ),
      AppButtonVariant.outlined => (
          Colors.transparent,
          AppColors.textPrimary,
          const BorderSide(color: AppColors.border),
        ),
      AppButtonVariant.ghost => (
          Colors.transparent,
          AppColors.textSecondary,
          BorderSide.none,
        ),
      AppButtonVariant.danger => (
          AppColors.error,
          AppColors.white,
          BorderSide.none,
        ),
    };

    Widget child;
    if (isLoading) {
      child = SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(fgColor),
        ),
      );
    } else {
      child = Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: size == AppButtonSize.sm ? 16 : 18),
            const SizedBox(width: 8),
          ],
          Text(label, style: textStyle.copyWith(color: fgColor)),
        ],
      );
    }

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: horizontalPad),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            side: borderSide,
          ),
          disabledBackgroundColor: bgColor.withValues(alpha: 0.6),
        ),
        child: child,
      ),
    );
  }
}

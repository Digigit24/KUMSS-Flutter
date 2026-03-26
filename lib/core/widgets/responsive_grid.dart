import 'package:flutter/material.dart';
import '../theme/theme_exports.dart';

/// A responsive grid that shows items in a row on desktop and wraps on mobile.
/// Used for stat cards, metric rows, etc.
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final int desktopColumns;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 12,
    this.desktopColumns = 4,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppSpacing.mobileBreakpoint;
    final columns = isMobile ? 2 : desktopColumns;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: columns,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      childAspectRatio: isMobile ? 1.6 : 2.2,
      children: children,
    );
  }
}

/// A responsive two-column layout that stacks vertically on mobile.
class ResponsiveRow extends StatelessWidget {
  final Widget left;
  final Widget right;
  final int leftFlex;
  final int rightFlex;
  final double spacing;

  const ResponsiveRow({
    super.key,
    required this.left,
    required this.right,
    this.leftFlex = 3,
    this.rightFlex = 2,
    this.spacing = 20,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

    if (isMobile) {
      return Column(children: [left, SizedBox(height: spacing), right]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: leftFlex, child: left),
        SizedBox(width: spacing),
        Expanded(flex: rightFlex, child: right),
      ],
    );
  }
}

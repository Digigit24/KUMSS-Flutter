import 'package:flutter/material.dart';

/// KUMSS ERP Design System — Spacing & Dimensions
/// 4px base grid system for consistent spatial rhythm.
class AppSpacing {
  AppSpacing._();

  // ─── Base Unit ────────────────────────────────────────────
  static const double unit = 4.0;

  // ─── Spacing Scale ────────────────────────────────────────
  static const double xs = 4.0;    // 1 unit
  static const double sm = 8.0;    // 2 units
  static const double md = 12.0;   // 3 units
  static const double lg = 16.0;   // 4 units
  static const double xl = 20.0;   // 5 units
  static const double xxl = 24.0;  // 6 units
  static const double xxxl = 32.0; // 8 units
  static const double huge = 40.0; // 10 units
  static const double massive = 48.0; // 12 units

  // ─── Page Padding ─────────────────────────────────────────
  static const EdgeInsets pagePadding = EdgeInsets.all(24.0);
  static const EdgeInsets pagePaddingHorizontal =
      EdgeInsets.symmetric(horizontal: 24.0);
  static const EdgeInsets pagePaddingMobile = EdgeInsets.all(16.0);

  // ─── Card Padding ─────────────────────────────────────────
  static const EdgeInsets cardPadding = EdgeInsets.all(20.0);
  static const EdgeInsets cardPaddingCompact = EdgeInsets.all(16.0);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(24.0);

  // ─── Border Radius ────────────────────────────────────────
  static const double radiusXs = 4.0;
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusXxl = 20.0;
  static const double radiusFull = 999.0;

  static BorderRadius get borderRadiusXs =>
      BorderRadius.circular(radiusXs);
  static BorderRadius get borderRadiusSm =>
      BorderRadius.circular(radiusSm);
  static BorderRadius get borderRadiusMd =>
      BorderRadius.circular(radiusMd);
  static BorderRadius get borderRadiusLg =>
      BorderRadius.circular(radiusLg);
  static BorderRadius get borderRadiusXl =>
      BorderRadius.circular(radiusXl);
  static BorderRadius get borderRadiusXxl =>
      BorderRadius.circular(radiusXxl);
  static BorderRadius get borderRadiusFull =>
      BorderRadius.circular(radiusFull);

  // ─── Layout Dimensions ───────────────────────────────────
  static const double sidebarWidth = 260.0;
  static const double sidebarCollapsedWidth = 72.0;
  static const double headerHeight = 64.0;
  static const double mobileBreakpoint = 768.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1280.0;

  // ─── Content Constraints ─────────────────────────────────
  static const double maxContentWidth = 1440.0;
  static const double formMaxWidth = 640.0;
  static const double dialogMaxWidth = 520.0;
  static const double tableMinWidth = 800.0;

  // ─── Icon Sizes ──────────────────────────────────────────
  static const double iconXs = 14.0;
  static const double iconSm = 16.0;
  static const double iconMd = 20.0;
  static const double iconLg = 24.0;
  static const double iconXl = 28.0;
  static const double iconXxl = 32.0;

  // ─── Avatar Sizes ────────────────────────────────────────
  static const double avatarSm = 28.0;
  static const double avatarMd = 36.0;
  static const double avatarLg = 44.0;
  static const double avatarXl = 56.0;

  // ─── Button Heights ──────────────────────────────────────
  static const double buttonHeightSm = 32.0;
  static const double buttonHeightMd = 40.0;
  static const double buttonHeightLg = 48.0;

  // ─── Input Heights ───────────────────────────────────────
  static const double inputHeight = 44.0;
  static const double inputHeightSm = 36.0;
}

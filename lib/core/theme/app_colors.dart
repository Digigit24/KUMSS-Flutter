import 'package:flutter/material.dart';

/// KUMSS ERP Design System — Color Palette
/// A sophisticated, modern enterprise color system with
/// deep navy primary, warm accents, and carefully crafted neutrals.
class AppColors {
  AppColors._();

  // ─── Brand Primary (Deep Navy) ───────────────────────────
  static const Color primary = Color(0xFF1B2A4A);
  static const Color primaryLight = Color(0xFF2D4373);
  static const Color primaryDark = Color(0xFF0F1A2E);
  static const Color primarySurface = Color(0xFFF0F3F9);

  // ─── Accent (Vibrant Teal) ───────────────────────────────
  static const Color accent = Color(0xFF00B4D8);
  static const Color accentLight = Color(0xFF48CAE4);
  static const Color accentDark = Color(0xFF0096B7);
  static const Color accentSurface = Color(0xFFE8F8FC);

  // ─── Secondary (Warm Amber) ──────────────────────────────
  static const Color secondary = Color(0xFFF59E0B);
  static const Color secondaryLight = Color(0xFFFBBF24);
  static const Color secondaryDark = Color(0xFFD97706);
  static const Color secondarySurface = Color(0xFFFFF8E1);

  // ─── Success ─────────────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);
  static const Color successSurface = Color(0xFFECFDF5);

  // ─── Warning ─────────────────────────────────────────────
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  static const Color warningSurface = Color(0xFFFFFBEB);

  // ─── Error ───────────────────────────────────────────────
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color errorSurface = Color(0xFFFEF2F2);

  // ─── Info ────────────────────────────────────────────────
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);
  static const Color infoSurface = Color(0xFFEFF6FF);

  // ─── Neutrals ────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color divider = Color(0xFFE2E8F0);

  // ─── Text Colors ─────────────────────────────────────────
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textInverse = Color(0xFFFFFFFF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ─── Sidebar ─────────────────────────────────────────────
  static const Color sidebarBg = Color(0xFF0F172A);
  static const Color sidebarItemHover = Color(0xFF1E293B);
  static const Color sidebarItemActive = Color(0xFF1B2A4A);
  static const Color sidebarText = Color(0xFF94A3B8);
  static const Color sidebarTextActive = Color(0xFFFFFFFF);
  static const Color sidebarIcon = Color(0xFF64748B);
  static const Color sidebarIconActive = Color(0xFF00B4D8);

  // ─── Chart Colors ────────────────────────────────────────
  static const List<Color> chartColors = [
    Color(0xFF00B4D8),
    Color(0xFF1B2A4A),
    Color(0xFFF59E0B),
    Color(0xFF10B981),
    Color(0xFFEF4444),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
    Color(0xFF06B6D4),
  ];

  // ─── Priority Colors ────────────────────────────────────
  static const Color priorityLow = Color(0xFF10B981);
  static const Color priorityMedium = Color(0xFFF59E0B);
  static const Color priorityHigh = Color(0xFFF97316);
  static const Color priorityUrgent = Color(0xFFEF4444);

  // ─── Status Colors ──────────────────────────────────────
  static const Color statusActive = Color(0xFF10B981);
  static const Color statusInactive = Color(0xFF94A3B8);
  static const Color statusPending = Color(0xFFF59E0B);
  static const Color statusApproved = Color(0xFF10B981);
  static const Color statusRejected = Color(0xFFEF4444);

  // ─── Gradient Definitions ───────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accentLight],
  );

  static const LinearGradient sidebarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F172A), Color(0xFF1B2A4A)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
  );

  // ─── Shadows ─────────────────────────────────────────────
  static List<BoxShadow> get shadowSm => [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.04),
          blurRadius: 6,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get shadowMd => [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.06),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowLg => [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get shadowXl => [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.12),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ];
}

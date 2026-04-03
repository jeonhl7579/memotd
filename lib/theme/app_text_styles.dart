import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography scale for "The Fluid Architect" design system.
///
/// Display / Headline → Manrope (editorial, geometric)
/// Title / Body / Label → Inter (functional clarity)
abstract class AppTextStyles {
  // ── Display ──────────────────────────────────────────────────────────────
  /// 2.75rem / 700 — Large hero date or progress percentage
  static TextStyle get displayMd => GoogleFonts.manrope(
        fontSize: 44,
        fontWeight: FontWeight.w700,
        color: AppColors.onSurface,
        height: 1.1,
      );

  // ── Headline ─────────────────────────────────────────────────────────────
  /// 1.5rem / 600 — Section headers (e.g. "Today")
  static TextStyle get headlineSm => GoogleFonts.manrope(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
        height: 1.2,
      );

  // ── Title ─────────────────────────────────────────────────────────────────
  /// 1.125rem / 500 — Memo titles, task descriptions
  static TextStyle get titleMd => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
        height: 1.4,
      );

  // ── Body ──────────────────────────────────────────────────────────────────
  /// 0.875rem / 400 — Notes and secondary metadata
  static TextStyle get bodyMd => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.onSurface,
        height: 1.5,
      );

  // ── Label ─────────────────────────────────────────────────────────────────
  /// 0.6875rem / 600 — Tag labels (All Caps)
  static TextStyle get labelSm => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
        letterSpacing: 0.8,
      );

  // ── Convenience variants ─────────────────────────────────────────────────
  static TextStyle get bodyMdSubtle => bodyMd.copyWith(
        color: AppColors.onSurfaceVariant,
      );

  static TextStyle get labelSmOnContainer => labelSm.copyWith(
        color: AppColors.onTertiaryContainer,
      );
}

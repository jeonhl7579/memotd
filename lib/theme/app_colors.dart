import 'package:flutter/material.dart';

/// Design token: "The Fluid Architect"
/// Surface hierarchy follows a tonal layering system — no explicit borders.
abstract class AppColors {
  // ── Surface Layers ──────────────────────────────────────────────────────
  /// Base background (#faf9fe)
  static const Color surface = Color(0xFFFAF9FE);

  /// Secondary content containers (#f3f3fa)
  static const Color surfaceContainerLow = Color(0xFFF3F3FA);

  /// Active / elevated card surface (#ffffff)
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);

  /// Mid-level container
  static const Color surfaceContainer = Color(0xFFECECF4);

  /// Glassmorphism nav bar base (#e6e4f0 @ 70%)
  static const Color surfaceContainerHighest = Color(0xFFE6E4F0);

  // ── Primary ─────────────────────────────────────────────────────────────
  /// Intelligence blue (#005bc4)
  static const Color primary = Color(0xFF005BC4);

  /// Gradient endpoint for signature texture (#4388fd)
  static const Color primaryContainer = Color(0xFF4388FD);

  static const Color onPrimary = Color(0xFFFFFFFF);

  // ── Secondary ───────────────────────────────────────────────────────────
  static const Color secondaryContainer = Color(0xFFDBE2F9);
  static const Color onSecondaryContainer = Color(0xFF0F1B3E);

  // ── Tertiary ────────────────────────────────────────────────────────────
  static const Color tertiaryContainer = Color(0xFFE4CEFF);
  static const Color onTertiaryContainer = Color(0xFF210061);

  /// Calendar "partial" indicator (#d6c0f0)
  static const Color tertiaryFixedDim = Color(0xFFD6C0F0);

  // ── On-Surface / Text ───────────────────────────────────────────────────
  /// Default text — never pure black (#2f323a)
  static const Color onSurface = Color(0xFF2F323A);

  /// Muted / secondary text
  static const Color onSurfaceVariant = Color(0xFF5A5D6B);

  /// Placeholder / hint text — very subtle (#dbd9e4)
  static const Color hintText = Color(0xFFDBD9E4);

  // ── Outline ─────────────────────────────────────────────────────────────
  /// Ghost border base — must be used at ≤ 15% opacity
  static const Color outline = Color(0xFF8B8D9C);
  static const Color outlineVariant = Color(0xFFC5C6D6);

  // ── Elevation / Shadow ──────────────────────────────────────────────────
  /// Ambient shadow tint — use rgba(47, 50, 58, 0.06)
  static const Color shadowTint = Color(0xFF2F323A);

  // ── Gradients ───────────────────────────────────────────────────────────
  /// Signature texture for FAB / primary buttons (135°)
  static const LinearGradient signatureGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [primary, primaryContainer],
  );

  // ── Dark Mode Equivalents ────────────────────────────────────────────────
  static const Color surfaceDark = Color(0xFF111318);
  static const Color surfaceContainerLowDark = Color(0xFF1D1E24);
  static const Color surfaceContainerLowestDark = Color(0xFF0E0F13);
  static const Color surfaceContainerDark = Color(0xFF22232A);
  static const Color surfaceContainerHighestDark = Color(0xFF33343C);
  static const Color onSurfaceDark = Color(0xFFE3E2EA);
  static const Color onSurfaceVariantDark = Color(0xFFC5C6D6);
}

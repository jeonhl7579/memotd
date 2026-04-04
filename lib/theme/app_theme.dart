import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract class AppTheme {
  // ── Public entrypoints ────────────────────────────────────────────────────

  static ThemeData get light => _build(scheme: _lightScheme);
  static ThemeData get dark => _build(scheme: _darkScheme);

  // ── Color Schemes ─────────────────────────────────────────────────────────

  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,

    // Primary — "Intelligence Blue"
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.onPrimary,

    // Secondary — Subtle indigo tint
    secondary: Color(0xFF415F91),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer,

    // Tertiary — Soft purple accent
    tertiary: Color(0xFF6B3FA0),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: AppColors.tertiaryContainer,
    onTertiaryContainer: AppColors.onTertiaryContainer,

    // Error
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    // Surface hierarchy (tonal layering — "frosted glass" stack)
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    surfaceContainerLowest: AppColors.surfaceContainerLowest,
    surfaceContainerLow: AppColors.surfaceContainerLow,
    surfaceContainer: AppColors.surfaceContainer,
    surfaceContainerHigh: AppColors.surfaceContainerHighest,
    surfaceContainerHighest: AppColors.surfaceContainerHighest,

    // Outline — "Ghost Border" base; use at ≤ 15% opacity in widgets
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,

    // Misc
    shadow: AppColors.shadowTint,
    scrim: AppColors.shadowTint,
    inverseSurface: AppColors.onSurface,
    onInverseSurface: AppColors.surface,
    inversePrimary: AppColors.primaryContainer,
  );

  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,

    // Primary — lighter hue for dark backgrounds
    primary: AppColors.primaryContainer,
    onPrimary: Color(0xFF002E6F),
    primaryContainer: AppColors.primary,
    onPrimaryContainer: Color(0xFFD6E3FF),

    // Secondary
    secondary: Color(0xFFAAC7FF),
    onSecondary: Color(0xFF0D2855),
    secondaryContainer: Color(0xFF2A3F6F),
    onSecondaryContainer: AppColors.secondaryContainer,

    // Tertiary
    tertiary: Color(0xFFCFBDFF),
    onTertiary: Color(0xFF380096),
    tertiaryContainer: Color(0xFF4F00CB),
    onTertiaryContainer: AppColors.tertiaryContainer,

    // Error
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),

    // Surface hierarchy — dark "frosted glass" stack
    surface: AppColors.surfaceDark,
    onSurface: AppColors.onSurfaceDark,
    onSurfaceVariant: AppColors.onSurfaceVariantDark,
    surfaceContainerLowest: AppColors.surfaceContainerLowestDark,
    surfaceContainerLow: AppColors.surfaceContainerLowDark,
    surfaceContainer: AppColors.surfaceContainerDark,
    surfaceContainerHigh: AppColors.surfaceContainerHighestDark,
    surfaceContainerHighest: AppColors.surfaceContainerHighestDark,

    // Outline
    outline: Color(0xFF8F9099),
    outlineVariant: Color(0xFF44464F),

    // Misc
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: AppColors.onSurfaceDark,
    onInverseSurface: AppColors.surfaceDark,
    inversePrimary: AppColors.primary,
  );

  // ── ThemeData builder ─────────────────────────────────────────────────────

  static ThemeData _build({required ColorScheme scheme}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,

      // Scaffold & scaffold-level background
      scaffoldBackgroundColor: scheme.surface,

      // System UI overlay (status bar / nav bar)
      appBarTheme: _appBarTheme(scheme),

      // Typography
      textTheme: _textTheme(scheme),

      // Components
      cardTheme: _cardTheme(scheme),
      chipTheme: _chipTheme(scheme),
      // Floating Action Button 커스텀으로 인해 비활성화
      // floatingActionButtonTheme: _fabTheme(scheme),
      navigationBarTheme: _navigationBarTheme(scheme),
      checkboxTheme: _checkboxTheme(scheme),
      inputDecorationTheme: _inputDecorationTheme(scheme),
      listTileTheme: _listTileTheme(scheme),
      dividerTheme: _dividerTheme(),
      dialogTheme: _dialogTheme(scheme),
      bottomSheetTheme: _bottomSheetTheme(scheme),
      snackBarTheme: _snackBarTheme(scheme),
      popupMenuTheme: _popupMenuTheme(scheme),
      tooltipTheme: _tooltipTheme(scheme),
      switchTheme: _switchTheme(scheme),
      radioTheme: _radioTheme(scheme),
      progressIndicatorTheme: _progressIndicatorTheme(scheme),
      iconTheme: IconThemeData(color: scheme.onSurface),
      primaryIconTheme: IconThemeData(color: scheme.onPrimary),
    );
  }

  // ── TextTheme ─────────────────────────────────────────────────────────────
  //
  // Maps the "Fluid Architect" typography scale to M3 text roles.
  // Manrope → Display / Headline (editorial)
  // Inter   → Title / Body / Label (functional)

  static TextTheme _textTheme(ColorScheme scheme) {
    final body = scheme.onSurface;
    final muted = scheme.onSurfaceVariant;

    return TextTheme(
      // Display — hero date, large progress %
      displayLarge: GoogleFonts.manrope(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: body,
        height: 1.1,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.manrope(
        fontSize: 44,
        fontWeight: FontWeight.w700,
        color: body,
        height: 1.1,
      ),
      displaySmall: GoogleFonts.manrope(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: body,
        height: 1.15,
      ),

      // Headline — section headers
      headlineLarge: GoogleFonts.manrope(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: body,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: body,
        height: 1.2,
      ),
      headlineSmall: GoogleFonts.manrope(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: body,
        height: 1.2,
      ),

      // Title — memo titles, task descriptions
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: body,
        height: 1.3,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: body,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: body,
        height: 1.4,
      ),

      // Body — notes, secondary metadata
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: body,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: body,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: muted,
        height: 1.5,
      ),

      // Label — tag chips (all-caps intent), small metadata
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: body,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: muted,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: muted,
        letterSpacing: 0.8,
      ),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────

  static AppBarTheme _appBarTheme(ColorScheme scheme) {
    final isDark = scheme.brightness == Brightness.dark;
    return AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: false,
      systemOverlayStyle: isDark
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
            ),
      titleTextStyle: GoogleFonts.manrope(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
      iconTheme: IconThemeData(color: scheme.onSurface, size: 24),
      actionsIconTheme: IconThemeData(color: scheme.onSurface, size: 24),
    );
  }

  // ── Card ──────────────────────────────────────────────────────────────────
  //
  // Tonal layering: elevated card uses surfaceContainerLowest (#ffffff / #0e0f13).
  // No border, no shadow — surface color shift does the work.

  static CardThemeData _cardTheme(ColorScheme scheme) {
    return CardThemeData(
      color: scheme.surfaceContainerLowest,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    );
  }

  // ── Chip ──────────────────────────────────────────────────────────────────
  //
  // Pill shape, soft pastel containers only.
  // tertiary-container (#e4ceff) or secondary-container (#dbe2f9).

  static ChipThemeData _chipTheme(ColorScheme scheme) {
    return ChipThemeData(
      backgroundColor: scheme.secondaryContainer,
      selectedColor: scheme.tertiaryContainer,
      disabledColor: scheme.surfaceContainerLow,
      labelStyle: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
        color: scheme.onSecondaryContainer,
      ),
      secondaryLabelStyle: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
        color: scheme.onTertiaryContainer,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: const StadiumBorder(),
      side: BorderSide.none,
      elevation: 0,
      pressElevation: 0,
      showCheckmark: false,
    );
  }

  // ── Floating Action Button ────────────────────────────────────────────────
  //
  // Large rounded square. Background set to primary; the actual gradient
  // (135° primary → primaryContainer) must be applied at the widget level
  // using a DecoratedBox + InkWell wrapper.
  // Ambient shadow: 0 12px 32px rgba(47,50,58,0.06).

  // static FloatingActionButtonThemeData _fabTheme(ColorScheme scheme) {
  //   return FloatingActionButtonThemeData(
  //     backgroundColor: scheme.primary.withValues(alpha: 0.8),
  //     foregroundColor: scheme.onPrimary,
  //     elevation: 1,
  //     focusElevation: 0,
  //     hoverElevation: 0,
  //     highlightElevation: 0,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     extendedPadding: const EdgeInsets.symmetric(horizontal: 24),
  //     iconSize: 24,
  //   );
  // }

  // ── Navigation Bar ────────────────────────────────────────────────────────
  //
  // Glassmorphism: surface-container-highest @ 70% opacity + blur.
  // The blur must be applied at the widget level (BackdropFilter).
  // Active indicator is replaced by a 4px primary dot below the icon.

  static NavigationBarThemeData _navigationBarTheme(ColorScheme scheme) {
    return NavigationBarThemeData(
      // Widget handles opacity + blur; set base color only.
      backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.70),
      indicatorColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      height: 72,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final active = states.contains(WidgetState.selected);
        return GoogleFonts.inter(
          fontSize: 11,
          fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          color: active ? scheme.primary : scheme.onSurfaceVariant,
          letterSpacing: 0.4,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final active = states.contains(WidgetState.selected);
        return IconThemeData(
          color: active ? scheme.primary : scheme.onSurfaceVariant,
          size: 24,
        );
      }),
    );
  }

  // ── Checkbox ──────────────────────────────────────────────────────────────
  //
  // Checked → primary fill, white icon.
  // Unchecked → transparent fill, 2px Ghost Border of outline.
  // Spring animation (scale 0.9 → 1.1 → 1.0) must be added at widget level.

  static CheckboxThemeData _checkboxTheme(ColorScheme scheme) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return scheme.primary;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(scheme.onPrimary),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return scheme.primary.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return scheme.onSurface.withValues(alpha: 0.08);
        }
        return Colors.transparent;
      }),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return BorderSide(color: scheme.primary, width: 2);
        }
        // Ghost Border: outline at 15% opacity
        return BorderSide(
          color: scheme.outline.withValues(alpha: 0.15),
          width: 2,
        );
      }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      splashRadius: 20,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  // ── Input Decoration ──────────────────────────────────────────────────────

  static InputDecorationTheme _inputDecorationTheme(ColorScheme scheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerLow,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      // No hard borders — rely on fill color for containment
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.error, width: 1.5),
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: scheme.onSurfaceVariant,
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: scheme.onSurfaceVariant,
      ),
      floatingLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: scheme.primary,
      ),
      errorStyle: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: scheme.error,
      ),
    );
  }

  // ── ListTile ──────────────────────────────────────────────────────────────
  //
  // No dividers. Use vertical spacing between groups at the list level.

  static ListTileThemeData _listTileTheme(ColorScheme scheme) {
    return ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      horizontalTitleGap: 12,
      dense: false,
      tileColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: scheme.onSurface,
      ),
      subtitleTextStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: scheme.onSurfaceVariant,
      ),
      leadingAndTrailingTextStyle: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: scheme.onSurfaceVariant,
      ),
      iconColor: scheme.onSurfaceVariant,
      minLeadingWidth: 0,
    );
  }

  // ── Divider ───────────────────────────────────────────────────────────────
  //
  // "No-Line Rule" — dividers must be invisible.
  // Use vertical spacing (SizedBox) between sections instead.

  static DividerThemeData _dividerTheme() {
    return const DividerThemeData(
      color: Colors.transparent,
      space: 0,
      thickness: 0,
      indent: 0,
      endIndent: 0,
    );
  }

  // ── Dialog ────────────────────────────────────────────────────────────────

  static DialogThemeData _dialogTheme(ColorScheme scheme) {
    return DialogThemeData(
      backgroundColor: scheme.surfaceContainerLowest,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: scheme.shadow.withValues(alpha: 0.06),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      titleTextStyle: GoogleFonts.manrope(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: scheme.onSurfaceVariant,
        height: 1.5,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
    );
  }

  // ── Bottom Sheet ──────────────────────────────────────────────────────────

  static BottomSheetThemeData _bottomSheetTheme(ColorScheme scheme) {
    return BottomSheetThemeData(
      backgroundColor: scheme.surfaceContainerLow,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      modalElevation: 0,
      shadowColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      clipBehavior: Clip.antiAlias,
      dragHandleColor: scheme.outlineVariant,
      dragHandleSize: const Size(32, 4),
    );
  }

  // ── SnackBar ──────────────────────────────────────────────────────────────

  static SnackBarThemeData _snackBarTheme(ColorScheme scheme) {
    return SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: scheme.inverseSurface,
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: scheme.onInverseSurface,
      ),
      actionTextColor: scheme.inversePrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
    );
  }

  // ── Popup Menu ────────────────────────────────────────────────────────────

  static PopupMenuThemeData _popupMenuTheme(ColorScheme scheme) {
    return PopupMenuThemeData(
      color: scheme.surfaceContainerLowest,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: scheme.shadow.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: scheme.onSurface,
      ),
      labelTextStyle: WidgetStateProperty.all(
        GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: scheme.onSurface,
        ),
      ),
      menuPadding: const EdgeInsets.symmetric(vertical: 8),
    );
  }

  // ── Tooltip ───────────────────────────────────────────────────────────────

  static TooltipThemeData _tooltipTheme(ColorScheme scheme) {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: scheme.inverseSurface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: scheme.onInverseSurface,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      preferBelow: true,
      waitDuration: const Duration(milliseconds: 600),
    );
  }

  // ── Switch ────────────────────────────────────────────────────────────────

  static SwitchThemeData _switchTheme(ColorScheme scheme) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return scheme.onPrimary;
        return scheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return scheme.primary;
        return scheme.surfaceContainerHighest;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.transparent;
        return scheme.outline.withValues(alpha: 0.15);
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return scheme.primary.withValues(alpha: 0.12);
        }
        return Colors.transparent;
      }),
      splashRadius: 20,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  // ── Radio ─────────────────────────────────────────────────────────────────

  static RadioThemeData _radioTheme(ColorScheme scheme) {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return scheme.primary;
        return scheme.outline.withValues(alpha: 0.40);
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return scheme.primary.withValues(alpha: 0.12);
        }
        return Colors.transparent;
      }),
      splashRadius: 20,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  // ── Progress Indicator ────────────────────────────────────────────────────

  static ProgressIndicatorThemeData _progressIndicatorTheme(
    ColorScheme scheme,
  ) {
    return ProgressIndicatorThemeData(
      color: scheme.primary,
      linearTrackColor: scheme.surfaceContainerHighest,
      linearMinHeight: 4,
      circularTrackColor: scheme.surfaceContainerHighest,
      refreshBackgroundColor: scheme.surfaceContainerLowest,
    );
  }
}

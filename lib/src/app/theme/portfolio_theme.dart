import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF6C5CE7);
  static const secondary = Color(0xFF20BFA9);
  static const ink = Color(0xFF132238);
  static const muted = Color(0xFF62748A);
  static const lightBackground = Color(0xFFFAF9F7);
  static const darkBackground = Color(0xFF0B1020);
  static const darkSurface = Color(0xFF111C2D);
  static const lightSurfaceVariant = Color(0xFFF0F4F8);
  static const darkSurfaceVariant = Color(0xFF0D1727);
  static const lightBorder = Color(0xFFDCE4EE);
  static const darkBorder = Color(0xFF243247);
}

abstract final class AppSpacing {
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 20.0;
  static const lg = 32.0;
  static const xl = 56.0;
  static const sectionDesktop = 88.0;
  static const sectionTablet = 72.0;
  static const sectionMobile = 56.0;
  static const contentMaxWidth = 1240.0;
  static const navigationHeight = 72.0;

  static double sectionFor(double width) => width < AppBreakpoints.mobile
      ? sectionMobile
      : width < AppBreakpoints.desktop
      ? sectionTablet
      : sectionDesktop;
}

abstract final class AppBreakpoints {
  static const mobile = 600.0;
  static const tablet = 900.0;
  static const desktop = 1200.0;
  static const desktopNavigation = 1040.0;
}

abstract final class PortfolioTheme {
  static ThemeData get light => _theme(Brightness.light);
  static ThemeData get dark => _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final accent = isDark ? const Color(0xFFA99CFF) : AppColors.primary;
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
      primary: accent,
      secondary: isDark ? const Color(0xFF5EE0CA) : AppColors.secondary,
      surface: isDark ? AppColors.darkSurface : Colors.white,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.w800,
          height: 1.08,
        ),
        displaySmall: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w800,
          height: 1.15,
        ),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(fontSize: 17, height: 1.65),
        bodyMedium: TextStyle(fontSize: 15, height: 1.55),
      ),
      dividerColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? AppColors.darkSurface : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: .55)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF0D1727) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        contentPadding: const EdgeInsets.all(18),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? Colors.white : accent,
          side: BorderSide(
            color: isDark ? Colors.white70 : accent.withValues(alpha: .7),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark ? Colors.white : accent,
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

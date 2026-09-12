import 'package:flutter/material.dart';

/// Dispute Paisa — Color Design System v3
///
/// Organised into five groups:
///   1. Brand Palette      — primary, secondary, accent, gradient stops
///   2. Functional Colors  — success, info, warning, danger, neutral
///   3. Text Colors        — primary text through disabled
///   4. Surface & Border   — backgrounds, cards, dividers, chips
///   5. Tints & Shades     — 5-step ramp per brand/functional color
///
/// Usage:
///   color: AppColors.primary
///   color: AppColors.warning500          // explicit step
///   gradient: AppColors.brandGradient    // LinearGradient
abstract final class AppColors {
  AppColors._();

  // ─────────────────────────────────────────────────────────────
  // 1. BRAND PALETTE
  // ─────────────────────────────────────────────────────────────

  /// Trust, banking, security — headers, navigation, main CTAs.
  static const Color primary = Color(0xFF123B82);

  /// Money recovery, positive outcome — also doubles as Success.
  static const Color secondary = Color(0xFF08B875);

  /// Digital / mobile technology — also doubles as Info.
  static const Color accent = Color(0xFF00A9E8);

  /// Gradient start (= secondary). Use with [brandGradient].
  static const Color gradientStart = Color(0xFF08B875);

  /// Gradient end. Use with [brandGradient].
  static const Color gradientEnd = Color(0xFF087FEA);

  /// 135° brand gradient — splash, onboarding hero, app icon.
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    // 135° diagonal in Flutter: topLeft → bottomRight
    transform: GradientRotation(135 * 3.141592653589793 / 180),
    colors: [gradientStart, gradientEnd],
  );

  // ─────────────────────────────────────────────────────────────
  // 2. FUNCTIONAL COLORS  (base / 500 step)
  // ─────────────────────────────────────────────────────────────

  /// Case closed, payment confirmed, funds recovered. (= secondary)
  static const Color success = Color(0xFF08B875);

  /// Notifications, status updates, neutral information. (= accent)
  static const Color info = Color(0xFF00A9E8);

  /// Documents pending, action required, additional docs needed.
  static const Color warning = Color(0xFFF5A623);

  /// Document rejected, case flagged, form validation errors.
  static const Color danger = Color(0xFFD64545);

  /// Optional fields, disabled states, dividers, inactive elements.
  static const Color neutral = Color(0xFF8A909C);

  // ─────────────────────────────────────────────────────────────
  // 3. TEXT COLORS
  // ─────────────────────────────────────────────────────────────

  /// High-emphasis body text, headings, labels.
  static const Color textPrimary = Color(0xFF1B1E22);

  /// Medium-emphasis body text, descriptions, captions.
  static const Color textSecondary = Color(0xFF5B5E62);

  /// Low-emphasis helper text, placeholders, meta info.
  static const Color textMuted = Color(0xFF8A8D90);

  /// Footer / watermark level text.
  static const Color textFooter = Color(0xFF9A9C9E);

  /// Disabled labels, future tracker steps.
  static const Color textDisabled = Color(0xFFB3B5B7);

  /// Text on dark / coloured backgrounds (e.g. gradient hero).
  static const Color textOnDark = Color(0xFFFFFFFF);

  // ─────────────────────────────────────────────────────────────
  // 4. SURFACE & BORDER
  // ─────────────────────────────────────────────────────────────

  /// App scaffold / page background.
  static const Color background = Color(0xFFFAFAF9);

  /// Card / sheet surface.
  static const Color surface = Color(0xFFFFFFFF);

  /// Dividers, card outlines, input borders.
  static const Color border = Color(0xFFE4E3E0);

  /// Chip / tag / copy-button background.
  static const Color chipBackground = Color(0xFFE7E9EC);

  /// Onboarding screen background — soft lavender-blue.
  static const Color onboardingBackground = Color(0xFFEEF0F8);

  // ─────────────────────────────────────────────────────────────
  // 5. TINTS & SHADES  (lightest → darkest, 5-step ramp)
  // ─────────────────────────────────────────────────────────────

  // — Primary (navy blue) —
  static const Color primary100 = Color(0xFFDBE2EC); // lightest tint
  static const Color primary200 = Color(0xFF94A7C7);
  static const Color primary500 = Color(0xFF123B82); // base
  static const Color primary700 = Color(0xFF0E2C62);
  static const Color primary900 = Color(0xFF091E41); // darkest shade

  // — Secondary (green) —
  static const Color secondary100 = Color(0xFFDAF4EA); // lightest tint
  static const Color secondary200 = Color(0xFF90DFC1);
  static const Color secondary500 = Color(0xFF08B875); // base
  static const Color secondary700 = Color(0xFF068A58);
  static const Color secondary900 = Color(0xFF045C3B); // darkest shade

  // — Accent (sky blue) —
  static const Color accent100 = Color(0xFFD9F2FC); // lightest tint
  static const Color accent200 = Color(0xFF8CD8F5);
  static const Color accent500 = Color(0xFF00A9E8); // base
  static const Color accent700 = Color(0xFF007FAE);
  static const Color accent900 = Color(0xFF005574); // darkest shade

  // — Warning (amber) —
  static const Color warning100 = Color(0xFFFEF2DE); // lightest tint
  static const Color warning200 = Color(0xFFFBD79C);
  static const Color warning500 = Color(0xFFF5A623); // base
  static const Color warning700 = Color(0xFFAC7419);
  static const Color warning900 = Color(0xFF875B13); // darkest shade

  // — Danger (red) —
  static const Color danger100 = Color(0xFFFBE3E3); // lightest tint
  static const Color danger200 = Color(0xFFEDABAB);
  static const Color danger500 = Color(0xFFD64545); // base
  static const Color danger700 = Color(0xFFA93333);
  static const Color danger900 = Color(0xFF6B2323); // darkest shade

  // — Neutral (grey) —
  static const Color neutral50  = Color(0xFFF7F8FA); // near-white
  static const Color neutral100 = Color(0xFFE7E9EC);
  static const Color neutral300 = Color(0xFFC6CAD1);
  static const Color neutral500 = Color(0xFF8A909C); // base
  static const Color neutral700 = Color(0xFF5B616C); // darkest shade

  // ─────────────────────────────────────────────────────────────
  // SEMANTIC BADGE / ALERT TEXT COLORS
  // Contrast-safe foreground colours for coloured badge backgrounds.
  // ─────────────────────────────────────────────────────────────

  /// Text on success badge (bg: secondary100 #DAF4EA).
  static const Color successText = Color(0xFF068A58); // = secondary700

  /// Text on info badge (bg: accent100 #D9F2FC).
  static const Color infoText = Color(0xFF005574);    // = accent900

  /// Text on warning badge (bg: warning100 #FEF2DE).
  static const Color warningText = Color(0xFFAC7419); // = warning700

  /// Text on warning alert panel (bg: warning100 #FEF2DE).
  static const Color warningAlertText = Color(0xFF875B13); // = warning900

  /// Text on danger badge (bg: danger100 #FBE3E3).
  static const Color dangerText = Color(0xFFA93333);  // = danger700

  /// Text on danger alert panel (bg: danger100 #FBE3E3).
  static const Color dangerAlertText = Color(0xFFA93333); // = danger700

  /// Text on neutral badge (bg: neutral100 #E7E9EC).
  static const Color neutralText = Color(0xFF5B616C); // = neutral700
}

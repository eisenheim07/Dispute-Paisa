import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_responsive.dart';

/// Dispute Paisa — Typography System
///
/// Font family : Noto Sans (via Google Fonts)
/// All sizes   : design-px values, scaled via [AppResponsive.sp]
///
/// Three categories:
///   • Heading  — screen titles, section headers
///   • Body     — paragraphs, descriptions, form values
///   • Label    — buttons, chips, captions, badges
abstract final class AppTextStyles {
  AppTextStyles._();

  static const String _family = 'Noto Sans';

  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    Color? color,
    double letterSpacing = 0,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
    TextBaseline? textBaseline,
  }) => GoogleFonts.inter(
    fontSize: AppResponsive.sp(fontSize),
    fontWeight: fontWeight,
    height: height / fontSize,
    letterSpacing: letterSpacing,
    color: color,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    fontStyle: fontStyle,
    shadows: shadows,
    textBaseline: textBaseline,
  );

  // ─────────────────────────────────────────────────────────────
  // HEADING
  // ─────────────────────────────────────────────────────────────

  /// 28 sp · Bold — hero titles, onboarding headlines
  static TextStyle headingXL({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
  }) => _base(
    fontSize: fontSize ?? 28,
    fontWeight: fontWeight ?? FontWeight.w700,
    height: height ?? 36,
    color: color,
    letterSpacing: letterSpacing ?? 0,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    fontStyle: fontStyle,
    shadows: shadows,
  );

  /// 24 sp · Bold — screen titles
  static TextStyle headingL({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
  }) => _base(
    fontSize: fontSize ?? 24,
    fontWeight: fontWeight ?? FontWeight.w700,
    height: height ?? 32,
    color: color,
    letterSpacing: letterSpacing ?? 0,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    fontStyle: fontStyle,
    shadows: shadows,
  );

  /// 20 sp · SemiBold — section headers, card titles
  static TextStyle headingM({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
  }) => _base(
    fontSize: fontSize ?? 20,
    fontWeight: fontWeight ?? FontWeight.w600,
    height: height ?? 28,
    color: color,
    letterSpacing: letterSpacing ?? 0,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    fontStyle: fontStyle,
    shadows: shadows,
  );

  /// 18 sp · SemiBold — sub-section headers
  static TextStyle headingS({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
  }) => _base(
    fontSize: fontSize ?? 18,
    fontWeight: fontWeight ?? FontWeight.w600,
    height: height ?? 26,
    color: color,
    letterSpacing: letterSpacing ?? 0,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    fontStyle: fontStyle,
    shadows: shadows,
  );

  // ─────────────────────────────────────────────────────────────
  // BODY
  // ─────────────────────────────────────────────────────────────

  /// 16 sp · Regular — primary readable content
  static TextStyle bodyL({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
  }) => _base(
    fontSize: fontSize ?? 16,
    fontWeight: fontWeight ?? FontWeight.w400,
    height: height ?? 24,
    color: color,
    letterSpacing: letterSpacing ?? 0,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    fontStyle: fontStyle,
    shadows: shadows,
  );

  /// 14 sp · Regular — secondary content, descriptions
  static TextStyle bodyM({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
  }) => _base(
    fontSize: fontSize ?? 14,
    fontWeight: fontWeight ?? FontWeight.w400,
    height: height ?? 22,
    color: color,
    letterSpacing: letterSpacing ?? 0,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    fontStyle: fontStyle,
    shadows: shadows,
  );

  /// 12 sp · Regular — helper text, hints, meta info
  static TextStyle bodyS({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
  }) => _base(
    fontSize: fontSize ?? 12,
    fontWeight: fontWeight ?? FontWeight.w400,
    height: height ?? 18,
    color: color,
    letterSpacing: letterSpacing ?? 0,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    fontStyle: fontStyle,
    shadows: shadows,
  );

  // ─────────────────────────────────────────────────────────────
  // LABEL
  // ─────────────────────────────────────────────────────────────

  /// 14 sp · SemiBold — buttons, active tabs
  static TextStyle labelL({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
  }) => _base(
    fontSize: fontSize ?? 14,
    fontWeight: fontWeight ?? FontWeight.w600,
    height: height ?? 20,
    color: color,
    letterSpacing: letterSpacing ?? 0,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    fontStyle: fontStyle,
    shadows: shadows,
  );

  /// 12 sp · Medium — chips, badges, form labels
  static TextStyle labelM({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
  }) => _base(
    fontSize: fontSize ?? 12,
    fontWeight: fontWeight ?? FontWeight.w500,
    height: height ?? 18,
    color: color,
    letterSpacing: letterSpacing ?? 0,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    fontStyle: fontStyle,
    shadows: shadows,
  );

  /// 11 sp · Medium — captions, timestamps, footnotes
  static TextStyle labelS({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
  }) => _base(
    fontSize: fontSize ?? 11,
    fontWeight: fontWeight ?? FontWeight.w500,
    height: height ?? 16,
    color: color,
    letterSpacing: letterSpacing ?? 0,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    fontStyle: fontStyle,
    shadows: shadows,
  );
}

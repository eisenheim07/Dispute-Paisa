import 'package:flutter/material.dart';

import '../app_color.dart';
import '../app_constants.dart';
import '../app_responsive.dart';
import '../app_text_styles.dart';

/// Icon position for [AppButtons.primaryButton].
enum IconPosition { left, right }

/// All app buttons live here as static methods:
///
/// ```dart
/// AppButtons.primaryButton(label: 'Continue', onTap: () {})
/// AppButtons.outlinedButton(label: 'Skip', onTap: () {})
/// AppButtons.textButton(label: 'Forgot Password?', onTap: () {})
/// AppButtons.circularButton(icon: Icons.arrow_forward_rounded, onTap: () {})
/// ```
abstract final class AppButtons {
  AppButtons._();

  // ─────────────────────────────────────────────────────────────
  // PRIMARY — filled, full-width by default
  // ─────────────────────────────────────────────────────────────

  /// Solid filled button. Full-width by default unless [width] is passed.
  /// Optional [icon] can be placed on [IconPosition.left] or [IconPosition.right] (default).
  ///
  /// ```dart
  /// AppButtons.primaryButton(label: 'Continue', onTap: () {})
  /// AppButtons.primaryButton(label: 'Get OTP', icon: Icons.arrow_forward_rounded, onTap: () {})
  /// AppButtons.primaryButton(label: 'Back', icon: Icons.arrow_back, iconPosition: IconPosition.left, onTap: () {})
  /// ```
  static Widget primaryButton({
    required VoidCallback? onTap,
    required String label,
    IconData? icon,
    IconPosition iconPosition = IconPosition.right,
    Color backgroundColor = AppColors.primary,
    Color foregroundColor = AppColors.textOnDark,
    double? width = double.infinity,
    double height = 52,
    double iconSize = 20,
    double borderRadius = 12,
    bool isLoading = false,
    bool enabled = true,
  }) => _AppBaseButton(
    label: label,
    icon: icon,
    iconPosition: iconPosition,
    onTap: onTap,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    width: width,
    height: height,
    iconSize: iconSize,
    borderRadius: borderRadius,
    isLoading: isLoading,
    enabled: enabled,
  );

  // ─────────────────────────────────────────────────────────────
  // OUTLINED — transparent with border
  // ─────────────────────────────────────────────────────────────

  /// Outlined button with transparent background.
  ///
  /// ```dart
  /// AppButtons.outlinedButton(label: 'Cancel', onTap: () {})
  /// ```
  static Widget outlinedButton({
    required VoidCallback? onTap,
    String? label,
    IconData? icon,
    Color borderColor = AppColors.primary,
    Color foregroundColor = AppColors.primary,
    double? width,
    double height = 52,
    double iconSize = 20,
    double borderRadius = 12,
    bool isLoading = false,
    bool enabled = true,
  }) => _AppBaseButton(
    label: label,
    icon: icon,
    onTap: onTap,
    backgroundColor: Colors.transparent,
    foregroundColor: foregroundColor,
    borderColor: borderColor,
    width: width,
    height: height,
    iconSize: iconSize,
    borderRadius: borderRadius,
    isLoading: isLoading,
    enabled: enabled,
  );

  // ─────────────────────────────────────────────────────────────
  // TEXT — no background, no border
  // ─────────────────────────────────────────────────────────────

  /// Flat text-only button. No background or border.
  ///
  /// [underline] defaults to `false`. When `true`, the text is underlined
  /// with a colour slightly darker than [foregroundColor].
  ///
  /// ```dart
  /// AppButtons.textButton(label: 'Skip', onTap: () {})
  /// AppButtons.textButton(label: 'Sign In', underline: true, onTap: () {})
  /// ```
  static Widget textButton({
    required String label,
    required VoidCallback? onTap,
    Color foregroundColor = AppColors.primary,
    double height = 40,
    bool underline = false,
    bool enabled = true,
  }) =>
      _AppTextButton(label: label, onTap: onTap, foregroundColor: foregroundColor, height: height, underline: underline, enabled: enabled);

  // ─────────────────────────────────────────────────────────────
  // CIRCULAR — icon-only circle button
  // ─────────────────────────────────────────────────────────────

  /// Always-circular icon button. Diameter controlled by [size].
  ///
  /// ```dart
  /// AppButtons.circularButton(icon: Icons.arrow_forward_rounded, onTap: () {})
  /// ```
  static Widget circularButton({
    required IconData icon,
    required VoidCallback? onTap,
    Color backgroundColor = AppColors.primary,
    Color foregroundColor = AppColors.textOnDark,
    double size = 52,
    double iconSize = 22,
    bool isLoading = false,
    bool enabled = true,
  }) => _AppCircularButton(
    icon: icon,
    onTap: onTap,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    size: size,
    iconSize: iconSize,
    isLoading: isLoading,
    enabled: enabled,
  );
}

// ─────────────────────────────────────────────────────────────
// BASE BUTTON — shared implementation for primary/outlined/text
// ─────────────────────────────────────────────────────────────
class _AppBaseButton extends StatelessWidget {
  const _AppBaseButton({
    this.label,
    this.icon,
    this.iconPosition = IconPosition.right,
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.width,
    required this.height,
    this.iconSize = 20,
    this.borderRadius = 12,
    this.isLoading = false,
    this.enabled = true,
    this.hasShadow = true,
  }) : assert(label != null || icon != null, '_AppBaseButton needs a label or icon.');

  final String? label;
  final IconData? icon;
  final IconPosition iconPosition;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final double? width;
  final double height;
  final double iconSize;
  final double borderRadius;
  final bool isLoading;
  final bool enabled;
  final bool hasShadow;

  bool get _isDisabled => !enabled || onTap == null;

  @override
  Widget build(BuildContext context) {
    final effectiveBg = _isDisabled ? AppColors.neutral300 : backgroundColor;
    final effectiveFg = _isDisabled ? AppColors.textDisabled : foregroundColor;
    final radius = BorderRadius.circular(AppResponsive.r(borderRadius));

    // Handle width: double.infinity means match parent, null means wrap content
    final Widget button = Container(
      width: width == double.infinity ? double.infinity : (width != null ? AppResponsive.w(width!) : null),
      height: AppResponsive.h(height),
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: radius,
        border: borderColor != null ? Border.all(color: borderColor!, width: 1) : null,
        boxShadow: (hasShadow && !_isDisabled && effectiveBg != Colors.transparent)
            ? [BoxShadow(color: effectiveBg.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 4))]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: _isDisabled ? null : onTap,
          borderRadius: radius,
          splashColor: effectiveFg.withOpacity(0.15),
          highlightColor: effectiveFg.withOpacity(0.08),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.w(16)),
            child: Center(child: _content(effectiveFg)),
          ),
        ),
      ),
    );

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: _isDisabled ? 0.6 : 1.0,
      // When width is null wrap with IntrinsicWidth so the button wraps content
      child: width == null ? IntrinsicWidth(child: button) : button,
    );
  }

  Widget _content(Color fg) {
    if (isLoading) {
      return SizedBox(
        width: AppResponsive.r(20),
        height: AppResponsive.r(20),
        child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(fg)),
      );
    }

    if (label == null) {
      return Icon(icon, size: AppResponsive.r(iconSize), color: fg);
    }

    if (icon == null) {
      return Text(label!, style: AppTextStyles.labelL(color: fg));
    }

    final iconWidget = Icon(icon, size: AppResponsive.r(iconSize), color: fg);
    final labelWidget = Text(label!, style: AppTextStyles.labelL(color: fg));
    final gap = AppConstants.hMD;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: iconPosition == IconPosition.left ? [iconWidget, gap, labelWidget] : [labelWidget, gap, iconWidget],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// TEXT BUTTON — dedicated implementation with underline support
// ─────────────────────────────────────────────────────────────
class _AppTextButton extends StatelessWidget {
  const _AppTextButton({
    required this.label,
    required this.onTap,
    required this.foregroundColor,
    required this.height,
    required this.underline,
    required this.enabled,
  });

  final String label;
  final VoidCallback? onTap;
  final Color foregroundColor;
  final double height;
  final bool underline;
  final bool enabled;

  bool get _isDisabled => !enabled || onTap == null;

  /// Darkens [color] by [amount] (0.0 – 1.0).
  Color _darken(Color color, [double amount = 0.20]) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveFg = _isDisabled ? AppColors.textDisabled : foregroundColor;
    final underlineColor = _darken(effectiveFg);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: _isDisabled ? 0.6 : 1.0,
      child: IntrinsicWidth(
        child: SizedBox(
          height: AppResponsive.h(height),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _isDisabled ? null : onTap,
              splashColor: effectiveFg.withOpacity(0.15),
              highlightColor: effectiveFg.withOpacity(0.08),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppResponsive.w(12), vertical: AppResponsive.h(8)),
                child: Center(
                  child: Text(
                    label,
                    style: AppTextStyles.labelL(color: effectiveFg).copyWith(
                      decoration: underline ? TextDecoration.underline : TextDecoration.none,
                      decorationColor: underline ? underlineColor : null,
                      decorationThickness: underline ? 1.5 : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CIRCULAR BUTTON — dedicated circle implementation
// ─────────────────────────────────────────────────────────────
class _AppCircularButton extends StatelessWidget {
  const _AppCircularButton({
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.size,
    required this.iconSize,
    required this.isLoading,
    required this.enabled,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final double size;
  final double iconSize;
  final bool isLoading;
  final bool enabled;

  bool get _isDisabled => !enabled || onTap == null;

  @override
  Widget build(BuildContext context) {
    final effectiveBg = _isDisabled ? AppColors.neutral300 : backgroundColor;
    final effectiveFg = _isDisabled ? AppColors.textDisabled : foregroundColor;
    final diameter = AppResponsive.r(size);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: _isDisabled ? 0.6 : 1.0,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: effectiveBg,
          shape: BoxShape.circle,
          boxShadow: _isDisabled ? null : [BoxShadow(color: effectiveBg.withOpacity(0.30), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: _isDisabled ? null : onTap,
            customBorder: const CircleBorder(),
            splashColor: effectiveFg.withOpacity(0.20),
            highlightColor: effectiveFg.withOpacity(0.10),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: AppResponsive.r(20),
                      height: AppResponsive.r(20),
                      child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(effectiveFg)),
                    )
                  : Icon(icon, size: AppResponsive.r(iconSize), color: effectiveFg),
            ),
          ),
        ),
      ),
    );
  }
}

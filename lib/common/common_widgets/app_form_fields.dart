import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_color.dart';
import '../app_constants.dart';
import '../app_responsive.dart';
import '../app_text_styles.dart';

/// All reusable form field widgets for the entire application.
///
/// Every field supports:
/// - [readOnly] — toggles between editable and non-editable mode
/// - [enabled] — visually disables the field
/// - [validator] — plug in any validator from [AppValidators]
abstract final class AppFormFields {
  AppFormFields._();

  // ─────────────────────────────────────────────────────────────
  // LABEL
  // ─────────────────────────────────────────────────────────────

  /// Form field label with optional required asterisk (*).
  ///
  /// ```dart
  /// AppFormFields.label(
  ///   text: 'Mobile Number',
  ///   isRequired: true,
  ///   style: AppTextStyles.labelM(color: AppColors.textPrimary),
  /// )
  /// ```
  static Widget label({required String text, bool isRequired = false, TextStyle? style}) =>
      _AppFormLabel(text: text, isRequired: isRequired, style: style);

  // ─────────────────────────────────────────────────────────────
  // HINT
  // ─────────────────────────────────────────────────────────────

  /// Form field helper/hint text below input fields.
  ///
  /// ```dart
  /// AppFormFields.hint(
  ///   text: 'Standard SMS rates or WhatsApp verification apply',
  ///   style: AppTextStyles.bodyS(color: AppColors.textMuted),
  /// )
  /// ```
  static Widget hint({required String text, TextStyle? style}) => _AppFormHint(text: text, style: style);

  // ─────────────────────────────────────────────────────────────
  // CHIP
  // ─────────────────────────────────────────────────────────────

  /// Form field chip with optional leading dot indicator.
  ///
  /// ```dart
  /// AppFormFields.chip(
  ///   text: 'Auto-validates',
  ///   showDot: true,
  ///   dotColor: AppColors.success,
  ///   textColor: AppColors.success,
  /// )
  /// ```
  static Widget chip({
    required String text,
    bool showDot = false,
    Color? dotColor,
    Color? textColor,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    double? dotSize,
    double? spacing,
  }) => _AppFormChip(
    text: text,
    showDot: showDot,
    dotColor: dotColor,
    textColor: textColor,
    textStyle: textStyle,
    backgroundColor: backgroundColor,
    borderColor: borderColor,
    borderWidth: borderWidth,
    borderRadius: borderRadius,
    padding: padding,
    dotSize: dotSize,
    spacing: spacing,
  );

  // ─────────────────────────────────────────────────────────────
  // PHONE FIELD
  // ─────────────────────────────────────────────────────────────

  /// Indian phone number field with hardcoded +91 prefix and flag.
  /// Shows a green checkmark when the number is valid (10 digits, 6-9 start).
  ///
  /// ```dart
  /// AppFormFields.phoneField(
  ///   controller: _controller,
  ///   isValid: state.isPhoneValid,
  ///   hintText: 'Enter your mobile number',
  ///   onChanged: (v) => cubit.onPhoneChanged(v),
  ///   validator: AppValidators.phone,
  /// )
  /// ```
  static Widget phoneField({
    required TextEditingController controller,
    required bool isValid,
    String? hintText,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    bool readOnly = false,
    bool enabled = true,
  }) => _AppPhoneField(
    controller: controller,
    isValid: isValid,
    hintText: hintText,
    onChanged: onChanged,
    validator: validator,
    readOnly: readOnly,
    enabled: enabled,
  );
}

// ─────────────────────────────────────────────────────────────
// PHONE FIELD IMPLEMENTATION
// ─────────────────────────────────────────────────────────────
class _AppPhoneField extends StatelessWidget {
  const _AppPhoneField({
    required this.controller,
    required this.isValid,
    this.hintText,
    required this.onChanged,
    required this.validator,
    required this.readOnly,
    required this.enabled,
  });

  final TextEditingController controller;
  final bool isValid;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      enabled: enabled,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      validator: validator,
      style: AppTextStyles.bodyL(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.bodyL(color: AppColors.textMuted.withAlpha(70)),
        counterText: '',
        contentPadding: EdgeInsets.symmetric(horizontal: AppResponsive.w(14), vertical: AppResponsive.h(14)),
        // ── +91 prefix ────────────────────────────────────────
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.w(12)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // India flag emoji
              Text('🇮🇳', style: TextStyle(fontSize: AppResponsive.sp(18))),
              AppConstants.hSM,
              Text('+91', style: AppTextStyles.bodyL(color: AppColors.textPrimary)),
              AppConstants.hMD,
              // Vertical divider
              Container(width: 1, height: AppResponsive.h(20), color: AppColors.border),
            ],
          ),
        ),
        // ── Valid checkmark ───────────────────────────────────
        suffixIcon: isValid
            ? Padding(
                padding: EdgeInsets.all(AppResponsive.r(12)),
                child: Container(
                  width: AppResponsive.r(24),
                  height: AppResponsive.r(24),
                  decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                  child: Icon(Icons.check_rounded, color: AppColors.textOnDark, size: AppResponsive.r(14)),
                ),
              )
            : null,
        // ── Border styling ────────────────────────────────────
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.r(10)),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.r(10)),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.r(10)),
          borderSide: const BorderSide(color: AppColors.danger, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.r(10)),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.r(10)),
          borderSide: const BorderSide(color: AppColors.neutral100, width: 1),
        ),
        filled: true,
        fillColor: enabled ? AppColors.surface : AppColors.neutral50,
        errorStyle: AppTextStyles.labelS(color: AppColors.danger),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// LABEL — form field label with optional required asterisk
// ─────────────────────────────────────────────────────────────
class _AppFormLabel extends StatelessWidget {
  const _AppFormLabel({required this.text, required this.isRequired, this.style});

  final String text;
  final bool isRequired;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = AppTextStyles.labelM(color: AppColors.textPrimary);
    final effectiveStyle = style ?? defaultStyle;

    return RichText(
      text: TextSpan(
        text: text,
        style: effectiveStyle,
        children: isRequired
            ? [
                TextSpan(
                  text: ' *',
                  style: effectiveStyle.copyWith(color: AppColors.danger),
                ),
              ]
            : null,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// HINT — helper text below form fields
// ─────────────────────────────────────────────────────────────
class _AppFormHint extends StatelessWidget {
  const _AppFormHint({required this.text, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = AppTextStyles.bodyS(color: AppColors.textMuted);
    final effectiveStyle = style ?? defaultStyle;

    return Text(text, style: effectiveStyle);
  }
}

// ─────────────────────────────────────────────────────────────
// CHIP — form field chip/badge with optional dot indicator
// ─────────────────────────────────────────────────────────────
class _AppFormChip extends StatelessWidget {
  const _AppFormChip({
    required this.text,
    required this.showDot,
    this.dotColor,
    this.textColor,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.dotSize,
    this.spacing,
  });

  final String text;
  final bool showDot;
  final Color? dotColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? dotSize;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    // Default values
    final effectiveDotColor = dotColor ?? AppColors.primary;
    final effectiveTextColor = textColor ?? AppColors.textPrimary;
    // Background color is text color with 10% opacity (90% transparency)
    final effectiveBackgroundColor = backgroundColor ?? effectiveTextColor.withOpacity(0.1);
    // Border color defaults to text color
    final effectiveBorderColor = borderColor ?? effectiveTextColor.withOpacity(0.1);
    final effectiveBorderWidth = borderWidth ?? 1.0;
    final effectiveBorderRadius = borderRadius ?? 16.0;
    final effectivePadding = padding ?? EdgeInsets.symmetric(horizontal: AppResponsive.w(8));
    final effectiveDotSize = dotSize ?? 7.0;
    final effectiveSpacing = spacing ?? 4.0;

    // Text style with default
    final defaultTextStyle = AppTextStyles.labelS(color: effectiveTextColor);
    final effectiveTextStyle = textStyle ?? defaultTextStyle;

    return Container(
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(AppResponsive.r(effectiveBorderRadius)),
        border: Border.all(color: effectiveBorderColor, width: effectiveBorderWidth),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: AppResponsive.r(effectiveDotSize),
              height: AppResponsive.r(effectiveDotSize),
              decoration: BoxDecoration(color: effectiveDotColor, shape: BoxShape.circle),
            ),
            SizedBox(width: AppResponsive.w(effectiveSpacing)),
          ],
          Text(text, style: effectiveTextStyle),
        ],
      ),
    );
  }
}

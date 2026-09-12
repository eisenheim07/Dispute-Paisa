import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_color.dart';
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
  // PHONE FIELD
  // ─────────────────────────────────────────────────────────────

  /// Indian phone number field with hardcoded +91 prefix and flag.
  /// Shows a green checkmark when the number is valid (10 digits, 6-9 start).
  ///
  /// ```dart
  /// AppFormFields.phoneField(
  ///   controller: _controller,
  ///   isValid: state.isPhoneValid,
  ///   onChanged: (v) => cubit.onPhoneChanged(v),
  ///   validator: AppValidators.phone,
  /// )
  /// ```
  static Widget phoneField({
    required TextEditingController controller,
    required bool isValid,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    bool readOnly = false,
    bool enabled = true,
  }) =>
      _AppPhoneField(
        controller: controller,
        isValid: isValid,
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
    required this.onChanged,
    required this.validator,
    required this.readOnly,
    required this.enabled,
  });

  final TextEditingController controller;
  final bool isValid;
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
        counterText: '',
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppResponsive.w(14),
          vertical: AppResponsive.h(14),
        ),
        // ── +91 prefix ────────────────────────────────────────
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.w(12)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // India flag emoji
              Text('🇮🇳', style: TextStyle(fontSize: AppResponsive.sp(18))),
              SizedBox(width: AppResponsive.w(6)),
              Text(
                '+91',
                style: AppTextStyles.bodyL(color: AppColors.textPrimary),
              ),
              SizedBox(width: AppResponsive.w(10)),
              // Vertical divider
              Container(
                width: 1,
                height: AppResponsive.h(20),
                color: AppColors.border,
              ),
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
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: AppColors.textOnDark,
                    size: AppResponsive.r(14),
                  ),
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

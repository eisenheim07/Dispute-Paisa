import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_color.dart';
import '../../../common/app_constants.dart';
import '../../../common/app_responsive.dart';
import '../../../common/app_text_styles.dart';
import '../../../common/app_validators.dart';
import '../../../common/common_widgets/app_form_fields.dart';
import '../../../common/common_widgets/custom_buttons.dart';
import '../cubit/signin_cubit.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    backgroundColor: AppColors.surface,
    body: SafeArea(child: _SignInView()),
  );
}

// ─────────────────────────────────────────────────────────────
// View
// ─────────────────────────────────────────────────────────────
class _SignInView extends StatelessWidget {
  const _SignInView();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.w(24), vertical: AppResponsive.h(32)),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title ─────────────────────────────────────────
            Text('Welcome to ResolveX', style: AppTextStyles.headingXL(color: AppColors.textPrimary)),
            AppConstants.vSM,
            Text(
              'Instant bank lien de-freeze, cyber dispute escalation, and legal grievance resolution.',
              style: AppTextStyles.bodyM(color: AppColors.textSecondary),
            ),

            AppConstants.vXL,

            // ── Mobile Number label row ───────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mobile Number', style: AppTextStyles.labelM(color: AppColors.textPrimary)),
                Row(
                  children: [
                    Container(
                      width: AppResponsive.r(7),
                      height: AppResponsive.r(7),
                      decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                    ),
                    AppConstants.hSM,
                    Text('Auto-validates', style: AppTextStyles.labelS(color: AppColors.success)),
                  ],
                ),
              ],
            ),

            AppConstants.vMD,

            // ── Phone field ───────────────────────────────────
            BlocBuilder<SignInCubit, SignInState>(
              buildWhen: (prev, curr) => prev.isPhoneValid != curr.isPhoneValid,
              builder: (context, state) => AppFormFields.phoneField(
                controller: controller,
                isValid: state.isPhoneValid,
                onChanged: (v) => context.read<SignInCubit>().onPhoneChanged(v),
                validator: AppValidators.phone,
              ),
            ),

            AppConstants.vSM,

            // ── Helper text ───────────────────────────────────
            Text('Standard SMS rates or WhatsApp verification apply', style: AppTextStyles.bodyS(color: AppColors.textMuted)),

            AppConstants.vXL,

            // ── Get Verification OTP button ───────────────────
            AppButtons.primaryButton(
              label: 'Get Verification OTP',
              icon: Icons.arrow_forward_rounded,
              iconPosition: IconPosition.right,
              height: 54,
              onTap: () {
                if (formKey.currentState?.validate() ?? false) {
                  // TODO: trigger OTP send
                }
              },
            ),

            AppConstants.vXL,

            // ── Bottom row — Biometric + Forgot Password ──────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Biometric Login
                GestureDetector(
                  onTap: () {
                    // TODO: biometric auth
                  },
                  child: Row(
                    children: [
                      Icon(Icons.fingerprint_rounded, size: AppResponsive.r(26), color: AppColors.textSecondary),
                      AppConstants.hMD,
                      Text('Biometric Login', style: AppTextStyles.bodyM(color: AppColors.textSecondary)),
                    ],
                  ),
                ),

                // Forgot Password
                AppButtons.textButton(
                  label: 'Forgot Password?',
                  onTap: () {
                    // TODO: forgot password flow
                  },
                  foregroundColor: AppColors.primary,
                  underline: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

class _SignInView extends StatefulWidget {
  const _SignInView();

  @override
  State<_SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<_SignInView> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.w(16), vertical: AppResponsive.h(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to ResolveX', style: AppTextStyles.headingXL(color: AppColors.textPrimary)),
              AppConstants.vSM,
              Text(
                'Instant bank lien de-freeze, cyber dispute escalation, and legal grievance resolution.',
                style: AppTextStyles.bodyM(color: AppColors.textSecondary),
              ),
              AppConstants.vXL,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppFormFields.label(text: 'Mobile Number', isRequired: true),
                  AppFormFields.chip(
                    text: 'Auto-validates',
                    showDot: true,
                    dotColor: AppColors.success,
                    textColor: AppColors.success,
                    borderColor: AppColors.transparent,
                  ),
                ],
              ),
              AppConstants.vMD,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppFormFields.phoneField(
                    controller: _controller,
                    isValid: state.isPhoneValid,
                    hintText: '98765 43210',
                    hasError: _errorText != null,
                    onChanged: (v) {
                      context.read<SignInCubit>().onPhoneChanged(v);
                      if (_errorText != null) {
                        setState(() => _errorText = null);
                      }
                    },
                    validator: null,
                  ),
                  if (_errorText != null) ...[
                    AppConstants.vSM,
                    Padding(
                      padding: EdgeInsets.only(left: AppResponsive.w(14)),
                      child: Text(_errorText!, style: AppTextStyles.labelS(color: AppColors.danger)),
                    ),
                  ],
                ],
              ),
              AppConstants.vSM,
              AppFormFields.hint(text: 'Standard SMS rates or WhatsApp verification apply'),
              AppConstants.vXL,
              AppButtons.primaryButton(
                label: 'Get Verification OTP',
                icon: Icons.arrow_forward_rounded,
                iconPosition: IconPosition.right,
                height: 54,
                enabled: state.isPhoneValid,
                onTap: () {
                  if (!state.isPhoneValid) {
                    setState(() => _errorText = AppValidators.phone(_controller.text));
                    return;
                  }
                  // TODO: trigger OTP send
                },
              ),
              AppConstants.vXL,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.fingerprint_rounded, size: AppResponsive.r(26), color: AppColors.textSecondary),
                        AppConstants.hMD,
                        Text('Biometric Login', style: AppTextStyles.bodyM(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  AppButtons.textButton(label: 'Forgot Password?', onTap: () {}, foregroundColor: AppColors.primary, underline: true),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

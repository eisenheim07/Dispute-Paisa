import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_validators.dart';

// ─────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────
class SignInState extends Equatable {
  const SignInState({
    this.phone = '',
    this.isPhoneValid = false,
    this.autoValidate = false,
    this.errorText,
  });

  final String phone;
  final bool isPhoneValid;
  final bool autoValidate;
  final String? errorText;

  SignInState copyWith({
    String? phone,
    bool? isPhoneValid,
    bool? autoValidate,
    String? errorText,
  }) =>
      SignInState(
        phone: phone ?? this.phone,
        isPhoneValid: isPhoneValid ?? this.isPhoneValid,
        autoValidate: autoValidate ?? this.autoValidate,
        errorText: errorText,
      );

  @override
  List<Object?> get props => [phone, isPhoneValid, autoValidate, errorText];
}

// ─────────────────────────────────────────────────────────────
// Cubit
// ─────────────────────────────────────────────────────────────
class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  void onPhoneChanged(String value) => emit(
        state.copyWith(
          phone: value,
          isPhoneValid: AppValidators.phone(value) == null,
          autoValidate: false, // Clear validation error when user types
          errorText: null, // Clear error text
        ),
      );

  void showError(String error) => emit(state.copyWith(errorText: error));
}

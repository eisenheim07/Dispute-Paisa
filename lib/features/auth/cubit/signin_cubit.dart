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
  });

  final String phone;
  final bool isPhoneValid;
  final bool autoValidate;

  SignInState copyWith({
    String? phone,
    bool? isPhoneValid,
    bool? autoValidate,
  }) =>
      SignInState(
        phone: phone ?? this.phone,
        isPhoneValid: isPhoneValid ?? this.isPhoneValid,
        autoValidate: autoValidate ?? this.autoValidate,
      );

  @override
  List<Object> get props => [phone, isPhoneValid, autoValidate];
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
        ),
      );

  void enableValidation() => emit(state.copyWith(autoValidate: true));
}

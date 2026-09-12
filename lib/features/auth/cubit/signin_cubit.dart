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
  });

  final String phone;
  final bool isPhoneValid;

  SignInState copyWith({String? phone, bool? isPhoneValid}) => SignInState(
        phone: phone ?? this.phone,
        isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      );

  @override
  List<Object> get props => [phone, isPhoneValid];
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
        ),
      );
}

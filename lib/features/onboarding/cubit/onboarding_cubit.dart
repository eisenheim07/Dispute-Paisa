import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────
class OnboardingState extends Equatable {
  const OnboardingState({this.currentPage = 0});

  final int currentPage;

  OnboardingState copyWith({int? currentPage}) =>
      OnboardingState(currentPage: currentPage ?? this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

// ─────────────────────────────────────────────────────────────
// Cubit
// ─────────────────────────────────────────────────────────────
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void onPageChanged(int page) => emit(state.copyWith(currentPage: page));
}

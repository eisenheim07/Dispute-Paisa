import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_color.dart';
import '../../../common/app_image_constants.dart';
import '../../../common/app_responsive.dart';
import '../../../common/app_text_styles.dart';
import '../../../common/common_widgets/custom_buttons.dart';
import '../../../common/common_widgets/smart_image.dart';
import '../../../features/auth/screens/signin_screen.dart';
import '../cubit/onboarding_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OnBoardingView();
  }
}

// ─────────────────────────────────────────────────────────────
// View — listens to cubit, no setState
// ─────────────────────────────────────────────────────────────
class _OnBoardingView extends StatelessWidget {
  const _OnBoardingView();

  static final List<_OnboardingData> _pages = [
    _OnboardingData(
      image: AppImageConstant.onBoarding1,
      title: 'Empanelled Advocates\nFighting For Your Case',
      body: 'Vetted High Court cyber advocates represent you before bank nodal officers, cyber cells, and courts without physical visits.',
    ),
    _OnboardingData(
      image: AppImageConstant.onBoarding2,
      title: 'Unfreeze Accounts\nWith Swift Legal Action',
      body: 'Instant automated dispute filing and statutory legal notices sent directly to bank nodal officers.',
    ),
    _OnboardingData(
      image: AppImageConstant.onBoarding3,
      title: 'Track Every Step &\nReclaim Your Funds',
      body: 'Real-time transparent updates across all 10 stages from initial cyber-cell liaison to final bank clearance.',
    ),
  ];

  void _onNext(BuildContext context, PageController controller, int currentPage) {
    if (currentPage < _pages.length - 1) {
      controller.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    } else {
      _goToSignIn(context);
    }
  }

  void _goToSignIn(BuildContext context) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SigninScreen()));

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Column(
          children: [
            // ── Slides ─────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: _pages.length,
                onPageChanged: (i) => context.read<OnboardingCubit>().onPageChanged(i),
                itemBuilder: (_, i) => _OnboardingPage(data: _pages[i]),
              ),
            ),

            // ── Bottom bar ─────────────────────────────────────────
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppResponsive.w(24), vertical: AppResponsive.h(24)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Skip
                      AppButtons.textButton(
                        label: 'Skip ',
                        onTap: () => _goToSignIn(context),
                        foregroundColor: AppColors.textSecondary,
                        underline: true,
                      ),

                      // Dot indicators
                      Row(children: List.generate(_pages.length, (i) => _DotIndicator(isActive: i == state.currentPage))),

                      // Next button
                      AppButtons.circularButton(
                        icon: Icons.arrow_forward_rounded,
                        onTap: () => _onNext(context, controller, state.currentPage),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Single slide
// ─────────────────────────────────────────────────────────────
class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.data});

  final _OnboardingData data;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Illustration ──────────────────────────────────────
        SizedBox(
          height: screenHeight * 0.48,
          width: double.infinity,
          child: SmartImage(source: data.image, width: MediaQuery.of(context).size.width, height: screenHeight * 0.48, fit: BoxFit.cover),
        ),

        // ── Text content ──────────────────────────────────────
        Padding(
          padding: EdgeInsets.fromLTRB(AppResponsive.w(24), AppResponsive.h(28), AppResponsive.w(24), 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title, style: AppTextStyles.headingXL(color: AppColors.textPrimary)),
              SizedBox(height: AppResponsive.h(12)),
              Text(data.body, style: AppTextStyles.bodyM(color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Dot indicator — active = wide pill, inactive = small circle
// ─────────────────────────────────────────────────────────────
class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: AppResponsive.w(3)),
      width: isActive ? AppResponsive.w(20) : AppResponsive.w(7),
      height: AppResponsive.h(7),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.primary200,
        borderRadius: BorderRadius.circular(AppResponsive.r(4)),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────────────────────
class _OnboardingData {
  const _OnboardingData({required this.image, required this.title, required this.body});

  final String image;
  final String title;
  final String body;
}

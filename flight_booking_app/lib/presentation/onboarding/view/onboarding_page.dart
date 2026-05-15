import 'package:flight_booking_app/domain/Entities/onboarding.dart';
import 'package:flight_booking_app/presentation/onboarding/view/widgets/content_section.dart';
import 'package:flight_booking_app/presentation/onboarding/view/widgets/onboarding_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension OnboardingNavigation on BuildContext {
  void goToOnboarding() => go('/onboarding');
}

class OnboardingPage extends StatelessWidget {
  final Onboarding data;
  final bool isLastPage;
  final VoidCallback onNextPressed;
  const OnboardingPage({
    super.key,
    required this.data,
    required this.isLastPage,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 6, child: OnboardingImage(imageUrl: data.imageUrl)),

        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ContentSection(
              title: data.title,
              description: data.description,
              onButtonPressed: onNextPressed,
              isNextPage: !isLastPage,
              currentPage: 0,
              totalPages: 3,
            ),
          ),
        ),
      ],
    );
  }
}

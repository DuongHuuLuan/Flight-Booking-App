import 'package:flight_booking_app/core/widgets/app_background_image.dart';
import 'package:flight_booking_app/domain/entities/onboarding_entity.dart';
import 'package:flight_booking_app/presentation/onboarding/view/widgets/content_section.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingEntity data;
  final bool isLastPage;
  final VoidCallback onNextPressed;
  final int currenPage;
  final int totalPages;
  const OnboardingPage({
    super.key,
    required this.data,
    required this.isLastPage,
    required this.onNextPressed,
    required this.currenPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBackgroundImage(imageUrl: data.imageUrl),

        Positioned(
          bottom: 40,
          left: 20,
          right: 20,
          child: ContentSection(
            title: data.title,
            description: data.description,
            onButtonPressed: onNextPressed,
            isNextPage: !isLastPage,
            currentPage: currenPage,
            totalPages: totalPages,
          ),
        ),
      ],
    );
  }
}

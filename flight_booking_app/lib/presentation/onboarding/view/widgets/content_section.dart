import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class ContentSection extends StatelessWidget {
  final String title;
  final String description;
  final void Function() onButtonPressed;
  final bool isNextPage;
  final int currentPage;
  final int totalPages;
  const ContentSection({
    super.key,
    required this.title,
    required this.description,
    required this.onButtonPressed,
    required this.isNextPage,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => _buildIndicator(index == currentPage),
            ),
          ),
          const SizedBox(height: 20),

          // Content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2.copyWith(color: AppColor.white),
              ),
              const SizedBox(height: 20),

              Text(
                description,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColor.greyLight,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.white,
              foregroundColor: AppColor.primary,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: onButtonPressed,
            child: Text(isNextPage ? "Next" : "Get Started"),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? AppColor.white
            : AppColor.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

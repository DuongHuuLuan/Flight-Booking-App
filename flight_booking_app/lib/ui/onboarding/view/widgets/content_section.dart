import 'package:flight_booking_app/ui/core/theme/app_color.dart';
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
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
                style: textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                description,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
            ],
          ),

          const SizedBox(height: 30),
          // Button ở đáy
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: colorTheme.primary,
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
        color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

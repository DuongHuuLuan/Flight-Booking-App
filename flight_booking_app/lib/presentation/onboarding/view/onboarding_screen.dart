import 'package:flight_booking_app/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:flight_booking_app/presentation/onboarding/cubit/onboarding_state.dart';
import 'package:flight_booking_app/presentation/onboarding/view/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          if (state is OnboardingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OnboardingLoaded) {
            return Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: state.data.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingPage(
                      data: state.data[index],
                      isLastPage: index == state.data.length - 1,
                      onNextPressed: _nextPage,
                    );
                  },
                ),
              ],
            );
          }

          if (state is OnboardingError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

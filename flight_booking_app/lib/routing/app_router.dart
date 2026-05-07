import 'package:flight_booking_app/injection_container.dart';
import 'package:flight_booking_app/ui/onboarding/cubit/onboarding_cubit.dart';
import 'package:flight_booking_app/ui/onboarding/view/onboarding_screen.dart';
import 'package:flight_booking_app/ui/splash/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,

    routes: [
      GoRoute(path: "/", builder: (context, state) => const SplashPage()),

      GoRoute(
        path: "/onboarding",
        builder: (context, state) => BlocProvider(
          create: (context) => sl<OnboardingCubit>()..loadData(),
          child: const OnboardingScreen(),
        ),
      ),
    ],
  );
}

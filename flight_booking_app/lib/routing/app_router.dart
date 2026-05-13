import 'package:flight_booking_app/injection_container.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:flight_booking_app/presentation/auth/view/login_page.dart';
import 'package:flight_booking_app/presentation/auth/view/register_page.dart';
import 'package:flight_booking_app/presentation/home/home_page.dart';
import 'package:flight_booking_app/presentation/location/cubit/location_cubit.dart';
import 'package:flight_booking_app/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:flight_booking_app/presentation/onboarding/view/onboarding_screen.dart';
import 'package:flight_booking_app/presentation/splash/splash_page.dart';
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
          create: (context) => getIt<OnboardingCubit>()..loadData(),
          child: const OnboardingScreen(),
        ),
      ),

      GoRoute(
        path: "/login",
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const LoginPage(),
        ),
      ),

      GoRoute(
        path: "/register",
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<AuthCubit>()),
            BlocProvider(
              create: (context) => getIt<LocationCubit>()..loadCountries(),
            ),
          ],
          child: const RegisterPage(),
        ),
      ),

      GoRoute(path: "/home", builder: (context, state) => const HomePage()),
    ],
  );
}

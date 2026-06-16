import 'package:flight_booking_app/domain/Entities/flight_search_params.dart';
import 'package:flight_booking_app/injection_container.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/forgot_password_screen.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/otp_verification_screen.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/reset_password_screen.dart';
import 'package:flight_booking_app/presentation/auth/view/login_page.dart';
import 'package:flight_booking_app/presentation/auth/view/register_page.dart';
import 'package:flight_booking_app/presentation/home/cubit/home_cubit.dart';
import 'package:flight_booking_app/presentation/home/view/home_screen.dart';
import 'package:flight_booking_app/presentation/location/cubit/location_cubit.dart';
import 'package:flight_booking_app/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:flight_booking_app/presentation/onboarding/view/onboarding_screen.dart';
import 'package:flight_booking_app/presentation/search/search_screen.dart';
import 'package:flight_booking_app/presentation/select_flight/cubit/select_flight_cubit.dart';
import 'package:flight_booking_app/presentation/select_flight/view/select_flight_screen.dart';
import 'package:flight_booking_app/presentation/splash/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/home",
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

      GoRoute(
        path: "/home",
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<AuthCubit>()..getUser()),
            BlocProvider(
              create: (context) => getIt<HomeCubit>()..loadHomeData(),
            ),
          ],
          child: const HomePage(),
        ),
      ),

      GoRoute(
        path: "/forgot-password",
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: "/otp-verification",
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: OtpVerificationScreen(),
        ),
      ),
      GoRoute(
        path: "/reset-password",
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: ResetPasswordScreen(),
        ),
      ),

      GoRoute(
        path: "/search",
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<HomeCubit>(),
          child: SearchScreen(),
        ),
      ),

      GoRoute(
        path: "/select-flight",
        builder: (context, state) => BlocProvider(
          create: (context) =>
              getIt<SelectFlightCubit>()
                ..loadFlights(state.extra as FlightSearchParams),
          child: SelectFlightScreen(),
        ),
      ),
    ],
  );
}

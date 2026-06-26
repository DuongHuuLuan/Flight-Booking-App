import 'package:flight_booking_app/domain/entities/booking_detail_entity.dart';
import 'package:flight_booking_app/domain/entities/flight_search_params.dart';
import 'package:flight_booking_app/injection_container.dart';
import 'package:flight_booking_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:flight_booking_app/presentation/auth/bloc/auth_event.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/forgot_password_screen.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/otp_verification_screen.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/reset_password_screen.dart';
import 'package:flight_booking_app/presentation/auth/view/login_screen.dart';
import 'package:flight_booking_app/presentation/auth/view/register_screen.dart';
import 'package:flight_booking_app/presentation/boarding_pass/view/boarding_pass_screen.dart';
import 'package:flight_booking_app/presentation/booking_detail/cubit/booking_detail_cubit.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/booking_detail_screen.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/cubit/flight_detail_cubit.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/view/flight_detail_screen.dart';
import 'package:flight_booking_app/presentation/flight/select_flight/cubit/select_flight_cubit.dart';
import 'package:flight_booking_app/presentation/flight/select_flight/view/select_flight_screen.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/cubit/select_seat_cubit.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/view/select_seat_screen.dart';
import 'package:flight_booking_app/presentation/home/cubit/home_cubit.dart';
import 'package:flight_booking_app/presentation/home/view/home_screen.dart';
import 'package:flight_booking_app/presentation/location/cubit/location_cubit.dart';
import 'package:flight_booking_app/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:flight_booking_app/presentation/onboarding/view/onboarding_screen.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_cubit.dart';
import 'package:flight_booking_app/presentation/passenger/view/passenger_detail_screen.dart';
import 'package:flight_booking_app/presentation/payment_method/cubit/payment_method_cubit.dart';
import 'package:flight_booking_app/presentation/payment_method/view/add_card_screen.dart';
import 'package:flight_booking_app/presentation/payment_method/view/payment_method_screen.dart';
import 'package:flight_booking_app/presentation/search/cubit/search_cubit.dart';
import 'package:flight_booking_app/presentation/search/search_screen.dart';
import 'package:flight_booking_app/presentation/splash/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: SplashPage.routerName,
    debugLogDiagnostics: true,

    routes: [
      GoRoute(
        path: SplashPage.routerName,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: const SplashPage(),
        ),
      ),

      GoRoute(
        path: OnboardingScreen.routerName,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<OnboardingCubit>()..loadData(),
          child: const OnboardingScreen(),
        ),
      ),

      GoRoute(
        path: LoginScreen.routerName,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: const LoginScreen(),
        ),
      ),

      GoRoute(
        path: RegisterScreen.routerName,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<AuthBloc>()),
            BlocProvider(
              create: (context) => getIt<LocationCubit>()..loadCountries(),
            ),
          ],
          child: const RegisterScreen(),
        ),
      ),

      GoRoute(
        path: HomePage.routerName,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<AuthBloc>()..add(GetUserEvent()),
            ),
            BlocProvider(
              create: (context) => getIt<HomeCubit>()..loadHomeData(),
            ),
          ],
          child: const HomePage(),
        ),
      ),

      GoRoute(
        path: ForgotPasswordScreen.routerName,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: OtpVerificationScreen.routerName,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: const OtpVerificationScreen(),
        ),
      ),
      GoRoute(
        path: ResetPasswordScreen.routerName,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: const ResetPasswordScreen(),
        ),
      ),

      GoRoute(
        path: SearchScreen.routerName,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SearchCubit>(),
          child: const SearchScreen(),
        ),
      ),

      GoRoute(
        path: SelectFlightScreen.routerName,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              getIt<SelectFlightCubit>()
                ..loadFlights(state.extra as FlightSearchParams),
          child: const SelectFlightScreen(),
        ),
      ),

      GoRoute(
        path: FlightDetailScreen.routerName,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              getIt<FlightDetailCubit>()
                ..loadFlightDetail(state.extra as String),
          child: FlightDetailScreen(flightId: state.extra as String),
        ),
      ),

      GoRoute(
        path: SelectSeatScreen.routerName,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create: (context) => getIt<SelectSeatCubit>()
              ..flightId = args['flightId'] as String
              ..cabinClass = args['cabinClass'] as String
              ..setBasePrice((args['basePrice'] as num).toDouble())
              ..loadSeats(),
            child: const SelectSeatScreen(),
          );
        },
      ),

      GoRoute(
        path: PassengerDetailScreen.routerName,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create: (context) => getIt<PassengerCubit>(),
            child: PassengerDetailScreen(
              bookingId: args['bookingId'] as String,
              seatCount: args['seatCount'] as int,
              basePrice: (args['basePrice'] as num).toDouble(),
            ),
          );
        },
      ),

      GoRoute(
        path: BookingDetailScreen.routerName,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create: (context) =>
                getIt<BookingDetailCubit>()
                  ..loadDetail(args['bookingId'] as String),
            child: BookingDetailScreen(
              bookingId: args['bookingId'] as String,
              basePrice: (args['basePrice'] as num).toDouble(),
              seatCount: args['seatCount'] as int,
            ),
          );
        },
      ),

      GoRoute(
        path: PaymentMethodScreen.routerName,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return BlocProvider(
            create: (context) {
              final cubit = getIt<PaymentMethodCubit>();
              if (args != null) {
                cubit.setTotalPrice((args['totalPrice'] as num).toDouble());
              }
              cubit.loadCards();
              return cubit;
            },
            child: const PaymentMethodScreen(),
          );
        },
      ),

      GoRoute(
        path: AddCardScreen.routerName,
        builder: (context, state) => const AddCardScreen(),
      ),

      GoRoute(
        path: BoardingPassScreen.routerName,
        builder: (context, state) =>
            BoardingPassScreen(booking: state.extra as BookingDetailEntity),
      ),
    ],
  );
}

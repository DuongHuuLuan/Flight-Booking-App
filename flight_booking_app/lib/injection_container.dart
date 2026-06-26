import 'package:dio/dio.dart';
import 'package:flight_booking_app/core/constants/app_constant.dart';
import 'package:flight_booking_app/core/cubit/loading/app_loading_cubit.dart';
import 'package:flight_booking_app/core/network/auth_interceptor.dart';
import 'package:flight_booking_app/data/datasources/local/auth_local_data_source.dart';
import 'package:flight_booking_app/data/datasources/mock/onboarding_mock_data_source.dart';
import 'package:flight_booking_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flight_booking_app/data/datasources/remote/booking_remote_data_source.dart';
import 'package:flight_booking_app/data/datasources/remote/flight_remote_data_source.dart';
import 'package:flight_booking_app/data/datasources/remote/home_remote_data_source.dart';
import 'package:flight_booking_app/data/datasources/remote/location_remote_data_source.dart';
import 'package:flight_booking_app/data/datasources/remote/seat_remote_data_source.dart';
import 'package:flight_booking_app/data/repositories/auth_repository_impl.dart';
import 'package:flight_booking_app/data/repositories/booking_repository_impl.dart';
import 'package:flight_booking_app/data/repositories/flight_repository_impl.dart';
import 'package:flight_booking_app/data/repositories/home_repository_impl.dart';
import 'package:flight_booking_app/data/repositories/location_repository_impl.dart';
import 'package:flight_booking_app/data/repositories/onboarding_repository_impl.dart';
import 'package:flight_booking_app/data/repositories/seat_repository_impl.dart';
import 'package:flight_booking_app/data/services/auth_service.dart';
import 'package:flight_booking_app/data/services/booking_service.dart';
import 'package:flight_booking_app/data/services/flight_service.dart';
import 'package:flight_booking_app/data/services/home_service.dart';
import 'package:flight_booking_app/data/services/location_service.dart';
import 'package:flight_booking_app/data/services/seat_service.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';
import 'package:flight_booking_app/domain/repositories/booking_repository.dart';
import 'package:flight_booking_app/domain/repositories/flight_repository.dart';
import 'package:flight_booking_app/domain/repositories/home_repository.dart';
import 'package:flight_booking_app/domain/repositories/location_repository.dart';
import 'package:flight_booking_app/domain/repositories/onboarding_repository.dart';
import 'package:flight_booking_app/domain/repositories/seat_repository.dart';
import 'package:flight_booking_app/domain/usecase/auth/forgot_password_with_email_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/forgot_password_with_sms_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/get_city_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/get_country_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/get_current_user_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/get_onboardin_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/login_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/logout_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/register_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/reset_password_by_email_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/reset_password_by_sms_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/verify_otp_usecase.dart';
import 'package:flight_booking_app/domain/usecase/booking/create_booking_usecase.dart';
import 'package:flight_booking_app/domain/usecase/booking/get_booking_usecase.dart';
import 'package:flight_booking_app/domain/usecase/flight/get_flight_detail_usecase.dart';
import 'package:flight_booking_app/domain/usecase/home/get_popular_flights_usecase.dart';
import 'package:flight_booking_app/domain/usecase/home/search_flights_usecsase.dart';
import 'package:flight_booking_app/domain/usecase/search/get_all_flights_usecase.dart';
import 'package:flight_booking_app/domain/usecase/seat/get_seat_layout_usecase.dart';
import 'package:flight_booking_app/domain/usecase/seat/select_seat_usecase.dart';
import 'package:flight_booking_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/cubit/flight_detail_cubit.dart';
import 'package:flight_booking_app/presentation/flight/select_flight/cubit/select_flight_cubit.dart';
import 'package:flight_booking_app/presentation/home/cubit/home_cubit.dart';
import 'package:flight_booking_app/presentation/location/cubit/location_cubit.dart';
import 'package:flight_booking_app/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstant.baseUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
    return dio;
  });

  // Service
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<Dio>()));
  getIt.registerLazySingleton<LocationService>(
    () => LocationService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<HomeService>(() => HomeService(getIt<Dio>()));
  getIt.registerLazySingleton<FlightService>(() => FlightService(getIt<Dio>()));
  getIt.registerLazySingleton<BookingService>(
    () => BookingService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<SeatService>(() => SeatService(getIt<Dio>()));

  // Data Source
  getIt.registerLazySingleton<OnboardingMockDataSource>(
    () => OnboardingMockDataSource(),
  );

  // Local Data Source
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  // Remote Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<AuthService>()),
  );
  getIt.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSource(getIt<LocationService>(), userMock: false),
  );
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(getIt<HomeService>(), userMock: false),
  );
  getIt.registerLazySingleton<FlightRemoteDataSource>(
    () => FlightRemoteDataSource(getIt<FlightService>()),
  );
  getIt.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSource(getIt<BookingService>()),
  );
  getIt.registerLazySingleton<SeatRemoteDataSource>(
    () => SeatRemoteDataSource(getIt<SeatService>()),
  );

  // Repositories
  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(
      mockDataSource: getIt<OnboardingMockDataSource>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSource: getIt<AuthLocalDataSource>(),
      remoteDataSource: getIt<AuthRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(getIt<LocationRemoteDataSource>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDataSource>()),
  );
  getIt.registerLazySingleton<FlightRepository>(
    () => FlightRepositoryImpl(getIt<FlightRemoteDataSource>()),
  );
  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(getIt<BookingRemoteDataSource>()),
  );
  getIt.registerLazySingleton<SeatRepository>(
    () => SeatRepositoryImpl(getIt<SeatRemoteDataSource>()),
  );

  //use case
  getIt.registerLazySingleton<GetOnboardingData>(
    () => GetOnboardingData(getIt<OnboardingRepository>()),
  );
  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetCountryUsecase>(
    () => GetCountryUsecase(getIt<LocationRepository>()),
  );
  getIt.registerLazySingleton<GetCityUsecase>(
    () => GetCityUsecase(getIt<LocationRepository>()),
  );

  getIt.registerLazySingleton<ForgotPasswordWithEmailUsecase>(
    () => ForgotPasswordWithEmailUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ForgotPasswordWithSmsUsecase>(
    () => ForgotPasswordWithSmsUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ResetPasswordByEmailUsecase>(
    () => ResetPasswordByEmailUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ResetPasswordBySmsUsecase>(
    () => ResetPasswordBySmsUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<VerifyOtpUsecase>(
    () => VerifyOtpUsecase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GetPopularFlightsUsecase>(
    () => GetPopularFlightsUsecase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton<SearchFlightsUsecsase>(
    () => SearchFlightsUsecsase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton<GetAllFlightsUsecase>(
    () => GetAllFlightsUsecase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton<GetFlightDetailUsecase>(
    () => GetFlightDetailUsecase(getIt<FlightRepository>()),
  );
  getIt.registerLazySingleton<CreateBookingUsecase>(
    () => CreateBookingUsecase(getIt<BookingRepository>()),
  );
  getIt.registerLazySingleton<GetSeatLayoutUsecase>(
    () => GetSeatLayoutUsecase(getIt<SeatRepository>()),
  );
  getIt.registerLazySingleton<SelectSeatUsecase>(
    () => SelectSeatUsecase(getIt<SeatRepository>()),
  );
  getIt.registerLazySingleton<GetBookingUsecase>(
    () => GetBookingUsecase(getIt<BookingRepository>()),
  );

  //cubit
  getIt.registerFactory(() => OnboardingCubit(getIt()));
  // getIt.registerFactory(
  //   () => AuthCubit(
  //     loginUsecase: getIt<LoginUsecase>(),
  //     registerUsecase: getIt<RegisterUsecase>(),
  //     logoutUsecase: getIt<LogoutUsecase>(),
  //     getCurrentUserUsecase: getIt<GetCurrentUserUsecase>(),
  //     localStorage: getIt<AuthLocalDataSource>(),
  //     forgotPasswordWithEmailUsecase: getIt<ForgotPasswordWithEmailUsecase>(),
  //     forgotPasswordWithSmsUsecase: getIt<ForgotPasswordWithSmsUsecase>(),
  //     resetPasswordByEmailUsecase: getIt<ResetPasswordByEmailUsecase>(),
  //     resetPasswordBySmsUsecase: getIt<ResetPasswordBySmsUsecase>(),
  //     verifyOtpUsecase: getIt<VerifyOtpUsecase>(),
  //   ),
  // );
  getIt.registerFactory(
    () => AuthBloc(
      loginUsecase: getIt<LoginUsecase>(),
      registerUsecase: getIt<RegisterUsecase>(),
      logoutUsecase: getIt<LogoutUsecase>(),
      getCurrentUserUsecase: getIt<GetCurrentUserUsecase>(),
      localStorage: getIt<AuthLocalDataSource>(),
      forgotPasswordWithEmailUsecase: getIt<ForgotPasswordWithEmailUsecase>(),
      forgotPasswordWithSmsUsecase: getIt<ForgotPasswordWithSmsUsecase>(),
      resetPasswordByEmailUsecase: getIt<ResetPasswordByEmailUsecase>(),
      resetPasswordBySmsUsecase: getIt<ResetPasswordBySmsUsecase>(),
      verifyOtpUsecase: getIt<VerifyOtpUsecase>(),
    ),
  );
  getIt.registerFactory(
    () => LocationCubit(
      getCountryUsecase: getIt<GetCountryUsecase>(),
      getCityUsecase: getIt<GetCityUsecase>(),
    ),
  );

  getIt.registerFactory(
    () => HomeCubit(
      getPopularFlights: getIt<GetPopularFlightsUsecase>(),
      searchFlightsUsecase: getIt<SearchFlightsUsecsase>(),
      getAllFlightsUsecase: getIt<GetAllFlightsUsecase>(),
    ),
  );

  getIt.registerFactory(
    () => SelectFlightCubit(
      getAllFlightsUsecase: getIt<GetAllFlightsUsecase>(),
      searchFlightsUsecsase: getIt<SearchFlightsUsecsase>(),
    ),
  );
  getIt.registerFactory(() => AppLoadingCubit());

  getIt.registerFactory(
    () => FlightDetailCubit(
      getFlightDetail: getIt<GetFlightDetailUsecase>(),
    ),
  );
}

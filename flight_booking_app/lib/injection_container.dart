import 'package:dio/dio.dart';
import 'package:flight_booking_app/core/constants/app_constant.dart';
import 'package:flight_booking_app/data/datasources/local/auth_local_data_source.dart';
import 'package:flight_booking_app/data/datasources/mock/onboarding_mock_data_source.dart';
import 'package:flight_booking_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flight_booking_app/data/datasources/remote/location_remote_data_source.dart';
import 'package:flight_booking_app/data/repositories/auth_repository_impl.dart';
import 'package:flight_booking_app/data/repositories/location_repository_impl.dart';
import 'package:flight_booking_app/data/repositories/onboarding_repository_impl.dart';
import 'package:flight_booking_app/data/services/auth_service.dart';
import 'package:flight_booking_app/data/services/location_service.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';
import 'package:flight_booking_app/domain/repositories/location_repository.dart';
import 'package:flight_booking_app/domain/repositories/onboarding_repository.dart';
import 'package:flight_booking_app/domain/usecase/forgot_password_with_email_usecase.dart';
import 'package:flight_booking_app/domain/usecase/forgot_password_with_sms_usecase.dart';
import 'package:flight_booking_app/domain/usecase/get_city_usecase.dart';
import 'package:flight_booking_app/domain/usecase/get_country_usecase.dart';
import 'package:flight_booking_app/domain/usecase/get_onboardin_usecase.dart';
import 'package:flight_booking_app/domain/usecase/login_usecase.dart';
import 'package:flight_booking_app/domain/usecase/logout_usecase.dart';
import 'package:flight_booking_app/domain/usecase/register_usecase.dart';
import 'package:flight_booking_app/domain/usecase/reset_password_by_email_usecase.dart';
import 'package:flight_booking_app/domain/usecase/reset_password_by_sms_usecase.dart';
import 'package:flight_booking_app/domain/usecase/verify_otp_usecase.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:flight_booking_app/presentation/location/cubit/location_cubit.dart';
import 'package:flight_booking_app/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  getIt.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: AppConstant.baseUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
      ),
    ),
  );

  // Service
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<Dio>()));
  getIt.registerLazySingleton<LocationService>(
    () => LocationService(getIt<Dio>()),
  );

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
    () => LocationRemoteDataSource(getIt<LocationService>(), userMock: true),
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

  //usecase
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

  //cubit
  getIt.registerFactory(() => OnboardingCubit(getIt()));
  getIt.registerFactory(
    () => AuthCubit(
      loginUsecase: getIt<LoginUsecase>(),
      registerUsecase: getIt<RegisterUsecase>(),
      logoutUsecase: getIt<LogoutUsecase>(),
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
}

import 'package:flight_booking_app/data/repositories/auth_repository_impl.dart';
import 'package:flight_booking_app/data/repositories/onboarding_repository_impl.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';
import 'package:flight_booking_app/domain/repositories/onboarding_repository.dart';
import 'package:flight_booking_app/domain/usecase/getProfileUsecase.dart';
import 'package:flight_booking_app/domain/usecase/get_onboarding_data.dart';
import 'package:flight_booking_app/domain/usecase/loginUsecase.dart';
import 'package:flight_booking_app/domain/usecase/logoutUsecase.dart';
import 'package:flight_booking_app/domain/usecase/registerUsecase.dart';
import 'package:flight_booking_app/ui/auth/cubit/auth_cubit.dart';
import 'package:flight_booking_app/ui/onboarding/cubit/onboarding_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //cubit
  sl.registerFactory(() => OnboardingCubit(sl()));
  sl.registerFactory(
    () => AuthCubit(
      loginUsecase: sl(),
      registerUsecase: sl(),
      logoutUsecase: sl(),
      getProfileUsecase: sl(),
    ),
  );

  //usecase
  sl.registerLazySingleton(() => GetOnboardingData(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => GetProfileUsecase(sl()));

  //reppository
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
}

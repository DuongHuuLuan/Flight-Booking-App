import 'package:flight_booking_app/data/repositories/onboarding_repository_impl.dart';
import 'package:flight_booking_app/domain/repositories/onboarding_repository.dart';
import 'package:flight_booking_app/domain/usecase/get_onboarding_data.dart';
import 'package:flight_booking_app/ui/onboarding/cubit/onboarding_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //cubit
  sl.registerFactory(() => OnboardingCubit(sl()));

  //usecase
  sl.registerLazySingleton(() => GetOnboardingData(sl()));

  //reppository
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(),
  );
}

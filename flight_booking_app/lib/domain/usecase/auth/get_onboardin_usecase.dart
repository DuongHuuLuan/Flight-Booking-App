import 'package:flight_booking_app/domain/entities/onboarding_entity.dart';
import 'package:flight_booking_app/domain/repositories/onboarding_repository.dart';

class GetOnboardingData {
  final OnboardingRepository repository;
  GetOnboardingData(this.repository);

  Future<List<OnboardingEntity>> call() async {
    return await repository.getData();
  }
}

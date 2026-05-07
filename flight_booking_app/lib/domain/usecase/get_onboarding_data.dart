import 'package:flight_booking_app/domain/models/onboarding.dart';
import 'package:flight_booking_app/domain/repositories/onboarding_repository.dart';

class GetOnboardingData {
  final OnboardingRepository repository;
  GetOnboardingData(this.repository);

  Future<List<OnboardingModel>> call() async {
    return await repository.getData();
  }
}

import 'package:flight_booking_app/domain/entities/onboarding_entity.dart';

abstract class OnboardingRepository {
  Future<List<OnboardingEntity>> getData();
}

import 'package:flight_booking_app/domain/Entities/onboarding.dart';

abstract class OnboardingRepository {
  Future<List<Onboarding>> getData();
}

import 'package:flight_booking_app/domain/models/onboarding.dart';

abstract class OnboardingRepository {
  Future<List<OnboardingModel>> getData();
}

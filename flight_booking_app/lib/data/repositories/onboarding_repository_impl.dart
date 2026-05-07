import 'package:flight_booking_app/data/mock/mock_onboarding_data.dart';
import 'package:flight_booking_app/domain/models/onboarding.dart';
import 'package:flight_booking_app/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<List<OnboardingModel>> getData() async {
    await Future.delayed(const Duration(seconds: 1));
    return onboardingData;
  }
}

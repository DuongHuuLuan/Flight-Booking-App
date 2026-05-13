import 'package:flight_booking_app/data/datasources/mock/onboarding_mock_data_source.dart';
import 'package:flight_booking_app/domain/Entities/onboarding.dart';
import 'package:flight_booking_app/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingMockDataSource _mockDataSource;

  OnboardingRepositoryImpl({required OnboardingMockDataSource mockDataSource})
    : _mockDataSource = mockDataSource;

  @override
  Future<List<Onboarding>> getData() async {
    final list = await _mockDataSource.getOnboardingData();
    return list;
  }
}

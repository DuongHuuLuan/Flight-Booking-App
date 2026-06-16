import 'dart:convert';

import 'package:flight_booking_app/data/mappers/onboarding_mapper.dart';
import 'package:flight_booking_app/domain/entities/onboarding_entity.dart';
import 'package:flutter/services.dart';

class OnboardingMockDataSource {
  final bool useEmbeddedData;

  OnboardingMockDataSource({this.useEmbeddedData = false});

  Future<List<OnboardingEntity>> getOnboardingData() async {
    final String jsonString = await rootBundle.loadString(
      "assets/data/mock/onboarding.json",
    );
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return OnboardingMapper.fromJsonList(jsonList);
  }
}

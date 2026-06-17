import 'dart:convert';

import 'package:flight_booking_app/domain/entities/onboarding_entity.dart';

class OnboardingMapper {
  static OnboardingEntity fromJson(Map<String, dynamic> json) {
    return OnboardingEntity(
      id: json["id"] as int,
      title: json["title"] as String,
      description: json["description"] as String,
      imageUrl: json["imageUrl"] as String,
    );
  }

  static Map<String, dynamic> toJson(OnboardingEntity onboarding) {
    return {
      "id": onboarding.id,
      "title": onboarding.title,
      "description": onboarding.description,
      "imageUrl": onboarding.imageUrl,
    };
  }

  static OnboardingEntity fromJsonString(String jsonString) {
    return fromJson(jsonDecode(jsonString));
  }

  static String toJsonString(OnboardingEntity onboarding) {
    return jsonEncode(onboarding);
  }

  static List<OnboardingEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(
    List<OnboardingEntity> onboardings,
  ) {
    return onboardings.map((onboarding) => toJson(onboarding)).toList();
  }
}

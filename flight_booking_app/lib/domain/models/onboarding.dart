class OnboardingModel {
  final int id;
  final String title;
  final String description;
  final String? imageUrl;

  OnboardingModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
  });
}

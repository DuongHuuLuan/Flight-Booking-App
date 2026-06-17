class OnboardingEntity {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  OnboardingEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return OnboardingEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

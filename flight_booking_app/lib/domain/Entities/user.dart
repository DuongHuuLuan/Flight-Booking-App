class UserEntity {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String country;
  final String city;
  final String? avatar;
  final String password;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.city,
    this.avatar,
    required this.password,
  });

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? country,
    String? city,
    String? avatar,
    String? password,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      city: city ?? this.city,
      avatar: avatar ?? this.avatar,
      password: password ?? this.password,
    );
  }
}

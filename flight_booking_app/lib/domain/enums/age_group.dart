enum AgeGroup { child, adult, senior }

extension AgeGroupDisplay on AgeGroup {
  String get displayName => switch (this) {
    AgeGroup.child => 'Child',
    AgeGroup.adult => 'Adult',
    AgeGroup.senior => 'Senior',
  };
}

class LocationData {
  static const List<String> countries = [
    'Vietnam',
    'United States',
    'United Kingdom',
    'Japan',
    'Singapore',
    'Thailand',
    'United Arab Emirates',
    'Australia',
    'Germany',
    'France',
  ];

  static const Map<String, List<String>> citiesByCountry = {
    'Vietnam': ['Hanoi', 'Ho Chi Minh City', 'Da Nang', 'Hue'],
    'United States': ['New York', 'Los Angeles', 'Chicago', 'Houston'],
    'United Kingdom': ['London', 'Manchester', 'Birmingham', 'Liverpool'],
    'Japan': ['Tokyo', 'Osaka', 'Kyoto', 'Yokohama'],
    'Singapore': ['Singapore'],
    'Thailand': ['Bangkok', 'Chiang Mai', 'Pattaya'],
    'United Arab Emirates': ['Dubai', 'Abu Dhabi', 'Sharjah'],
    'Australia': ['Sydney', 'Melbourne', 'Brisbane', 'Perth'],
    'Germany': ['Berlin', 'Munich', 'Hamburg', 'Frankfurt'],
    'France': ['Paris', 'Lyon', 'Marseille', 'Nice'],
  };

  static List<String> getCitiesForCountry(String country) {
    return citiesByCountry[country] ?? [];
  }
}

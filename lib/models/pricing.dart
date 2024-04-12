class Pricing {
  final double day1;
  final double day2;
  final double day3;
  final double day4;
  final double day5;
  final double day6;
  final double day7;

  const Pricing({
    required this.day1,
    required this.day2,
    required this.day3,
    required this.day4,
    required this.day5,
    required this.day6,
    required this.day7,
  });

  factory Pricing.fromJson(Map<String, Object?> json) {
    return Pricing(
      day1: (json['1day'] as num?)?.toDouble() ?? 0.0,
      day2: (json['2day'] as num?)?.toDouble() ?? 0.0,
      day3: (json['3day'] as num?)?.toDouble() ?? 0.0,
      day4: (json['4day'] as num?)?.toDouble() ?? 0.0,
      day5: (json['5day'] as num?)?.toDouble() ?? 0.0,
      day6: (json['6day'] as num?)?.toDouble() ?? 0.0,
      day7: (json['7day'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, Object?> toJson() => {
    '1day': day1,
    '2day': day2,
    '3day': day3,
    '4day': day4,
    '5day': day5,
    '6day': day6,
    '7day': day7,
  };
}

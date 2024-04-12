import 'package:db_info/models/pricing.dart';

class Yacht {
  final String name;
  final int capacity;
  final Pricing highPriceList;
  final Pricing lowPriceList;

  const Yacht({
    required this.name,
    required this.capacity,
    required this.highPriceList,
    required this.lowPriceList,
  });

  factory Yacht.fromJson(Map<String, Object?> json) {
    return Yacht(
      name: json['name'] as String? ?? '',
      capacity: json['capacity'] as int,
      highPriceList: Pricing.fromJson(json['highPriceList'] as Map<String, Object?>? ?? {}),
      lowPriceList: Pricing.fromJson(json['lowPriceList'] as Map<String, Object?>? ?? {}),
    );
  }

  Map<String, Object?> toJson() => {
    'name': name,
    'capacity': capacity,
    'highPriceList': highPriceList.toJson(),
    'lowPriceList': lowPriceList.toJson(),
  };
}

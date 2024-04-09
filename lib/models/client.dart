import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class Client {
  final String from;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String yachtName;
  final DateTimeRange charterDate;
  final String advance;
  final String sum;
  final String discount;
  final double amountOfPeople;
  final String notes;

  const Client({
    required this.from,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.yachtName,
    required this.charterDate,
    required this.advance,
    required this.sum,
    required this.discount,
    required this.amountOfPeople,
    required this.notes,
  });

  Client.fromJson(Map<String, Object?> json)
      : this(
    from: json['from'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    yachtName: json['yachtName'] as String,
    charterDate: json['charterDate'] as DateTimeRange,
    advance: json['advance'] as String,
    sum: json['sum'] as String,
    discount: json['discount'] as String,
    amountOfPeople: json['amountOfPeople'] as double,
    notes: json['discount'] as String,
  );
}

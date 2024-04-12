import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class Reservation {
  final String from;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final List<String> yachtNames;
  final DateTimeRange charterDate;
  final double advance;
  final double sum;
  final double discount;
  final double amountOfPeople;
  final String notes;

  const Reservation({
    required this.from,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.yachtNames,
    required this.charterDate,
    required this.advance,
    required this.sum,
    required this.discount,
    required this.amountOfPeople,
    required this.notes,
  });

  factory Reservation.fromJson(Map<String, Object?> json) {
    return Reservation(
        from: json['from'] as String? ?? '',
        firstName: json['firstName'] as String? ?? '',
        lastName: json['lastName'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        email: json['email'] as String? ?? '',
        yachtNames: (json['yachtNames'] as List?)?.map((item) => item as String).toList() ?? [],
        charterDate: DateTimeRange(
            start: (json['charterStartDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
            end: (json['charterEndDate'] as Timestamp?)?.toDate() ?? DateTime.now()
        ),
        advance: (json['advance'] as num?)?.toDouble() ?? 0.0,
        sum: (json['sum'] as num?)?.toDouble() ?? 0.0,
        discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
        amountOfPeople: (json['amountOfPeople'] as num?)?.toDouble() ?? 1,
        notes: json['notes'] as String? ?? ''
    );
  }

  Map<String, Object?> toJson() => {
    'from': from,
    'firstName': firstName,
    'lastName': lastName,
    'phone': phone,
    'email': email,
    'yachtNames': yachtNames,
    'charterStartDate': Timestamp.fromDate(charterDate.start),
    'charterEndDate': Timestamp.fromDate(charterDate.end),
    'advance': advance,
    'sum': sum,
    'discount': discount,
    'amountOfPeople': amountOfPeople,
    'notes': notes
  };
}


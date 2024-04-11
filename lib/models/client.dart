import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Client.fromJson(Map<String, Object?> json) {
    return Client(
        from: json['from'] as String? ?? '',
        firstName: json['firstName'] as String? ?? '',
        lastName: json['lastName'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        email: json['email'] as String? ?? '',
        yachtName: json['yachtName'] as String? ?? '',
        charterDate: DateTimeRange(
            start: (json['charterStartDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
            end: (json['charterEndDate'] as Timestamp?)?.toDate() ?? DateTime.now()
        ),
        advance: json['advance'] as String? ?? '0',
        sum: json['sum'] as String? ?? '0',
        discount: json['discount'] as String? ?? '0',
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
    'yachtName': yachtName,
    'charterStartDate': Timestamp.fromDate(charterDate.start),
    'charterEndDate': Timestamp.fromDate(charterDate.end),
    'advance': advance,
    'sum': sum,
    'discount': discount,
    'amountOfPeople': amountOfPeople,
    'notes': notes
  };


}

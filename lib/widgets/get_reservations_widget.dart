import 'package:db_info/models/reservation.dart';
import 'package:flutter/material.dart';

import '../services/database_service.dart';

class GetReservationsWidget extends StatefulWidget {
  const GetReservationsWidget({super.key});

  @override
  State<GetReservationsWidget> createState() => _GetReservationsWidgetState();
}

class _GetReservationsWidgetState extends State<GetReservationsWidget> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).width,
      child: StreamBuilder(
        stream: _databaseService.getReservations(), builder: (context, snapshot) {
        List reservations = snapshot.data?.docs ?? [];

        return ListView.builder(itemCount: reservations.length, itemBuilder:(context, index) {
          Reservation reservation = reservations[index].data();
          String reservationId = reservations[index].id;
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.primaryContainer,
              title: Text(reservation.firstName),
              onLongPress: () {
                _databaseService.deleteReservation(reservationId);
              },
            ),
          );
        },);
      },),
    );
  }
}

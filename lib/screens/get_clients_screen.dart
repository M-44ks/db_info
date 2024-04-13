import 'package:flutter/material.dart';

import '../widgets/get_reservations_widget.dart';

class GetClientsScreen extends StatefulWidget {
  const GetClientsScreen({super.key});

  @override
  State<GetClientsScreen> createState() => _GetClientsScreenState();
}

class _GetClientsScreenState extends State<GetClientsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Rezerwacje'),
        ),
        body: const SafeArea(
            child: Column(
              children: [
                GetReservationsWidget(),
              ],
            )),
      );
}

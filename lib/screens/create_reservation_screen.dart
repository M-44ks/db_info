import 'package:flutter/material.dart';

import '../widgets/create_reservation_form_widget.dart';

class CreateReservationScreen extends StatelessWidget {
  const CreateReservationScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Create client'),
        ),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              CreateReservationFormWidget(),
            ],
          ),
        ),
      );

}
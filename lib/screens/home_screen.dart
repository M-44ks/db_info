import 'package:db_info/screens/get_clients_screen.dart';
import 'package:flutter/material.dart';

import 'create_reservation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Utwórz rezerwację'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateReservationScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Lista rezerwacji'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const GetClientsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

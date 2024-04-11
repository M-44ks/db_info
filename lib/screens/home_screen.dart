import 'package:db_info/screens/create_client_screen.dart';
import 'package:db_info/screens/get_clients_screen.dart';
import 'package:flutter/material.dart';

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
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Features'),
            ),
            ListTile(
              title: const Text('Create Client'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateClientScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Clients'),
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

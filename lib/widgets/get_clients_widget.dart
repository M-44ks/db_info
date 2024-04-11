import 'package:flutter/material.dart';

import '../models/client.dart';
import '../services/database_service.dart';

class GetClientsWidget extends StatefulWidget {
  const GetClientsWidget({super.key});

  @override
  State<GetClientsWidget> createState() => _GetClientsWidgetState();
}

class _GetClientsWidgetState extends State<GetClientsWidget> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).width,
      child: StreamBuilder(
        stream: _databaseService.getClients(), builder: (context, snapshot) {
        List clients = snapshot.data?.docs ?? [];

        return ListView.builder(itemCount: clients.length, itemBuilder:(context, index) {
          Client client = clients[index].data();
          String clientId = clients[index].id;
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.primaryContainer,
              title: Text(client.firstName),
              onLongPress: () {
                _databaseService.deleteClient(clientId);
              },
            ),
          );
        },);
      },),
    );
  }
}

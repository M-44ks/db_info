import 'package:db_info/widgets/get_clients_widget.dart';
import 'package:flutter/material.dart';

class GetClientsScreen extends StatefulWidget {
  const GetClientsScreen({super.key});

  @override
  State<GetClientsScreen> createState() => _GetClientsScreenState();
}

class _GetClientsScreenState extends State<GetClientsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Clients'),
        ),
        body: const SafeArea(
            child: Column(
              children: [
                GetClientsWidget(),
              ],
            )),
      );
}

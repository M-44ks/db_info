import 'package:db_info/models/yacht.dart';
import 'package:flutter/material.dart';

import '../services/database_service.dart';

class GetYachtsWidget extends StatefulWidget {
  const GetYachtsWidget({super.key});

  @override
  State<GetYachtsWidget> createState() => _GetYachtsWidgetState();
}

class _GetYachtsWidgetState extends State<GetYachtsWidget> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).width,
      child: StreamBuilder(
        stream: _databaseService.getYachts(1), builder: (context, snapshot) {
        List yachts = snapshot.data?.docs ?? [];

        return ListView.builder(itemCount: yachts.length, itemBuilder:(context, index) {
          Yacht yacht = yachts[index].data();
          String yachtId = yachts[index].id;
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.primaryContainer,
              title: Text('${yacht.name} '),
              onLongPress: () {
                _databaseService.deleteYacht(yachtId);
              },
            ),
          );
        },);
      },),
    );
  }
}

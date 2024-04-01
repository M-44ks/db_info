import 'package:db_info/widgets/client_create_form_widget.dart';
import 'package:flutter/material.dart';

class CreateClientScreen extends StatelessWidget {
  const CreateClientScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text('Create client'),
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: const [
              ClientCreateFormWidget(),
            ],
          ),
        ),
      );

}
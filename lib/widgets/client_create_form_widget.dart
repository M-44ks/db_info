import 'package:db_info/models/client.dart';
import 'package:flutter/material.dart';

class ClientCreateFormWidget extends StatefulWidget {
  const ClientCreateFormWidget({super.key});

  @override
  State<ClientCreateFormWidget> createState() => _ClientCreateFormWidgetState();
}

class _ClientCreateFormWidgetState extends State<ClientCreateFormWidget> {
  DateTimeRange? _selectedDateTimeRange;

  void _presentDateTimeRangePicker() async {
    final pickedDateTimeRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );

    setState(() {
      _selectedDateTimeRange = pickedDateTimeRange;
    });
  }

  @override
  Widget build(BuildContext context) => Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildFirstAndLastName(),
            const SizedBox(height: 16),
            buildPhone(),
            const SizedBox(height: 16),
            buildEmail(),
            const SizedBox(height: 16),
            buildYacht(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: _presentDateTimeRangePicker,
                  child: const Row(children: [
                    Text('Data Czarteru'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.date_range)
                  ]),
                ),
                Text(_selectedDateTimeRange == null
                    ? 'Nie wybrano daty'
                    : '${formatter.format(_selectedDateTimeRange!.start)} - ${formatter.format(_selectedDateTimeRange!.end)}'),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
}

Widget buildFirstAndLastName() => TextFormField(
      decoration: const InputDecoration(
        labelText: 'Imie i  Nazwisko',
        border: OutlineInputBorder(),
      ),
    );

Widget buildPhone() => TextFormField(
      decoration: const InputDecoration(
        labelText: 'Telefon',
        border: OutlineInputBorder(),
      ),
    );

Widget buildEmail() => TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
    );

//TODO LISTA POBIERANA Z ARKUSZY
const List<String> _kOptions = <String>[
  'SR190',
  'SR210B',
  'SR230C',
];

@override
Widget buildYacht() => Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toUpperCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );

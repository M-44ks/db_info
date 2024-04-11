import 'package:db_info/models/client.dart';
import 'package:flutter/material.dart';

import '../services/database_service.dart';

class ClientCreateFormWidget extends StatefulWidget {
  final Client? client;

  const ClientCreateFormWidget({
    super.key,
    this.client,
  });

  @override
  State<ClientCreateFormWidget> createState() => _ClientCreateFormWidgetState();
}

class _ClientCreateFormWidgetState extends State<ClientCreateFormWidget> {
  final DatabaseService _databaseService = DatabaseService();

  late TextEditingController controllerFrom;
  late TextEditingController controllerFirstName;
  late TextEditingController controllerLastName;
  late TextEditingController controllerPhone;
  late TextEditingController controllerEmail;
  late String yachtName;
  late DateTimeRange? _selectedDateTimeRange;
  late TextEditingController controllerAdvance;
  late TextEditingController controllerSum;
  late TextEditingController controllerDiscount;
  double _currentAmountOfPeople = 2;
  late TextEditingController controllerNotes;

  @override
  void initState() {
    super.initState();
    initClient();
  }

  void initClient() {
    final from = widget.client?.from ?? '';
    final firstName = widget.client?.firstName ?? '';
    final lastName = widget.client?.lastName ?? '';
    final phone = widget.client?.phone ?? '';
    final email = widget.client?.email ?? '';
    final yachtName = widget.client?.yachtName ?? '';
    final charterDate = widget.client?.charterDate;
    final advance = widget.client?.advance ?? '0';
    final sum = widget.client?.sum ?? '0';
    final discount = widget.client?.discount ?? '0';
    final double amountOfPeople = widget.client?.amountOfPeople ?? 1;
    final notes = widget.client?.notes ?? '';

    setState(() {
      controllerFrom = TextEditingController(text: from);
      controllerFirstName = TextEditingController(text: firstName);
      controllerLastName = TextEditingController(text: lastName);
      controllerPhone = TextEditingController(text: phone);
      controllerEmail = TextEditingController(text: email);
      this.yachtName = yachtName;
      _selectedDateTimeRange = charterDate;
      controllerAdvance = TextEditingController(text: advance);
      controllerSum = TextEditingController(text: sum);
      controllerDiscount = TextEditingController(text: discount);
      _currentAmountOfPeople = amountOfPeople;
      controllerNotes = TextEditingController(text: notes);
    });
  }

  @override
  Widget build(BuildContext context) =>
      Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildFrom(),
            const SizedBox(height: 16),
            buildFirstName(),
            const SizedBox(height: 16),
            buildLastName(),
            const SizedBox(height: 16),
            buildPhone(),
            const SizedBox(height: 16),
            buildEmail(),
            const SizedBox(height: 16),
            buildYacht(),
            const SizedBox(height: 16),
            buildDateRange(),
            const SizedBox(height: 16),
            buildAmountOfPeople(),
            const SizedBox(height: 16),
            buildAdvance(),
            const SizedBox(height: 16),
            buildSum(),
            const SizedBox(height: 16),
            buildDiscount(),
            const SizedBox(height: 16),
            buildNotes(),
            const SizedBox(height: 32),
            buildSubmit(),
          ],
        ),
      );





  Widget buildFrom() =>
      TextFormField(
        controller: controllerFrom,
        decoration: const InputDecoration(
          labelText: 'Skąd się o nas dowiedział',
          border: OutlineInputBorder(),
        ),
      );

  Widget buildFirstName() =>
      TextFormField(
        controller: controllerFirstName,
        decoration: const InputDecoration(
          labelText: 'Imie',
          border: OutlineInputBorder(),
        ),
      );

  Widget buildLastName() =>
      TextFormField(
        controller: controllerLastName,
        decoration: const InputDecoration(
          labelText: 'Nazwisko',
          border: OutlineInputBorder(),
        ),
      );

  //TODO przy połączeniu przychodzącym na false inaczej true
  bool flag = false;

  Widget buildPhone() =>
      GestureDetector(
        onDoubleTap: () =>
            setState(() {
              flag = flag == false ? true : false;
            }),
        child: TextFormField(
          controller: controllerPhone,
          enabled: flag,
          //TODO numer dzwoniącego
          // initialValue: '123 456 789',
          decoration: const InputDecoration(
            labelText: 'Telefon',
            border: OutlineInputBorder(),
          )

          ,

        ),
      );

  Widget buildEmail() =>
      TextFormField(
        controller: controllerEmail,
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
      );

//TODO LISTA POBIERANA Z ARKUSZY
  static const List<String> _kOptions = <String>[
    'SR190',
    'SR210B',
    'SR230C',
  ];

  Widget buildYacht() =>
      Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return _kOptions.where((String option) {
            return option.contains(textEditingValue.text.toUpperCase());
          });
        },
        onSelected: (String selection) {
          yachtName = selection;
        },
      );

//TODO Na podstawie wybranej łodzi - zajęte terminy
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

  Widget buildDateRange() => Row(
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
          : '${formatter.format(
          _selectedDateTimeRange!.start)} - ${formatter.format(
          _selectedDateTimeRange!.end)}'),
    ],
  );

  //TODO Na podstawie wybranej łodzi
  Widget buildAmountOfPeople() =>
      Slider(
        value: _currentAmountOfPeople,
        min: 1,
        max: 15,
        divisions: 15,
        label: _currentAmountOfPeople.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentAmountOfPeople = value;
          });
        },
      );

  Widget buildAdvance() =>
      TextFormField(
        controller: controllerAdvance,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Zaliczka',
          border: OutlineInputBorder(),
          suffixText: 'zł',
        ),
      );

  Widget buildSum() =>
      TextFormField(
        controller: controllerSum,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Kwota',
          border: OutlineInputBorder(),
          suffixText: 'zł',
        ),
      );

  Widget buildDiscount() =>
      TextFormField(
        controller: controllerDiscount,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Rabat',
          border: OutlineInputBorder(),
          suffixText: 'zł',
        ),
      );

  Widget buildNotes() =>
      TextFormField(
        controller: controllerNotes,
        maxLines: 5,
        decoration: const InputDecoration(
          labelText: 'Uwagi',
          border: OutlineInputBorder(),
        ),
      );

  Widget buildSubmit() =>
      FilledButton(
        onPressed: () {
          Client client = Client(
              from: controllerFrom.text,
              firstName: controllerFirstName.text,
              lastName: controllerLastName.text,
              phone: controllerPhone.text,
              email: controllerEmail.text,
              yachtName: yachtName,
              charterDate: _selectedDateTimeRange ?? DateTimeRange(start: DateTime.now(), end: DateTime.now()),
              advance: controllerAdvance.text,
              sum: controllerSum.text,
              discount: controllerDiscount.text,
              amountOfPeople: _currentAmountOfPeople,
              notes: controllerNotes.text
          );


          _databaseService.addClient(client);
          Navigator.pop(context);
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        child: const Text('Zapisz'),
      );
}
import 'package:flutter/material.dart';

import '../models/reservation.dart';
import '../services/database_service.dart';

class CreateReservationFormWidget extends StatefulWidget {
  final Reservation? reservation;

  const CreateReservationFormWidget({
    super.key,
    this.reservation,
  });

  @override
  State<CreateReservationFormWidget> createState() =>
      _CreateReservationFormWidgetState();
}

class _CreateReservationFormWidgetState
    extends State<CreateReservationFormWidget> {
  final DatabaseService _databaseService = DatabaseService();

  late TextEditingController controllerFrom;
  late TextEditingController controllerFirstName;
  late TextEditingController controllerLastName;
  late TextEditingController controllerPhone;
  late TextEditingController controllerEmail;
  late List<TextEditingController> controllerYachtNames;
  late DateTimeRange? _selectedDateTimeRange;
  late TextEditingController controllerAdvance;
  late TextEditingController controllerSum;
  late TextEditingController controllerDiscount;
  double _currentAmountOfPeople = 2;
  late TextEditingController controllerNotes;
  var amountOfYachts = 1;

  @override
  void initState() {
    super.initState();
    initReservation();
  }

  void initReservation() {
    final from = widget.reservation?.from ?? '';
    final firstName = widget.reservation?.firstName ?? '';
    final lastName = widget.reservation?.lastName ?? '';
    //TODO Tu logika połączenia przychodzącego
    final phone = widget.reservation?.phone ?? '';
    final email = widget.reservation?.email ?? '';
    final yachtNames = widget.reservation?.yachtNames ?? [''];
    final charterDate = widget.reservation?.charterDate;
    final advance = widget.reservation?.advance ?? '';
    final sum = widget.reservation?.sum ?? '';
    final discount = widget.reservation?.discount ?? '';
    final double amountOfPeople = widget.reservation?.amountOfPeople ?? 1;
    final notes = widget.reservation?.notes ?? '';

    setState(() {
      controllerFrom = TextEditingController(text: from);
      controllerFirstName = TextEditingController(text: firstName);
      controllerLastName = TextEditingController(text: lastName);
      controllerPhone = TextEditingController(text: phone);
      controllerEmail = TextEditingController(text: email);
      controllerYachtNames =
          yachtNames.map((name) => TextEditingController(text: name)).toList();
      _selectedDateTimeRange = charterDate;
      controllerAdvance = TextEditingController(text: advance.toString());
      controllerSum = TextEditingController(text: sum.toString());
      controllerDiscount = TextEditingController(text: discount.toString());
      _currentAmountOfPeople = amountOfPeople;
      controllerNotes = TextEditingController(text: notes);
    });
  }

  @override
  Widget build(BuildContext context) => Form(
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
            ListView.builder(
              itemCount: amountOfYachts,
              itemBuilder: (context, index) => buildYacht(index),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
            Builder(
              builder: (context) {
                // Check the condition based on the last item in the list
                bool lastIsEmpty = controllerYachtNames.isNotEmpty &&
                    controllerYachtNames.last.text.isEmpty;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // if (lastIsEmpty && controllerYachtNames.length > 1)
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => setState(() {
                       if(amountOfYachts == 0) {
                           amountOfYachts = 0;
                         } else {
                         amountOfYachts--;
                         controllerYachtNames
                             .removeLast();
                       }
                      }),
                    ),
                    // if (!lastIsEmpty)
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => setState(() {
                          amountOfYachts++;
                          controllerYachtNames.add(
                              TextEditingController());
                        }),
                      ),
                  ],
                );
              },
            ),
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

  Widget buildFrom() => TextFormField(
        controller: controllerFrom,
        decoration: const InputDecoration(
          labelText: 'Skąd się o nas dowiedział',
          border: OutlineInputBorder(),
        ),
      );

  Widget buildFirstName() => TextFormField(
        controller: controllerFirstName,
        decoration: const InputDecoration(
          labelText: 'Imie',
          border: OutlineInputBorder(),
        ),
      );

  Widget buildLastName() => TextFormField(
        controller: controllerLastName,
        decoration: const InputDecoration(
          labelText: 'Nazwisko',
          border: OutlineInputBorder(),
        ),
      );

  //TODO przy połączeniu przychodzącym na false inaczej true
  bool flag = false;

  Widget buildPhone() => GestureDetector(
        onDoubleTap: () => setState(() {
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
          ),
        ),
      );

  Widget buildEmail() => TextFormField(
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

  Widget buildYacht(int index) => Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return _kOptions.where((String option) {
            return option.contains(textEditingValue.text.toUpperCase());
          });
        },
        onSelected: (String selection) {
          setState(() {
            controllerYachtNames[index].text = selection;
          });
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
              : '${formatter.format(_selectedDateTimeRange!.start)} - ${formatter.format(_selectedDateTimeRange!.end)}'),
        ],
      );

  //TODO Na podstawie wybranej łodzi
  Widget buildAmountOfPeople() => Slider(
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

  Widget buildAdvance() => TextFormField(
        controller: controllerAdvance,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Zaliczka',
          border: OutlineInputBorder(),
          suffixText: 'zł',
        ),
      );

  Widget buildSum() => TextFormField(
        controller: controllerSum,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Kwota',
          border: OutlineInputBorder(),
          suffixText: 'zł',
        ),
      );

  Widget buildDiscount() => TextFormField(
        controller: controllerDiscount,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Rabat',
          border: OutlineInputBorder(),
          suffixText: 'zł',
        ),
      );

  Widget buildNotes() => TextFormField(
        controller: controllerNotes,
        maxLines: 5,
        decoration: const InputDecoration(
          labelText: 'Uwagi',
          border: OutlineInputBorder(),
        ),
      );

  Widget buildSubmit() => FilledButton(
        onPressed: () {
          Reservation reservation = Reservation(
              from: controllerFrom.text,
              firstName: controllerFirstName.text,
              lastName: controllerLastName.text,
              phone: controllerPhone.text,
              email: controllerEmail.text,
              yachtNames: controllerYachtNames
                  .map((controller) => controller.text)
                  .toList(),
              charterDate: _selectedDateTimeRange ??
                  DateTimeRange(start: DateTime.now(), end: DateTime.now()),
              advance: double.tryParse(controllerAdvance.text) ?? 0.0,
              sum: double.tryParse(controllerSum.text) ?? 0.0,
              discount: double.tryParse(controllerDiscount.text) ?? 0.0,
              amountOfPeople: _currentAmountOfPeople,
              notes: controllerNotes.text);

          _databaseService.addReservation(reservation);
          Navigator.pop(context);
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        child: const Text('Zapisz'),
      );
}

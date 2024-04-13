import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/reservation.dart';
import '../models/yacht.dart';
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
  late double _currentAmountOfPeople;
  late TextEditingController controllerNotes;
  List<double> amountOfPeopleOnBoat = [4];
  var amountOfYachts = 1;

  List<Yacht> yachtList = [];
  late List<List<String>> _kOptions;
  List<Key> autocompleteKeys = [];
  List<FocusNode> focusNodes = [];

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
    final double amountOfPeople = widget.reservation?.amountOfPeople ?? 0;
    final notes = widget.reservation?.notes ?? '';

    setState(() {
      controllerFrom = TextEditingController(text: from);
      controllerFirstName = TextEditingController(text: firstName);
      controllerLastName = TextEditingController(text: lastName);
      controllerPhone = TextEditingController(text: phone);
      controllerEmail = TextEditingController(text: email);
      controllerYachtNames = yachtNames.map((name) {
        var key = UniqueKey();
        autocompleteKeys.add(key);
        focusNodes.add(FocusNode());
        return TextEditingController(text: name);
      }).toList();
      _kOptions = List.generate(yachtNames.length, (index) => []);
      _selectedDateTimeRange = charterDate;
      controllerAdvance = TextEditingController(text: advance.toString());
      controllerSum = TextEditingController(text: sum.toString());
      controllerDiscount = TextEditingController(text: discount.toString());
      _currentAmountOfPeople = amountOfPeople;
      controllerNotes = TextEditingController(text: notes);
    });
  }

  Future<void> getYachts(capacity) async {
    yachtList.clear();
    QuerySnapshot snapshot = await _databaseService.getYachts(capacity).first;
    List yachts = snapshot.docs;
    for (var yachtDoc in yachts) {
      Yacht yacht = yachtDoc.data();
      yachtList.add(yacht);
    }
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
              itemBuilder: (context, index) => Column(
                children: [
                  buildAmountOfPeople(index),
                  buildYacht(index),
                  const SizedBox(height: 16),
                ],
              ),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
            Builder(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => setState(() {
                        if (amountOfYachts > 0) {
                          amountOfYachts--;
                          controllerYachtNames.removeLast();
                          amountOfPeopleOnBoat.removeLast();
                          autocompleteKeys.removeLast();
                          focusNodes.removeLast();
                          _kOptions.removeLast();
                        }
                      }),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => setState(() {
                        amountOfYachts++;
                        controllerYachtNames.add(TextEditingController());
                        amountOfPeopleOnBoat.add(4);
                        autocompleteKeys.add(UniqueKey());
                        focusNodes.add(FocusNode());
                        _kOptions.add([]);
                      }),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            buildDateRange(),
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

  bool isUpdatingYachts = false;

  Widget buildAmountOfPeople(index) => Slider(
    value: amountOfPeopleOnBoat[index],
    min: 1,
    max: 15,
    divisions: 15,
    label: amountOfPeopleOnBoat[index].round().toString(),
    onChanged: (double value) async {
      // Lock the sliding when another sliding action is in process
      if (isUpdatingYachts) return;

      setState(() {
        isUpdatingYachts = true;
        amountOfPeopleOnBoat[index] = value;
      });

      try {
        await getYachts(amountOfPeopleOnBoat[index]);

        setState(() {
          _kOptions[index].clear();
          _kOptions[index] = yachtList.map((yacht) => yacht.name).toList();
        });
      } catch (e) {
        // Handle the exception
      } finally {
        setState(() {
          isUpdatingYachts = false;  // Release the lock when done
        });
      }
    },
  );

  Widget buildYacht(int index) => Autocomplete<String>(
    key: autocompleteKeys[index],
    optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text == '' || focusNodes[index].hasFocus) {
        // return all options while the input field is in focus
        return _kOptions[index];
      }
      // Here, return the filtered options when there is input in the text field
      // and the autocomplete is not in focus
      return _kOptions[index].where((String option) {
        return option.contains(textEditingValue.text.toUpperCase());
      });
    },
    onSelected: (String selection) {
      setState(() {
        controllerYachtNames[index].text = selection;
      });
    },
    fieldViewBuilder: (BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode fieldFocusNode,
        VoidCallback onFieldSubmitted) {
      return TextFormField(
        controller: fieldTextEditingController,
        focusNode: fieldFocusNode,
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
        decoration: InputDecoration(
          labelText: index == 0 ? 'Jacht' : 'Jacht ${index + 1}',
          border: const OutlineInputBorder(),
        ),
      );
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
          for (var element in amountOfPeopleOnBoat) {
            _currentAmountOfPeople += element;
          }
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

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/bookingService.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({super.key}) {}

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  //final TextEditingController _statecontroller = TextEditingController();
  //final TextEditingController _citycontroller = TextEditingController();
  //final TextEditingController _areacontroller = TextEditingController();
  //final TextEditingController _spotcontroller = TextEditingController();

  String? state;
  String? city;
  String? area;
  String? spot;

  List<String> states = getStates();

  //final List<DropdownMenuEntry<String>> stateEntries =
  //  <DropdownMenuEntry<String>>[];

  var stateEntries = [];

  List<String> cityEntries = List<String>.empty();

  //final List<DropdownMenuEntry<String>> cityEntries =
  //    <DropdownMenuEntry<String>>[];

  final List<DropdownMenuEntry<String>> areaEntries =
      <DropdownMenuEntry<String>>[];

  final List<DropdownMenuEntry<String>> spotEntries =
      <DropdownMenuEntry<String>>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < states.length; i++) {
      //stateEntries.add(DropdownMenuEntry(value: states[i], label: states[i]));
      stateEntries.add(states[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            Container(
              height: 100,
              child: DropdownButton(
                value: state,
                elevation: 16,
                onChanged: (String? value) {
                  setState(() {
                    state = value;
                    cityEntries = getCities(state.toString());
                  });
                },
                items:
                    stateEntries.map<DropdownMenuItem<String>>((dynamic value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 100,
              child: DropdownButton(
                value: city,
                elevation: 16,
                onChanged: (String? value) {
                  setState(() {
                    city = value;
                  });
                },
                items:
                    cityEntries.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            //Container(
            //  height: 100,
            //  child: DropdownMenu(
            //    controller: _areacontroller,
            //    initialSelection: null,
            //    dropdownMenuEntries: areaEntries,
            //    enabled: areaEntries.isNotEmpty,
            //  ),
            //),
            //Container(
            //  height: 100,
            //  child: DropdownMenu(
            //    controller: _spotcontroller,
            //    initialSelection: null,
            //    dropdownMenuEntries: spotEntries,
            //    enabled: spotEntries.isNotEmpty,
            //  ),
            //)
          ]),
        ),
      ),
    ));
  }

  //void addCities() {
  //  setState(() {
  //    List<String> cities = getCities(_statecontroller.text);
  //    cityEntries.clear();
//
  //    for (var i = 0; i < cities.length; i++) {
  //      cityEntries.add(DropdownMenuEntry(value: cities[i], label: cities[i]));
  //    }
  //  });
  //}
//
  //void addAreas() {
  //  Map<String, String> areas =
  //      getAreas(_statecontroller.text, _citycontroller.text);
  //  areaEntries.clear();
//
  //  for (String i in areas.keys) {
  //    areaEntries.add(DropdownMenuEntry(value: areas[i].toString(), label: i));
  //  }
  //}
//
  //void addSpots() {
  //  List<List> spots = getSpotPlaces(_areacontroller.value.toString());
//
  //  spotEntries.clear();
//
  //  for (List i in spots) {
  //    spotEntries
  //        .add(DropdownMenuEntry(value: i[2], label: i[0], enabled: i[1]));
  //  }
  //}
//
//
}

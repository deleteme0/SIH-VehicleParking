import 'package:flutter/material.dart';
import 'package:flutter_application_1/my-spots-screen.dart';
import 'package:flutter_application_1/services/bookingService.dart';
import 'package:flutter_application_1/services/userService.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({super.key}) {}

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? state;
  String? city;
  String? area;
  String? spot;

  List<String> states = getStates();

  var stateEntries = [];

  List<String> cityEntries = List<String>.empty();

  final List<DropdownMenuItem<String>> areaEntries =
      <DropdownMenuItem<String>>[];

  final List<DropdownMenuItem<String>> spotEntries =
      <DropdownMenuItem<String>>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < states.length; i++) {
      stateEntries.add(states[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Book your spot")),
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
                        city = null;
                        area = null;
                        spot = null;
                      });
                    },
                    items: stateEntries
                        .map<DropdownMenuItem<String>>((dynamic value) {
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
                        addAreas();
                        area = null;
                        spot = null;
                      });
                    },
                    items: cityEntries
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  height: 100,
                  child: DropdownButton(
                    value: area,
                    elevation: 16,
                    onChanged: (String? value) {
                      setState(() {
                        area = value;
                        print(area);
                        addSpots();
                        spot = null;
                      });
                    },
                    items: areaEntries,
                  ),
                ),
                Container(
                  height: 100,
                  child: DropdownButton(
                    value: spot,
                    elevation: 16,
                    onChanged: (String? value) {
                      setState(() {
                        spot = value;
                      });
                    },
                    items: spotEntries,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      bookSpot();
                      Navigator.pop(context);
                      //Navigator.push(
                      //    context,
                      //    MaterialPageRoute(
                      //        builder: (context) => MySpotsScreen()));
                    },
                    child: const Text("Book Now")),
              ]),
            ),
          ),
        ));
  }

  void addAreas() {
    Map<String, String> areas = getAreas(state.toString(), city.toString());
    areaEntries.clear();

    for (String i in areas.keys) {
      areaEntries.add(DropdownMenuItem<String>(
        value: areas[i].toString(),
        child: Text(i.toString()),
      ));
    }
  }

  void addSpots() {
    print(area);
    List<List> spots = getSpotPlaces(area.toString());

    spotEntries.clear();

    for (List i in spots) {
      var op = "";
      if (i[1] == false) {
        op = " unavailable";
      }

      spotEntries.add(DropdownMenuItem(
        value: i[2].toString(),
        enabled: i[1],
        child: Text("${i[0]}${op}PRICE - ${i[3]}"),
      ));
    }
  }

  void bookSpot() {
    BookTheSpot(spot.toString(), getId());
  }

//
}

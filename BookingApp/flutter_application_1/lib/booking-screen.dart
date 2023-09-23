import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/bookingService.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({super.key}) {}

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController _statecontroller = TextEditingController();
  final TextEditingController _citycontroller = TextEditingController();
  final TextEditingController _areacontroller = TextEditingController();
  final TextEditingController _spotcontroller = TextEditingController();
  List<String> states = getStates();

  final List<DropdownMenuEntry<String>> stateEntries =
      <DropdownMenuEntry<String>>[];

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < states.length; i++) {
      stateEntries.add(DropdownMenuEntry(value: states[i], label: states[i]));
    }
    return const Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(children: []),
      ),
    ));
  }
}

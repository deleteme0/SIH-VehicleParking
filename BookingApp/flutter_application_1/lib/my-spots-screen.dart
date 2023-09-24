import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking-screen.dart';
import 'package:flutter_application_1/services/bookingService.dart';
import 'package:flutter_application_1/services/userService.dart';

class MySpotsScreen extends StatefulWidget {
  MySpotsScreen({super.key});

  @override
  State<MySpotsScreen> createState() => _MySpotsScreenState();
}

class _MySpotsScreenState extends State<MySpotsScreen> {
  var Bookings = [];
  var username;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Bookings = getBookings();
    username = getUsername();
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi $username, Your Spots"),
      ),
      body: Container(
        child: Column(
          children: [
            for (var id in Bookings)
              Container(
                decoration:
                    BoxDecoration(color: Colors.amber, border: Border.all()),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text("SPOT NAME:  " + id["spotnumber"].toString()),
                        Text("LOCATION:  " + id["location"].toString()),
                      ],
                    ),
                    Text("CODE: " + id["code"].toString()),
                    ElevatedButton(
                        onPressed: () async {
                          var trash = await removeReservedSpot(id["id"]);
                          var temp = await getAllBookings();
                          _showMyDialog(trash);
                          setState(() {
                            Bookings = getBookings();
                          });
                        },
                        child: Text("Quit"))
                  ],
                ),
              ),
            ElevatedButton(
                onPressed: () {
                  getSpots();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BookingScreen()));
                },
                child: Text("Press here to book Spots")),
            ElevatedButton(
                onPressed: () async {
                  var temp = await getAllBookings();
                  setState(() {
                    //Bookings = temp;
                  });
                },
                child: Text("Refresh")),
          ],
        ),
      ),
    );
  }

  Future<double> removeReservedSpot(String spotid) async {
    double price = await removeBooking(spotid);
    print(spotid);
    await getSpots();

    return price;
  }

  Future<void> _showMyDialog(double price) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("FEE - " + price.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

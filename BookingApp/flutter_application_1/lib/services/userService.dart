// ignore: file_names
import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  // ignore: prefer_typing_uninitialized_variables
  var username;
  // ignore: prefer_typing_uninitialized_variables
  var id;

  var spotsbooked;

  User(String this.username, String this.id, List<dynamic> this.spotsbooked);
}

var myUser = null;

//localhost:3001
//testparking.onrender.com
Future<bool> getUserLogin(String user1) async {
  try {
    var url = Uri.http(
      "localhost:3001",
      "/api/user/login/",
    );

    var body = {"user": user1};

    var bodyEncoded = json.encode(body);
    var response = await http.post(
      url,
      body: bodyEncoded,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      myUser = new User(user1, data["id"], data["spotsbooked"]);

      return true;
    } else if (response.statusCode == 400) {
      print("wrong username, Creating new user");
      return await createUser(user1);
    } else {
      print("api error");
      return false;
    }
  } catch (e) {
    print(e);
  }

  return false;
}

Future<bool> createUser(String name) async {
  try {
    var url = Uri.http(
      "localhost:3001",
      "/api/user/",
    );

    var body = {"user": name};

    var bodyEncoded = json.encode(body);
    var response = await http.post(
      url,
      body: bodyEncoded,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      myUser = new User(name, data["id"], data["spotsbooked"]);

      return true;
    } else if (response.statusCode == 208) {
      print("idk wtf?");
    } else {
      print("api error");
    }
    return false;
  } catch (e) {
    print(e);
  }
  return false;
}

String getId() {
  return myUser.id;
}

String getUsername() {
  return myUser.username;
}

List getBookings() {
  return myUser.spotsbooked;
}

Future<List> getAllBookings() async {
  try {
    var url = Uri.http(
      "localhost:3001",
      "/api/user/login/",
    );

    var body = {"user": myUser.username};

    var bodyEncoded = json.encode(body);
    var response = await http.post(
      url,
      body: bodyEncoded,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      myUser.spotsbooked = data["spotsbooked"];
    }
  } catch (e) {
    print(e);
  }
  return myUser.spotsbooked;
}

Future<double> removeBooking(String spotid) async {
  try {
    var url = Uri.http(
      "localhost:3001",
      "/api/reserve/",
    );

    var body = {"userid": myUser.id, "spotid": spotid};

    var bodyEncoded = json.encode(body);
    var response = await http.delete(
      url,
      body: bodyEncoded,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("deleted");
      return data["timetaken"] * data["price"];
    }
  } catch (e) {
    print(e);
  }
  return -1;
}

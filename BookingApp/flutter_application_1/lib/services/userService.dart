// ignore: file_names
import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  var username;
  var id;

  User(String username, String id) {
    this.username = username;
    this.id = id;
  }
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

      myUser = new User(user1, data["id"]);

      return true;
    } else if (response.statusCode == 400) {
      print("wrong username");
      return false;
    } else {
      print("api error");
      return false;
    }
  } catch (e) {
    print(e);
  }

  return false;
}

String getId() {
  return myUser.id;
}

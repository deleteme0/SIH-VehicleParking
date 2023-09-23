// ignore: file_names
import 'dart:convert' as convert;

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

Future<bool> getUserLogin(String user1) async {
  try {
    var url = Uri.https(
      "testparking.onrender.com",
      "/api/user/login/",
    );

    var response = await http.post(url, body: {'user': 'Him'});

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);

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

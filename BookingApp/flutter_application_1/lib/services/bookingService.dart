import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

var state = [];
var allData;

Future<void> getSpots() async {
  try {
    var url = Uri.http(
      "localhost:3001",
      "/api/spots/",
    );

    var response = await http.post(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      allData = data;
    }
  } catch (e) {
    print(e);
  }
}

List<String> getStates() {
  List<String> ans = [];

  for (dynamic each in allData) {
    if (!ans.contains(each["state"].toString())) {
      ans.add(each["state"].toString());
    }
  }

  return ans;
}

List<String> getCities(String state) {
  List<String> ans = [];

  for (dynamic each in allData) {
    if (each["state"] == state) {
      if (!ans.contains(each["city"])) {
        ans.add(each["city"].toString());
      }
    }
  }

  return ans;
}

Map<String, String> getAreas(String state, String city) {
  Map<String, String> ans = {};

  for (dynamic each in allData) {
    if (each["state"] == state && each["city"] == city) {
      if (!ans.containsKey(each["area"])) {
        ans[each["area"].toString()] = each["_id"].toString();
      }
    }
  }

  return ans;
}

List<dynamic> getSpotPlaces(String id) {
  for (dynamic each in allData) {
    if (each["_id"].toString() == id) {
      return each["spots"];
    }
  }

  return List<dynamic>.empty();
}

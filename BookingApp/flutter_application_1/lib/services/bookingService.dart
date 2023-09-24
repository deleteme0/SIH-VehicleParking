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

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      allData = data;
      print(data);
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
  int pp = 0;

  for (dynamic each in allData) {
    if (each["state"].toString() == state) {
      if (!ans.contains(each["city"])) {
        ans.add(each["city"].toString());
        print(each["city"]);
        print(pp);
        pp++;
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

List<List> getSpotPlaces(String id) {
  List<List> ans = [];

  for (dynamic each in allData) {
    if (each["_id"].toString() == id) {
      //return each["spots"];
      for (dynamic i in each["spots"]) {
        ans.add([i["spotnumber"].toString(), i["available"], i["id"]]);
      }

      return ans;
    }
  }

  return List<List<String>>.empty();
}

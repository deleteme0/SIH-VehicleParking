import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

var state = [];
var allData;

var useurl = "localhost:3001";
//var useurl = "testparking.onrender.com";

Future<void> getSpots() async {
  try {
    var url = Uri.http(
      useurl,
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
        ans[each["area"].toString()] = each["id"].toString();
      }
    }
  }

  return ans;
}

List<List> getSpotPlaces(String id) {
  List<List> ans = [];

  for (dynamic each in allData) {
    if (each["id"].toString() == id) {
      //return each["spots"];
      for (dynamic i in each["spots"]) {
        ans.add([i["spotnumber"].toString(), i["available"], i["id"]]);
      }

      return ans;
    }
  }

  return List<List<String>>.empty();
}

void BookTheSpot(String spotid, String userid) async {
  print("spot" + spotid);
  print("user" + userid);
  try {
    var url = Uri.http(useurl, "/api/reserve/");

    var body = {"userid": userid, "spotid": spotid};

    var bodyEncoded = json.encode(body);
    var response = await http.post(
      url,
      body: bodyEncoded,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("success");
    } else {
      print(response.body);
    }
  } catch (e) {
    print(e);
  }
}

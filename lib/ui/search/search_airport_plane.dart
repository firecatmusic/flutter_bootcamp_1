import 'dart:async';
import 'dart:convert';

import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterx_live_data/flutterx_live_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:http/http.dart' as http;

import '../../core/data/model/searchairplane/FlightData.dart';

class SearchAirplaneAirportScreen extends StatefulWidget {
  const SearchAirplaneAirportScreen({Key? key}) : super(key: key);

  @override
  State<SearchAirplaneAirportScreen> createState() => _SearchAirplaneAirportState();
}

class _SearchAirplaneAirportState extends State<SearchAirplaneAirportScreen> with StateObserver<SearchAirplaneAirportScreen> {
  String words = "";
  final MutableLiveData<List<AllFlight>> _listAllFlight = MutableLiveData(initialValue: []);

  @override
  void initState() {
    super.initState();
    fetchData(words);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.blueAccent));
  }

  @override
  Widget build(BuildContext context) {
    final wordsLength = words.length;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [header(context), body(context)],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Row(
        children: [
          Flexible(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(16),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    words = value;
                    fetchData(words);
                  },
                  decoration: InputDecoration(fillColor: Colors.white, filled: true, prefixIcon: Icon(Icons.search), border: OutlineInputBorder(), hintText: 'Search airports or city name'),
                ),
              )),
          Flexible(
              flex: 1,
              child: Container(
                child: OutlinedButton(
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                        return Colors.blueAccent;
                      }),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.white),
                    )),
              ))
        ],
      ),
    );
  }

  Widget body(BuildContext context) {
    return Flexible(
      child: Container(
        child: LiveDataBuilder<List<AllFlight>>(
            data: _listAllFlight,
            builder: (context, value) => GroupedListView<AllFlight, String>(
                  elements: value,
                  groupBy: (element) => element.countryName.toString(),
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) => item1.locationName.toString().compareTo(item2.locationName.toString()),
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) => Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Text(
                      value,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  itemBuilder: (c, element) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              element.airportName.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              element.locationName.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
      ),
    );
  }

  fetchData(String keyfilter) async {
    final response = await http.get(Uri.parse('https://api.nuryazid.com/dummy_/station.json'));
    print('Response status: ${response.statusCode}');
    print('Response keyfilter: $keyfilter');
    var list = <AllFlight>[];
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final dataResponse = FlightResponses.fromJson(jsonDecode(response.body)).allFlight;
      if (dataResponse?.isNotEmpty == true) {
        for (var data in dataResponse!) {
          if (data.countryName.toString().toLowerCase().contains(keyfilter) ||
              data.locationName.toString().toLowerCase().contains(keyfilter) ||
              data.airportName.toString().toLowerCase().contains(keyfilter)) {
            list.add(data);
          }
        }
      }
      _listAllFlight.postValue(list);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetching data!');
    }
  }

  @override
  FutureOr<void> registerObservers() {
    _listAllFlight.observe(this, (value) {
      print('Response size: ${value.length}');
      print('Response body: ${json.encode(value)}');
    });
  }
}

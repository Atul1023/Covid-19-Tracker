import 'package:covid19tracker/pages/allCountriesList.dart';
import 'package:flutter/material.dart';
import 'package:covid19tracker/services/getData.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:covid19tracker/services/cards.dart';
import 'package:covid19tracker/utils/constants.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  var jsondata;
  var cases;
  var now = new DateTime.now();
  CoronaDetails details;
  String url = "https://api-corona.herokuapp.com/total";
  Future<void> getData() async {
    final response = await http.get(url);
    jsondata = json.decode(response.body);
    details = CoronaDetails.fromJson(jsondata);
    if (this.mounted) {
      setState(() {});
    }
  }

  Map worldData;
  List countryData;

  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');

    if (this.mounted) {
      setState(() {
        countryData = json.decode(response.body);
      });
    }
  }

  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');

    if (this.mounted) {
      setState(() {
        worldData = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWorldWideData();
    fetchCountryData();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Bgcolor,
      body: details == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: new AlwaysStoppedAnimation<Color>(Fgcolor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Are  we  there  yet?',
                  style: GoogleFonts.specialElite(
                      letterSpacing: 4,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kthemeColor),
                )
              ],
            )
          : RefreshIndicator(
              onRefresh: getData,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: details.main
                    .map(
                      (pointer) => Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 20,
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                shadowCard("Total CASES", pointer.coronaCases,
                                    context, Color(0xFF7460ED), Colors.indigo),
                                shadowCard("Total DEATHS", pointer.coronaDeaths,
                                    context, Color(0xFFed3e23), Colors.red),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                shadowCard("Total RECOVERED", pointer.recoverd,
                                    context, Color(0xFF4CAF50), Colors.green),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CountryList()));
                                    },
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "View All Countries",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Active Cases",
                              style: TextStyle(
                                color: kthemeColorLite,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                inherit: true,
                                letterSpacing: 0.4,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            waveCard(
                                context,
                                "Infected",
                                pointer.coronaCurrent,
                                pointer.coronaCurrent,
                                Colors.greenAccent,
                                Color(0xFF914ff9)),
                            waveCard(
                              context,
                              "In Mild Condition",
                              pointer.coronaMild,
                              pointer.coronaCurrent,
                              Colors.greenAccent,
                              Color(0xFFf99820),
                            ),
                            waveCard(
                                context,
                                "Critical",
                                pointer.coronaCritical,
                                pointer.coronaCurrent,
                                Colors.grey.shade100,
                                Color(0xFFed3e23)),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}

import 'package:covid19tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class IndiaStats extends StatefulWidget {
  IndiaStats({Key key}) : super(key: key);

  @override
  _IndiaStatsState createState() => _IndiaStatsState();
}

class _IndiaStatsState extends State<IndiaStats> {
  ApiData apiData;
  var decodedJson;
  var totalTested;
  Future<List<ApiData>> getData() async {
    var res = await http.get(
      Uri.encodeFull("https://api.covid19india.org/data.json"),
    );
    decodedJson = jsonDecode(res.body);

    List<ApiData> data = [];
    for (var u in decodedJson["statewise"]) {
      apiData = ApiData(
          u["state"],
          u["confirmed"],
          u["active"],
          u["recovered"],
          u["deaths"],
          u["deltaconfirmed"],
          u["deltadeaths"],
          u["deltarecovered"]);
      data.add(apiData);
    }
    int counter = 0;
    for (var v in decodedJson["tested"]) {
      counter++;
    }
    totalTested = decodedJson["tested"][counter - 1]["totalsamplestested"];
    return data;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return (snapshot.data == null)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: CircularProgressIndicator(
                              backgroundColor: kthemeColorLite,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Swapping time and space...',
                            style: GoogleFonts.gruppo(
                                letterSpacing: 4,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kthemeColor),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.all(15),
                            height: 180,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: kthemeColor,
                                      blurRadius: 10,
                                      offset: Offset(3, 4))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[index].state,
                                            style: GoogleFonts.openSans(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 15, top: 10, right: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                "Confirmed",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange[900]),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data[index].total
                                                    .toString(),
                                                style:
                                                    GoogleFonts.averiaSansLibre(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                "Active",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.teal),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data[index].active
                                                    .toString(),
                                                style:
                                                    GoogleFonts.averiaSansLibre(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                "Recovered",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data[index].recovered
                                                    .toString(),
                                                style:
                                                    GoogleFonts.averiaSansLibre(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                "Deaths",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data[index].death
                                                    .toString(),
                                                style:
                                                    GoogleFonts.averiaSansLibre(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ApiData {
  final String state;
  final String total;
  final String active;
  final String recovered;
  final String death;
  final String newCases;
  final String newDeaths;
  final String deltarecovered;

  ApiData(this.state, this.total, this.active, this.recovered, this.death,
      this.newCases, this.newDeaths, this.deltarecovered);
}

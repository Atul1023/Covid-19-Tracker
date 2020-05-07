import 'package:covid19tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:covid19tracker/pages/searchDistrict.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DistrictStat extends StatefulWidget {
  @override
  _DistrictStatState createState() => _DistrictStatState();
}

class _DistrictStatState extends State<DistrictStat> {
  List indiaDistData;
  List distdata = new List();
  fetchCountryData() async {
    http.Response response = await http
        .get('https://api.covid19india.org/v2/state_district_wise.json');
    print(response);

    if (this.mounted) {
      setState(() {
        indiaDistData = json.decode(response.body);
      });
    }
  }

  void initState() {
    super.initState();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            showSearch(context: context, delegate: SearchDist(indiaDistData));
          },
          child: Text(
            'Search in Districts',
            style: GoogleFonts.specialElite(
              letterSpacing: 4,
              color: kthemeColor,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.searchengin,
                color: kthemeColor,
              ),
              onPressed: () {
                showSearch(
                    context: context, delegate: SearchDist(indiaDistData));
              })
        ],
      ),
      body: indiaDistData == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: kthemeColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  'Dividing by zero...',
                  style: GoogleFonts.kirangHaerang(
                      letterSpacing: 4,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kthemeColor),
                )),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: indiaDistData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(15),
                  //height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: kthemeColor,
                            blurRadius: 8,
                            offset: Offset(3, 4))
                      ]),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            indiaDistData[index]['state'].toString(),
                            style: GoogleFonts.openSans(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text("Disctrict",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple)),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Total Cases",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                indiaDistData[index]['districtData'].length,
                            itemBuilder: (context, index1) {
                              return Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          indiaDistData[index]['districtData']
                                                  [index1]['district']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              indiaDistData[index]
                                                          ['districtData']
                                                      [index1]['confirmed']
                                                  .toString(),
                                              style:
                                                  GoogleFonts.averiaSansLibre(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red[500]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}

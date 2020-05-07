import 'package:covid19tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:covid19tracker/pages/search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CountryList extends StatefulWidget {
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController editingController = TextEditingController();
  List countryData;

  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');

    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.keyboard_arrow_left,
              color: kthemeColor,
            )),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.searchengin,
                color: kthemeColor,
              ),
              onPressed: () {
                showSearch(context: context, delegate: Search(countryData));
              })
        ],
        title: Text(
          "All Countries",
          style: GoogleFonts.openSans(
              color: kthemeColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: countryData == null
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
                Text(
                  'Work, work...',
                  style: GoogleFonts.loveYaLikeASister(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kthemeColor),
                ),
              ],
            )
          : ListView.builder(
              itemCount: countryData == null ? 0 : countryData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(15),
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  countryData[index]['country'],
                                  style: GoogleFonts.openSans(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 30,
                                  child: Image.network(countryData[index]
                                          ['countryInfo']['flag']
                                      .toString()),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 15, top: 10, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      countryData[index]['cases'].toString(),
                                      style: GoogleFonts.averiaSansLibre(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
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
                                      countryData[index]['active'].toString(),
                                      style: GoogleFonts.averiaSansLibre(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
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
                                      countryData[index]['recovered']
                                          .toString(),
                                      style: GoogleFonts.averiaSansLibre(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
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
                                      countryData[index]['deaths'].toString(),
                                      style: GoogleFonts.averiaSansLibre(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
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
              }),
    );
  }
}

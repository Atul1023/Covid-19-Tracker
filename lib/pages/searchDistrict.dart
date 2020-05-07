import 'package:covid19tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchDist extends SearchDelegate {
  final List indiaDistData;

  SearchDist(this.indiaDistData);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggesstionCountry = query.isEmpty
        ? indiaDistData
        : indiaDistData
            .where((element) =>
                element['state'].toString().toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: suggesstionCountry.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(15),
            //height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: kthemeColor, blurRadius: 8, offset: Offset(3, 4))
                ]),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Text(suggesstionCountry.length.toString()),

                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      suggesstionCountry[index]['state'].toString(),
                      style: GoogleFonts.openSans(
                          fontSize: 22, fontWeight: FontWeight.bold),
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
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          suggesstionCountry[index]['districtData'].length,
                      itemBuilder: (context, index1) {
                        return Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    suggesstionCountry[index]['districtData']
                                            [index1]['district']
                                        .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        suggesstionCountry[index]
                                                    ['districtData'][index1]
                                                ['confirmed']
                                            .toString(),
                                        style: GoogleFonts.averiaSansLibre(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
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
        });
  }
}

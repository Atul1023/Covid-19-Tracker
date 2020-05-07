import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

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
        ? countryList
        : countryList
            .where((test) =>
                test['country'].toString().toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
        itemCount: suggesstionCountry.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(15),
            height: 140,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 10, offset: Offset(3, 4))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            suggesstionCountry[index]['country'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 30,
                            child: Image.network(suggesstionCountry[index]
                                    ['countryInfo']['flag']
                                .toString()),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 10, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "Confirmed",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                suggesstionCountry[index]['cases'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Active",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                suggesstionCountry[index]['active'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Recovered",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text(
                                suggesstionCountry[index]['recovered']
                                    .toString(),
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Deaths",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                suggesstionCountry[index]['deaths'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w500),
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
        });
  }
}

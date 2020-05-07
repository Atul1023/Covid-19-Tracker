import 'package:flutter/material.dart';
import 'package:covid19tracker/utils/constants.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:url_launcher/url_launcher.dart';

class Sources extends StatefulWidget {
  @override
  _SourcesState createState() => _SourcesState();
}

class _SourcesState extends State<Sources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.keyboard_arrow_left,
              color: kthemeColor,
            )),
        centerTitle: false,
        title: Text(
          'Sources',
          style: TextStyle(fontSize: 20, color: kthemeColor),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView(
            shrinkWrap: false,
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            children: <Widget>[
              Text(
                'Resourses used for data and other elements in the app',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 10.0,
              ),
              Linkify(
                text: 'API (Global): https://api-corona.herokuapp.com/total',
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                linkStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue.shade800,
                  fontFamily: 'Ubuntu',
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Linkify(
                text:
                    'API (List of Countries): https://corona.lmao.ninja/v2/countries?sort=cases',
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                linkStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue.shade800,
                  fontFamily: 'Ubuntu',
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Linkify(
                text: 'API (India): https://api.covid19india.org',
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                linkStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue.shade800,
                  fontFamily: 'Ubuntu',
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                'Credits',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 10.0,
              ),
              Linkify(
                text: 'Icons and Vectors: https://www.vecteezy.com',
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                linkStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue.shade800,
                  fontFamily: 'Ubuntu',
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

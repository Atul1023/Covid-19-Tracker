import 'package:flutter/material.dart';
import 'package:covid19tracker/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
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
          'About Me',
          style: TextStyle(fontSize: 20, color: kthemeColor),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'images/aboutme.jpg',
                // fit: BoxFit.cover,
                height: 200.0,
              ),
              Text(
                'ATUL RAJ',
                style: GoogleFonts.audiowide(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  'Just another noob',
                  style: GoogleFonts.openSans(fontSize: 14, letterSpacing: 4),
                ),
              ),
              Divider(
                indent: 40,
                endIndent: 40,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.instagram,
                      size: 40,
                    ),
                    onTap: () {
                      launch('https://www.instagram.com/ar_atul07/');
                    },
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.linkedin,
                      size: 40,
                    ),
                    onTap: () {
                      launch('https://www.linkedin.com/in/atul-r-b14bb6167/');
                    },
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.github,
                      size: 40,
                    ),
                    onTap: () {
                      launch('https://github.com/Atul1023');
                    },
                  )
                ],
              )
            ]),
      )),
    );
  }
}

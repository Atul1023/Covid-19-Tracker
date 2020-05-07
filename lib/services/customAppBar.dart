import 'package:flutter/material.dart';
import 'package:covid19tracker/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'images/covidicon.png',
              fit: BoxFit.cover,
              height: 45.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('COVID-19',
                    style: GoogleFonts.openSans(
                        fontSize: 15, color: kthemeColorLite)),
                Text(
                  'Tracker',
                  style: GoogleFonts.openSans(
                      fontSize: 22,
                      color: kthemeColor,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ));
  }
}

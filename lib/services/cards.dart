import 'package:flutter/material.dart';
import 'package:covid19tracker/services/wave.dart';
import 'package:covid19tracker/utils/constants.dart';

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

Widget waveCard(BuildContext context, String name, String f, String total,
    Color fillColor, Color bgColor) {
  String a = f.replaceAll(RegExp(','), '');
  String b = total.replaceAll(RegExp(','), '');
  double c = (((double.parse(a).ceil() / double.parse(b).ceil())) * 100);
  String x = c.toStringAsFixed(2);

  return Container(
    margin: EdgeInsets.only(
      top: 15,
      right: 20,
    ),
    padding: EdgeInsets.only(left: 15),
    height: screenAwareSize(80, context),
    decoration: BoxDecoration(
      color: Bgcolor,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            WaveProgress(
              screenAwareSize(45, context),
              fillColor,
              bgColor,
              67,
            ),
            Text(
              "${x.toString()}",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                  color: kthemeColorLite, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "${f.toString()}",
              style: TextStyle(
                fontSize: 22,
                color: kthemeColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget shadowCard(
    String text, String f, BuildContext context, Color color, Color boxColor) {
  final _media = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(top: 18, right: 12),
    padding: EdgeInsets.all(25),
    height: screenAwareSize(90, context),
    width: _media.width / 2 - 25,
    decoration: BoxDecoration(
        border: Border.all(
          color: boxColor,
        ),
        color: color,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black, offset: Offset(3, 4))
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white60,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${f.toString()}",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}

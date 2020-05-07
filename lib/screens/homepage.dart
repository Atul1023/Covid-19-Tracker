import 'package:covid19tracker/screens/world.dart';
import 'package:covid19tracker/screens/IndiaStats.dart';
import 'package:covid19tracker/screens/districts.dart';
import 'package:covid19tracker/screens/about.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:covid19tracker/services/customAppBar.dart';
import 'package:covid19tracker/services/customizations.dart';
import 'package:covid19tracker/utils/constants.dart';
import 'package:covid19tracker/pages/faq.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int bottomSelectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[World(), IndiaStats(), DistrictStat(), About()],
    );
  }

  @override
  void initState() {
    super.initState();
    World();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Faq()));
          },
          child: Text('FAQs'),
          // mini: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: buildPageView(),
        bottomNavigationBar: BubbleBottomBar(
          hasNotch: true,
          fabLocation: BubbleBottomBarFabLocation.end,
          opacity: 1,
          currentIndex: bottomSelectedIndex,
          onTap: (index) {
            bottomTapped(index);
          },
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                  16)), //border radius doesn't work when the notch is enabled.
          elevation: 8,
          items: <BubbleBottomBarItem>[
            buildBubbleBottomBarItem(
              color: Colors.blue,
              icon: Icons.public,
              iconName: 'World',
            ),
            BubbleBottomBarItem(
                backgroundColor: Colors.grey[200],
                icon: Icon(
                  Icons.outlined_flag,
                  color: Colors.black,
                ),
                activeIcon: GradientMask(
                  child: Icon(
                    Icons.outlined_flag,
                    color: Colors.white,
                  ),
                ),
                title: GradientText(
                  "India",
                  gradient: LinearGradient(colors: [ksaffron, Colors.green]),
                )),
            buildBubbleBottomBarItem(
                color: Colors.purple,
                icon: Icons.location_city,
                iconName: 'Districts'),
            buildBubbleBottomBarItem(
                color: Colors.red, icon: Icons.perm_identity, iconName: 'About')
          ],
        ));
  }

  BubbleBottomBarItem buildBubbleBottomBarItem(
      {Color color, IconData icon, String iconName}) {
    return BubbleBottomBarItem(
        backgroundColor: color,
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        activeIcon: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          iconName,
          style: TextStyle(color: Colors.white),
        ));
  }
}

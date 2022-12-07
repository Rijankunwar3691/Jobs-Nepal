import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jobsnepal/screen/hompage.dart';
import 'package:jobsnepal/screen/search.dart';

import '../screen/addjobs.dart';

class MyCurvedNavigationBar extends StatefulWidget {
  const MyCurvedNavigationBar({Key? key, required indexnum}) : super(key: key);

  @override
  State<MyCurvedNavigationBar> createState() => _MyCurvedNavigationBarState();
}

class _MyCurvedNavigationBarState extends State<MyCurvedNavigationBar> {
  int indexnum = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: indexnum,
      height: 60.0,
      items: const <Widget>[
        Icon(Icons.home, size: 30),
        Icon(Icons.search, size: 30),
        Icon(Icons.add, size: 30),
        Icon(Icons.perm_identity, size: 30),
        Icon(Icons.logout, size: 30),
      ],
      color: Color.fromARGB(255, 179, 208, 212),
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        }
        if (index == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Search(),
              ));
        }
        if (index == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddJobsPage(),
              ));
        }
      },
      letIndexChange: (index) => true,
    );
  }
}

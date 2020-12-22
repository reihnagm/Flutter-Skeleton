import 'package:flutter/material.dart';

import '../../constants/color_palette.dart';
import '../../constants/fab_bottom_app_bar.dart';
import '../page_menu1.dart';
import '../page_menu2.dart';
import '../page_menu3.dart';
import '../page_menu4.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key, this.title}) : super(key: key);

  final String title;
  @override
  State<StatefulWidget> createState() {
    return HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeWidget> {
  bool keyboardOpen = false;
  int _currentIndex = 0;
  final List<Widget> _children = [
    PageMenu1(),
    PageMenu2(),
    PageMenu3(),
    PageMenu4(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.black,
        selectedColor: ColorPalette.btnNewColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: onTabTapped,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          FABBottomAppBarItem(iconData: Icons.event, text: 'Event'),
          FABBottomAppBarItem(iconData: Icons.textsms, text: 'Inbox'),
          FABBottomAppBarItem(iconData: Icons.person, text: 'Profile'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: keyboardOpen ? SizedBox() : _buildFab(context),
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: 'Actions',
      child: Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: ColorPalette.btnNewColor1
      ),
        child: Center(
          child: Icon(
            Icons.warning,
            color: Colors.yellow,
          )
        )
      ),
      elevation: 4.0,
    );
  }
}
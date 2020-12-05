import 'package:flutter/material.dart';
import 'package:whats_is/screens/home.dart';
import 'package:whats_is/screens/status-viewer.dart';

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;

  CustomNavigationBar({this.currentIndex});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  void _onItemTapped(int selectedIndex) {
    if (selectedIndex == widget.currentIndex) {
      return;
    }
    var page;
    if (selectedIndex == 0) {
      page = HomeScreen();
    }
    if (selectedIndex == 1) {
      page = StatusViewerScreen();
    }
    // if (selectedIndex == 2) {
    //   page = WebMessageScreen();
    // }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image_search),
            label: 'Download Status',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.web_sharp),
          //   label: 'WhatsApp Web',
          // ),
        ],
        currentIndex: widget.currentIndex,
        // selectedItemColor: liteSecondaryColor,
        // unselectedItemColor: liteAccentColor,
        // backgroundColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

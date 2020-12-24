import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myboba/utils/list_title.dart';
import 'package:myboba/utils/list_widgets.dart';

class HomepageScreens extends StatefulWidget {
  static const id = '/homepage_screens';

  @override
  _HomepageScreensState createState() => _HomepageScreensState();
}

class _HomepageScreensState extends State<HomepageScreens> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleOptionsAtHomepage.elementAt(_selectedIndex),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: widgetOptionsAtHomepage.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).iconTheme.color,
        unselectedItemColor: Color(0xFFB8B7B4),
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.coffee), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.receipt), label: 'Receipt'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (values) {
          setState(() {
            _selectedIndex = values;
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myboba/utils/customer/list_of_widgets.dart';

class Footer extends StatefulWidget {
  static const id = '/footer';

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptionsAtHomepage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).iconTheme.color,
        unselectedItemColor: Color(0xFFB8B7B4),
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
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

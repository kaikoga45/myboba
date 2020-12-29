import 'package:flutter/material.dart';
import 'package:my_boba_staff/utils/list_of_widgets.dart';

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
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.storage), label: 'Database'),
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

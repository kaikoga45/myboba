import 'package:flutter/material.dart';
import 'package:myboba/utils/staff/list_of_widgets.dart';

class FooterStaff extends StatefulWidget {
  static const id = '/staff_footer';

  @override
  _FooterStaffState createState() => _FooterStaffState();
}

class _FooterStaffState extends State<FooterStaff> {
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

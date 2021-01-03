import 'package:flutter/material.dart';
import 'package:myboba/ui/customer/screens/customer_home_page.dart';
import 'package:myboba/ui/customer/screens/menu.dart';
import 'package:myboba/ui/customer/screens/receipt.dart';
import 'package:myboba/ui/customer/screens/settings.dart';

final List<Widget> widgetOptionsAtHomepage = [
  CustomerHomePage(),
  Menu(),
  Receipt(),
  Settings(),
];

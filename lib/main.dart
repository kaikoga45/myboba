import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myboba/ui/customer/components/error_alert.dart';
import 'package:myboba/ui/customer/components/footer_customer.dart';
import 'package:myboba/ui/customer/screens/detail_receipt.dart';
import 'package:myboba/ui/customer/screens/display_all_menu.dart';
import 'package:myboba/ui/customer/screens/experiment_only.dart';
import 'package:myboba/ui/customer/screens/customer_home_page.dart';
import 'package:myboba/ui/customer/screens/menu.dart';
import 'package:myboba/ui/customer/screens/order.dart';
import 'package:myboba/ui/customer/screens/receipt.dart';
import 'package:myboba/ui/customer/screens/settings.dart';
import 'package:myboba/ui/customer/screens/welcome_screens.dart';
import 'package:myboba/ui/customer/theme/main_theme.dart';
import 'package:myboba/ui/staff/footer_staff.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InitApp());
}

class InitApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeData.primaryColor,
      child: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorAlert();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MyBoba();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class MyBoba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBoba',
      theme: themeData,
      routes: {
        ExperimentOnly.id: (context) => ExperimentOnly(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        FooterCustomer.id: (context) => FooterCustomer(),
        CustomerHomePage.id: (context) => CustomerHomePage(),
        Menu.id: (context) => Menu(),
        Receipt.id: (context) => Receipt(),
        Settings.id: (context) => Settings(),
        DisplayAllMenu.id: (context) => DisplayAllMenu(),
        Order.id: (context) => Order(),
        DetailReceipt.id: (context) => DetailReceipt(),
        FooterStaff.id: (context) => FooterStaff(),
      },
      home: FooterStaff(),
    );
  }
}

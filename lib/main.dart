import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myboba/ui/customer/components/error_alert.dart';
import 'package:myboba/ui/customer/components/footer.dart';
import 'package:myboba/ui/customer/screens/detail_receipt.dart';
import 'package:myboba/ui/customer/screens/display_all_menu.dart';
import 'package:myboba/ui/customer/screens/experiment_only.dart';
import 'package:myboba/ui/customer/screens/homepage.dart';
import 'package:myboba/ui/customer/screens/menu.dart';
import 'package:myboba/ui/customer/screens/order.dart';
import 'package:myboba/ui/customer/screens/receipt.dart';
import 'package:myboba/ui/customer/screens/settings.dart';
import 'package:myboba/ui/customer/screens/welcome_screens.dart';
import 'package:myboba/ui/customer/theme/main_theme.dart';

bool _isLogin = true;
var _initialRoute;

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
    checkUserLogin();
    return MaterialApp(
      title: 'MyBoba',
      theme: themeData,
      initialRoute: _initialRoute,
      routes: {
        ExperimentOnly.id: (context) => ExperimentOnly(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        Footer.id: (context) => Footer(),
        HomePage.id: (context) => HomePage(),
        Menu.id: (context) => Menu(),
        Receipt.id: (context) => Receipt(),
        Settings.id: (context) => Settings(),
        DisplayAllMenu.id: (context) => DisplayAllMenu(),
        Order.id: (context) => Order(),
        DetailReceipt.id: (context) => DetailReceipt(),
      },
    );
  }
}

void checkUserLogin() {
  // TODO : Adding firebase auth function to check user login
  if (!_isLogin) {
    _initialRoute = WelcomeScreen.id;
  } else {
    _initialRoute = Footer.id;
  }
}

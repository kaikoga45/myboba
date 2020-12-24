import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myboba/ui/components/error_alert.dart';
import 'package:myboba/ui/screens/homepage_screens.dart';
import 'package:myboba/ui/screens/welcome_screens.dart';
import 'package:myboba/ui/theme/main_theme.dart';

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
        WelcomeScreen.id: (context) => WelcomeScreen(),
        HomepageScreens.id: (context) => HomepageScreens(),
      },
    );
  }
}

void checkUserLogin() {
  // TODO : Adding firebase auth function to check user login
  if (!_isLogin) {
    _initialRoute = WelcomeScreen.id;
  } else {
    _initialRoute = HomepageScreens.id;
  }
}

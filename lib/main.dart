import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myboba/ui/screens/homepage_screens.dart';
import 'package:myboba/ui/screens/welcome_screens.dart';
import 'package:myboba/ui/theme/main_theme.dart';

bool isLogin = true;
var initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  checkUserLogin();
  runApp(MyBoba());
}

class MyBoba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBoba',
      theme: themeData,
      initialRoute: initialRoute,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        HomepageScreens.id: (context) => HomepageScreens(),
      },
    );
  }
}

void checkUserLogin() {
  // TODO : Adding firebase auth function to check user login
  if (!isLogin) {
    initialRoute = WelcomeScreen.id;
  } else {
    initialRoute = HomepageScreens.id;
  }
}

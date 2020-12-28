import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/authentication.dart';
import 'package:myboba/ui/components/error_alert.dart';
import 'package:myboba/ui/components/footer.dart';
import 'package:myboba/ui/screens/homepage.dart';
import 'package:myboba/ui/screens/menu.dart';
import 'package:myboba/ui/screens/receipt.dart';
import 'package:myboba/ui/screens/settings.dart';
import 'package:myboba/ui/screens/sign_in.dart';
import 'package:myboba/ui/screens/sign_up.dart';
import 'package:myboba/ui/screens/welcome_screens.dart';
import 'package:myboba/ui/theme/main_theme.dart';

//bool _isLogin = false;
//var _initialRoute;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
            //return MyBoba();
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

// Stream user to check user state ()
class StreamUser extends StatelessWidget {
  const StreamUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthHelper.auth.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return ErrorAlert();
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        //saat user sign_in / sign_up
        if(snapshot.hasData){
          
          // buat ngeluarin (pop) push tampilan sign_in / sign_up nya
          // bukan best practicenya, lebih ke maksa navigatorKeynya ni
          // coba cari lain buat routing authentication nya, aku cari-cari disuruh make class middleware 
          // But at least it's work :')
          if(navigatorKey.currentState.canPop() == true){
            navigatorKey.currentState.pop();
          }
          
          return Footer();
        }
        //kebalikannya
        return WelcomeScreen();
      },
    );
  }
}


class MyBoba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //checkUserLogin();
    //_initialRoute = Footer.id;
    return MaterialApp(
      title: 'MyBoba',
      theme: themeData,
      navigatorKey: navigatorKey,
      //initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        Footer.id: (context) => Footer(),
        HomePage.id: (context) => HomePage(),
        Menu.id: (context) => Menu(),
        Receipt.id: (context) => Receipt(),
        Settings.id: (context) => Settings(),
      },
      home: StreamUser(),
      //home: (AuthHelper.auth.currentUser == null)? WelcomeScreen() : Footer(),
      //home: (_initialRoute == Footer.id)? Footer() : WelcomeScreen(),
    );
  }
}
/*
void checkUserLogin() {
  // TODO : Adding firebase auth function to check user login

  //if (!_isLogin) {
  AuthHelper.auth.authStateChanges().listen((user){
    if(user == null){
      print("Ga log in");
      _initialRoute = WelcomeScreen.id;
      print(_initialRoute);
    } else {
      print("log in");
      _initialroute = footer.id;
      print(_initialroute);

    }
  }); 
}
*/

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
import 'package:myboba/ui/screens/forgot_password.dart';
import 'package:myboba/ui/screens/waiting_screen.dart';
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

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        //saat user sign_in / sign_up
        if(snapshot.hasData){ 
          // check user email verification
          return CheckEmailVerification();
        }

        // appear while there arn't user sign in / sign up to the system
        return WelcomeScreen();
      },
    );
  }
}

// stream user to check the changes of users data on firebase server
class CheckEmailVerification extends StatelessWidget {
  const CheckEmailVerification({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthHelper.auth.userChanges(),
      builder: (context, snapshot){

        if(snapshot.hasData){
          
          //send email verification if email didn't verified
          if(AuthHelper.auth.currentUser.emailVerified == false){
            AuthHelper().sendEmailVerif();
            AuthHelper.auth.currentUser.reload();

            // Verif waiting screens
            return WaitingScreens();
          }

        } 
        // return to home
        return Footer();
      },
    );
  }
}


class MyBoba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBoba',
      theme: themeData,
      navigatorKey: navigatorKey,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        ForgotPassword.id: (context) => ForgotPassword(),
        Footer.id: (context) => Footer(),
        HomePage.id: (context) => HomePage(),
        Menu.id: (context) => Menu(),
        Receipt.id: (context) => Receipt(),
        Settings.id: (context) => Settings(),
      },
      home: StreamUser(),
    );
  }
}

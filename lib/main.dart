import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase_authentication/authentication.dart';
import 'package:myboba/ui/customer/components/error_alert.dart';
import 'package:myboba/ui/customer/components/footer_customer.dart';
import 'package:myboba/ui/customer/screens/detail_receipt.dart';
import 'package:myboba/ui/customer/screens/display_all_menu.dart';
import 'package:myboba/ui/customer/screens/customer_home_page.dart';
import 'package:myboba/ui/customer/screens/menu.dart';
import 'package:myboba/ui/customer/screens/order.dart';
import 'package:myboba/ui/customer/screens/receipt.dart';
import 'package:myboba/ui/customer/screens/settings.dart';
import 'package:myboba/ui/login/screens/welcome_screens.dart';
import 'package:myboba/ui/customer/theme/main_theme.dart';
import 'package:myboba/ui/login/screens/forgot_password.dart';
import 'package:myboba/ui/login/screens/sign_in.dart';
import 'package:myboba/ui/login/screens/sign_up.dart';
import 'package:myboba/ui/login/screens/waiting_screen.dart';
import 'package:myboba/ui/staff/footer_staff.dart';

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
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        //saat user sign_in / sign_up
        if (snapshot.hasData) {
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
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //send email verification if email didn't verified
          if (AuthHelper.auth.currentUser.emailVerified == false) {
            AuthHelper().sendEmailVerif();
            AuthHelper.auth.currentUser.reload();
            // Verify waiting screens
            return WaitingScreens();
          }
        }
        final _authHelper = AuthHelper.instance;
        final User user = AuthHelper.auth.currentUser;
        return FutureBuilder<bool>(
          future: _authHelper.checkUserType(user.uid),
          builder: (context, isCustomer) {
            if (isCustomer.data == true) {
              return FooterCustomer();
            } else if (isCustomer.data == false) {
              return FooterStaff();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}

class MyBoba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyBoba',
      theme: themeData,
      navigatorKey: navigatorKey,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        ForgotPassword.id: (context) => ForgotPassword(),
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
      home: StreamUser(),
    );
  }
}

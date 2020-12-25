import 'package:flutter/material.dart';
import 'package:myboba/ui/screens/sign_up.dart';
import 'package:myboba/ui/screens/sign_in.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);
  static const String id = '/welcome_screen';

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: (heightScreen * 0.14)),
            _heading(context),
            SizedBox(height: heightScreen * 0.078),
            _picture(),
            SizedBox(height: heightScreen * 0.202),
            _buttonSignInAndSignUp(context),
          ],
        ),
      ),
    );
  }

  Widget _heading(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 100,
        right: 100,
      ),
      child: Text(
        "Save time ordering beverage with MyBoba",
        style: Theme.of(context).textTheme.headline5.copyWith(
              fontWeight: FontWeight.w900,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _picture() {
    return Container(
      width: 278,
      height: 278,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFEDE2CF),
        image: DecorationImage(
          image: AssetImage("assets/img/welcome_screen_illustration.jpg"),
        ),
      ),
    );
  }

  Widget _buttonSignInAndSignUp(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 23),
          child: FlatButton(
            child: Text("SIGN UP"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              );
            },
            textColor: Colors.white,
            color: Color(0xFFC99542),
            padding: EdgeInsets.all(20),
            minWidth: widthScreen,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Already have an account? ",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
                },
                child: Text("Sign In"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myboba/main.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key key}) : super(key: key);
  static const String id = '/welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              Expanded(child: _heading(context)),
              Expanded(child: _picture()),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buttonSignUp(context),
                      _buttonSignIn(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heading(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Save time ordering beverage with MyBoba",
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ],
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

  Widget _buttonSignUp(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 23),
      child: FlatButton(
        child: Text("SIGN UP"),
        onPressed: () {
          Navigator.pushNamed(context, "/signup");
        },
        textColor: Colors.white,
        color: Color(0xFFC99542),
        padding: EdgeInsets.all(20),
        minWidth: widthScreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  Widget _buttonSignIn(BuildContext context) {
    return Row(
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
              Navigator.pushNamed(context, "/signin");
            },
            child: Text("Sign In"),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);
  static const String id = '/welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
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
            ),
            Container(
              width: 278,
              height: 278,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEDE2CF),
                image: DecorationImage(
                  image:
                      AssetImage("assets/img/welcome_screen_illustration.jpg"),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  textColor: Colors.white,
                  color: Color(0xFFC99542),
                  padding: EdgeInsets.all(20),
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Text("SIGN UP"),
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
                      onTap: (){
                        
                      },
                      child: Text("Sign In"),
                    ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


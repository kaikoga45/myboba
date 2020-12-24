import 'package:flutter/material.dart';
import 'package:myboba/ui/screens/welcome_screens.dart';
import 'package:myboba/ui/theme/main_theme.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = '/welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 100,
                right: 100,
              ),
              child: Text("Save time ordering beverage with MyBoba",
                style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 100,
            ),

          ],
        ),
      ),
    );
  }
}

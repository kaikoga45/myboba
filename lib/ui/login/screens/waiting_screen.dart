import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase_authentication/authentication.dart';
import 'package:myboba/ui/login/screens/new_password.dart';

class WaitingScreens extends StatelessWidget {
  const WaitingScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreens = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _picture(),
            SizedBox(height: 0.032 * heightScreens),
            _heading(context),
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
        "Please check your email to proceed the request",
        style: Theme.of(context).textTheme.headline5!.copyWith(
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
}

class StreamGetOob extends StatelessWidget {
  final String? email;
  StreamGetOob({this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthHelper().getOobData(email),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          QuerySnapshot? data = snapshot.data as QuerySnapshot?;
          Map<String, dynamic>? output;
          data?.docs.forEach((item) {
            output = item.data() as Map<String, dynamic>?;
            output!["id"] = item.id;
          });
          print(output);
          if ((data?.docs.length ?? 0) > 0) {
            return NewPassword(oobcode: output);
          }
        }

        return WaitingScreens();
      },
    );
  }
}

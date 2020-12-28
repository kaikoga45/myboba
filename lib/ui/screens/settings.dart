import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/authentication.dart';

class Settings extends StatelessWidget {
  static const String id = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SETTINGS',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.pinkAccent,
              height: 100,
            ),
            Center(
              child: FlatButton(
                child: Text("Sign Out"),
                onPressed: (){
                  AuthHelper.auth.signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

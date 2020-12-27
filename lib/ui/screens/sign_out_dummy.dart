import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/authentication.dart';

class SignOut extends StatelessWidget {
  const SignOut({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text("Sign Out"),
        onPressed: (){
          //print(AuthHelper.auth.currentUser);
          AuthHelper.auth.signOut();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/authentication.dart';
import 'package:myboba/ui/components/inputField_myboba.dart';
import 'package:myboba/main.dart';

class NewPassword extends StatefulWidget {
  static const String id = '/verificationcode';
  final Map<String, dynamic> oobcode;
  NewPassword({Key key, this.oobcode}) : super(key: key);

  @override
  _NewPassword createState() => _NewPassword(oobcode: this.oobcode);
}

class _NewPassword extends State<NewPassword> {
  String password;
  final Map<String, dynamic> oobcode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _NewPassword({this.oobcode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 23, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Fill with your new password",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              passwordField(),
              confirmPasswordField(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 65, left: 23, right: 23),
        child: submitButton(context),
      ),
    );
  }

  Widget passwordField() {
    return InputField(
      obscureText: true,
      hintText: "Password",
      icon: Icons.lock,
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
    );
  }

  Widget confirmPasswordField() {
    return InputField(
      obscureText: true,
      hintText: "Confirm Password",
      icon: Icons.lock,
      validator: (value) {
        if (value != password) {
          return "Password you entered did not match, please try again";
        }
        return null;
      },
    );
  }

  Widget submitButton(BuildContext context) {
    return FlatButton(
      child: Text("SEND"),
      onPressed: () async {
        if (_formKey.currentState.validate() == true) {

          String output = await AuthHelper(
            password: this.password,
            oobCode: this.oobcode["oob"],
          ).resetPassword();

          print(output);

          if (output == "Success") {
            AuthHelper().deleteUnusedOob(oobcode["id"]);
            navigatorKey.currentState.pop(context);
          }

        }
      },
      textColor: Colors.white,
      color: Color(0xFFC99542),
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    );
  }
}

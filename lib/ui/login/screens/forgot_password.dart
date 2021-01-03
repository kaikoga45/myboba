import 'package:flutter/material.dart';
import 'package:myboba/services/firebase_authentication/authentication.dart';
import 'package:myboba/ui/login/components/inputField_myboba.dart';
import 'package:myboba/ui/login/screens/waiting_screen.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = '/forgot_password';
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPassword createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  String email;
  String password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              Text(
                "Fill the blank spot with your email. We will send you a verification code to your email",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              emailField(),
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

  Widget emailField() {
    return InputField(
      hintText: "Email",
      icon: Icons.mail,
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      validator: (value) {
        if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value) ==
            false) {
          return "Please enter a valid email address";
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
          AuthHelper.auth.sendPasswordResetEmail(email: email);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StreamGetOob(email: email)),
          );
        }
      },
      textColor: Colors.white,
      color: Color(0xFFC99542),
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    );
  }
}

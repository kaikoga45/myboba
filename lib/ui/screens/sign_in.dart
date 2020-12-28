import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/authentication.dart';
import 'package:myboba/ui/components/inputField_myboba.dart';
import 'package:myboba/main.dart';

class SignIn extends StatefulWidget {
  static const String id = '/signin';
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email;
  String password;

  String _errorMessage;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign IN ",
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
              emailField(),
              passwordField(),
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
        if (_errorMessage == "invalid-email") {
          return "Please enter a valid email address";
        }
        if (_errorMessage == "user-not-found") {
          return "Sorry, We couldn't find your account";
        }
        return null;
      },
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
      validator: (value) {
        if (_errorMessage == "wrong-password") {
          return "Password you entered is incorrect";
        }
        return null;
      },
    );
  }

  Widget submitButton(BuildContext context) {
    return FlatButton(
      child: Text("SIGN IN"),
      onPressed: () async {
        //call signIn method at authentication.dart
        final Map<String, dynamic> output = await AuthHelper(
          email: this.email,
          password: this.password,
        ).signIn();

        print(output);
        if (output["valid"] == false){
          //print(Navigator.defaultRouteName);
          //Navigator.pop(homepage_context.currentState.context);
          //navigatorKey.currentState.pushNamed('/welcome_screens');
          //print(AuthHelper.auth.currentUser){
          _errorMessage = output["message"];
          _formKey.currentState.validate();
        }
      },
      textColor: Colors.white,
      color: Color(0xFFC99542),
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    );
  }
}

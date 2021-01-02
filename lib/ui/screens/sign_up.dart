import 'package:flutter/material.dart';
import 'package:myboba/main.dart';
import 'package:myboba/services/firebase/authentication.dart';
import 'package:myboba/ui/components/inputField_myboba.dart';

class SignUp extends StatefulWidget {
  static const String id = '/signup';
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String username;
  String password;
  String email;

  String _errorMessage;
  final _formKey = GlobalKey<FormState>();
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign UP ",
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
              nameField(),
              emailField(),
              passwordField(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 65, left: 23, right: 23),
        child: submitButton(),
      ),
    );
  }

  Widget nameField() {
    return InputField(
      hintText: "Username",
      icon: Icons.perm_identity,
      onChanged: (value) {
        setState(() {
          username = value;
        });
      },
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
        if (_errorMessage == "email-already-in-use") {
          return "Email already registered";
        }
        if (_errorMessage == "invalid-email") {
          return "Please enter a valid email address";
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
        if (_errorMessage == "weak-password") {
          return "Please choose a password that's harder to guess";
        }
        return null;
      },
    );
  }

  Widget confirmPasswordField() {
    return InputField(
      obscureText: true,
      hintText: "Confirm Password",
      icon: Icons.lock,
    );
  }

  Widget submitButton() {
    return FlatButton(
      child: Text("SIGN UP"),
      onPressed: () async {

        //call sign up method at authentication.dart
        final Map<String, dynamic> output = await AuthHelper(
          username: this.username,
          email: this.email,
          password: this.password,
        ).signUp();
        

        if (output["valid"] == true){
          navigatorKey.currentState.pop();
        } else {
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
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/authentication.dart';
import 'package:myboba/ui/screens/welcome_screens.dart';
import 'package:myboba/ui/screens/sign_out_dummy.dart';
import 'package:myboba/ui/components/inputField_myboba.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
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
      obscureText: false,
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
      obscureText: false,
      hintText: "Email",
      icon: Icons.mail,
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      validator: (value) {
        if (_errorMessage == "email-already-in-use") {
          return "Email alreay registered";
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
        final Map<String, dynamic> output = await AuthHelper(
          username: this.username,
          email: this.email,
          password: this.password,
        ).signUp();

        if (output["valid"]) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        } else {
          _errorMessage = output["message"];
          print(output);
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

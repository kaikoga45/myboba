import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myboba/main.dart';
import 'package:myboba/services/firebase_authentication/authentication.dart';
import 'package:myboba/ui/login/components/inputField_myboba.dart';
import 'package:myboba/ui/login/screens/forgot_password.dart';

bool _loginProgress = false;

class SignIn extends StatefulWidget {
  static const String id = '/sign_in';
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email;
  String password;

  String _errorMessage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loginProgress,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "SIGN IN ",
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
                forgotPasswordButton(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 65, left: 23, right: 23),
          child: TextButton(
            child: Text("SIGN IN"),
            onPressed: () async {
              setState(() {
                _loginProgress = !_loginProgress;
              });
              //call signIn method at authentication.dart
              final Map<String, dynamic> output = await AuthHelper(
                email: this.email,
                password: this.password,
              ).signIn();

              setState(() {
                _loginProgress = !_loginProgress;
              });

              print(output);
              if (output["valid"] == true) {
                navigatorKey.currentState.pop();
              } else {
                _errorMessage = output["message"];
                _formKey.currentState.validate();
              }
            },
            style: TextButton.styleFrom(
              textStyle: TextStyle(color: Colors.white),
              backgroundColor: Color(0xFFC99542),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              padding: EdgeInsets.all(20),
            ),
          ),
        ),
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

  Widget forgotPasswordButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: InkWell(
        child: Text(
          "Forgot your password?",
          style: Theme.of(context).textTheme.subtitle2,
        ),
        onTap: () {
          Navigator.pushNamed(context, ForgotPassword.id);
        },
      ),
    );
  }
}

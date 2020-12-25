import 'package:flutter/material.dart';
import 'package:myboba/ui/screens/welcome_screens.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{
  @override
  String text;

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
              confirmPasswordField(),
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFFAFAFA),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 20, left: 10),
            child: Icon(
              Icons.perm_identity,
              color: Color(0xFFC99542),
              size: 40,
            ),
          ),
          hintText: "Nickname",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF757575),
          fontWeight: FontWeight.w700,
        ),
        //controller: ,
        //validator: () {},
      ),
    );
  }

  Widget emailField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFFAFAFA),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 20, left: 10),
            child: Icon(
              Icons.mail,
              color: Color(0xFFC99542),
              size: 40,
            ),
          ),
          hintText: "Email",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF757575),
          fontWeight: FontWeight.w700,
        ),
        //controller: ,
        onSaved: (value) {
          setState(() {
            text = value;
          });
        },
        validator: (value) {
          if (value.contains('@')) {
            return null;
          } else {
            return "Email tidak valid";
          }
        },
      ),
    );
  }

  Widget passwordField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFFAFAFA),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 20, left: 10),
            child: Icon(
              Icons.lock,
              color: Color(0xFFC99542),
              size: 40,
            ),
          ),
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF757575),
          fontWeight: FontWeight.w700,
        ),
        //controller: ,
        //validator: ,
      ),
    );
  }

  Widget confirmPasswordField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFFAFAFA),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 20, left: 10),
            child: Icon(
              Icons.lock,
              color: Color(0xFFC99542),
              size: 40,
            ),
          ),
          hintText: "Confirm Password",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF757575),
          fontWeight: FontWeight.w700,
        ),
        //controller: ,
        //validator: ,
      ),
    );
  }

  Widget submitButton() {
    return FlatButton(
      child: Text("SIGN UP"),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
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

import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  static final auth = FirebaseAuth.instance;

  AuthHelper._privateConstructor();
  static final AuthHelper instance = AuthHelper._privateConstructor();

  //Temp
  String customerId = '1';
}

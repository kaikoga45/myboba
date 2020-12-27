import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthHelper {
  String username;
  final String email;
  final String password;
  static final auth = FirebaseAuth.instance;

  AuthHelper({
    this.username,
    this.email,
    this.password,
  });

  Stream<User> get authStateChanges => auth.authStateChanges();

  Future<Map<String, dynamic>> signUp() async {
    try {
      UserCredential data = await auth.createUserWithEmailAndPassword(
        email: this.email,
        password: this.password,
      );
      User user = data.user;
      user.updateProfile(displayName: username);

      return {
        "valid": true,
        "message": "Sign Up Success",
      };
    } on FirebaseAuthException catch (error) {
      return {
        "valid": false,
        "message": error.code,
      };
    }
  }

  Future<Map<String, dynamic>> signIn() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: this.email,
        password: this.password,
      );

      return {
        "valid": true,
        "message": "Sign In Success",
      };
    } on FirebaseAuthException catch (error) {
      return {
        "valid": false,
        "message": error.code,
      };
    }
  }

  Future<String> signOut() async {
    try {
      auth.signOut();
      return "Sign Out Success";
    } on FirebaseAuthException catch (error) {
      return error.code;
    } catch (e) {
      rethrow;
    }
  }
}

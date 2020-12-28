import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthHelper {
  String username;
  final String email;
  final String password;
  static final auth = FirebaseAuth.instance;
  final CollectionReference _users_firestore = FirebaseFirestore.instance.collection('users');

  AuthHelper({
    this.username,
    this.email,
    this.password,
  });

  Stream<User> get authStateChanges => auth.authStateChanges();

  Future <Map<String, dynamic>> signUp() async {
    try {
      UserCredential data = await auth.createUserWithEmailAndPassword(
        email: this.email,
        password: this.password,
      );
      
      // it save username at Displayname 
      User user = data.user;
      user.updateProfile(displayName: username);
      
      // it save username at firestore 
      _users_firestore.add({
        'source_UID': user.uid,
        'username': username,
      });

      return {
        "value": true,
        "message": "Sign In Success"
      };
    } on FirebaseAuthException catch (error) {
      return {
        "value": false,
        "message": error.code,
      };
    }catch (error){
      return {
        "value": false,
        "message": error,
      };
    }
  }

  Future <Map<String, dynamic>> signIn() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: this.email,
        password: this.password,
      );

      return {
        "value": true,
        "message": "Sign In Success",
      };
    } on FirebaseAuthException catch (error) {
      return {
        "value": false,
        "message": error.code,
      };
    }
  }

  Future<Map<String, dynamic>> signOut() async {
    try {
      auth.signOut();
      return {
        "value": true,
        "message": "Sign Out Success",
      };
    } on FirebaseAuthException catch (error) {
      return {
        "value": true,
        "message": error.code,
      };
    } catch (e) {
      rethrow;
    }
  }
}

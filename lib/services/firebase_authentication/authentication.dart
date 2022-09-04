import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthHelper {
  String username;
  final String email;
  final String password;

  final String oobCode;

  final _firestoreApi = FirebaseFirestore.instance;

  static final AuthHelper instance = AuthHelper();

  static final auth = FirebaseAuth.instance;

  final _usersStore = FirebaseFirestore.instance.collection("users");
  final _oobCodeTemp = FirebaseFirestore.instance.collection("oob_code_temp");

  AuthHelper({
    this.username,
    this.email,
    this.password,
    this.oobCode,
  });

  Stream<User> get authStateChanges => auth.authStateChanges();

  Future<String> resetPassword() async {
    try {
      auth.confirmPasswordReset(
        code: this.oobCode,
        newPassword: this.password,
      );

      return "Success";
    } catch (error) {
      return error.code;
    }
  }

  Stream<QuerySnapshot> getOobData(String mail) {
    return _oobCodeTemp.where("email", isEqualTo: mail).snapshots();
  }

  Future<String> deleteUnusedOob(String id) async {
    try {
      await _oobCodeTemp.doc(id).delete();

      return "Success";
    } catch (error) {
      return error;
    }
  }

  Future<String> sendEmailVerif() async {
    try {
      await auth.currentUser.sendEmailVerification();

      return "Success";
    } catch (error) {
      return error.code;
    }
  }

  Future<Map<String, dynamic>> signUp() async {
    try {
      UserCredential data = await auth.createUserWithEmailAndPassword(
        email: this.email,
        password: this.password,
      );
      User user = data.user;
      user.updateDisplayName(username);

      _usersStore.add({
        "source_UID": user.uid,
        "username": username,
      });

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

  Future<bool> checkUserType(String uid) async {
    bool isCustomer = true;

    try {
      isCustomer = await _firestoreApi
          .collection('users')
          .where('source_UID', isEqualTo: uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      }).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      print(e);
    }

    return isCustomer;
  }

  String getUserID() {
    return auth.currentUser.uid;
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthHelper {
  String username;
  final String email;
  final String password;

  // for Reset Password
  final String oobCode;

  static final auth = FirebaseAuth.instance;
  final _users_store = FirebaseFirestore.instance.collection("users");
  final _oob_code_temp = FirebaseFirestore.instance.collection("oob_code_temp");

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
    return _oob_code_temp.where("email", isEqualTo: mail).snapshots();
  }

  Future<String> deleteUnusedOob(String id) async {
    try{
      
      await _oob_code_temp.doc(id).delete();
      
      return "Success";
    }catch(error){
      return error;
    }
  }

/*
  Stream<Map<String, dynamic>> getOobData() async* {
    Map<String, dynamic> output;
    List<QueryDocumentSnapshot> item;
    bool _stopChangeData = false;

    StreamSubscription stream = _oob_code_temp
        .where("email", isEqualTo: this.email)
        .snapshots()
        .listen((data) {
      // get list data QueryDocumentSnapshot
      item = data.docs;
      print(item.length);
      print(data.docs[0].id);
      //print(data.docs[0].data());

      if (_stopChangeData == false && item.length > 0) {
        // save map data of index 0 to variable output
        output = item[0].data();
        output["valid"] = true;
        return output;
        //_stopChangeData = true;
        // delete data in database
        //_oob_code_temp.doc(item[0].id).delete();
      }
    });
  }
*/

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
      user.updateProfile(displayName: username);

      _users_store.add({
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
}

import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;


  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.setSettings(appVerificationDisabledForTesting: true);
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password)

      .catchError( (e) {
        log("catchError|error: $e");

        if (e is FirebaseAuthException) {
          // Firebase Authentication error
          if (e.code == 'user-not-found') {
            // Handle user not found error
          } else if (e.code == 'wrong-password') {
            // Handle wrong password error
          } else {
            // Handle other Firebase Authentication errors
          }
        } else {
          // Handle non-Firebase Authentication errors
          print('FirebaseAuthException|else|An unexpected error occurred: $e');
        }

        throw e; //Exception("Something went wrong!");
      });
      return cred.user;
    } catch (e, stackTrace) {
      log("Try is caught error: $e");
      log("Stack Trace: $stackTrace");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_track/service/const_varible.dart';

class AuthOperation {
  //sign
  Future<String> register(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return "succses";
    } on FirebaseAuthException catch (e) {
      log("enter heeeeeeeeeeeeeeeer");
      log(e.code);
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'The account already exists for that email.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-not-found':
          return 'User not found.';
        case 'wrong-password':
          return 'Wrong password.';
        case 'too-many-requests':
          return 'Too many requests. Please try again later.';
        case 'invalid-credential':
          return 'Wrong password.';
        case 'operation-not-allowed':
          return 'Operation not allowed.';
        case 'network-request-failed':
          return 'Network request failed. Please check your internet connection.';
        default:
          return 'An unexpected error occurred. Please try again later.';
      }
    } catch (e) {
      return e.toString();
    }
  }

//sign in
  Future<String> signIn(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      log("wwwwwwwwwwwwwwwwww");
      log("Error message: ${e.message}");

      log(e.code);
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'The account already exists for that email.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-not-found':
          return 'User not found.';
        case 'wrong-password':
          return 'Wrong password.';
        case 'invalid-credential':
          return 'Please try again your emial or Password not correct.';
        case 'too-many-requests':
          return 'Too many requests. Please try again later.';
        case 'operation-not-allowed':
          return 'Operation not allowed.';
        case 'network-request-failed':
          return 'Network request failed. Please check your internet connection.';
        default:
          return 'An unexpected error occurred. Please try again later.';
      }
    } catch (e) {
      return e.toString();
    }
  }

//forget password
  Future<String> forgetPassword(String emailAddress) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ' No user found for that email.';
      }
    } catch (e) {
      return e.toString();
    }
    return 'null';
  }

//get user data
  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    String userId = user!.uid;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user_info')
        .doc(userId)
        .get();

    if (userDoc.exists) {
      userName = userDoc.get('name');
      userEmial = userDoc.get('email');
    }
  }

  Future<bool> verfcationEmial(
      {required String newEmail, required String password}) async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      final credential = EmailAuthProvider.credential(
        email: userEmial!,
        password: password,
      );
      await user!.reauthenticateWithCredential(credential); // Re-authenticate
      await user.verifyBeforeUpdateEmail(newEmail);
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

//udate user data
  Future<String> updateUserData({
    required String name,
    required String newEmail,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;

    try {
      await user.reload();
      user = FirebaseAuth.instance.currentUser;

      if (user!.emailVerified) {
        // Update both displayName and Firestore data after email verification
        await FirebaseFirestore.instance
            .collection('user_info')
            .doc(userId)
            .update({
          'email': newEmail,
          'name': name,
        });
        log("succcseeesssss");
        return "success"; // Return success if everything goes well
      } else {
        return "Verification"; // User hasn't verified email yet
      }
    } catch (e) {
      log(e.toString());
      return "unsuccess";
    }
  }

//change password

//signout
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

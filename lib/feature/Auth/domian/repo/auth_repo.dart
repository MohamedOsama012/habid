import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<String> register(String emailAddress, String password);
  Future<String> signIn(String emailAddress, String password);
  Future<String> forgetPassword(String emailAddress);
  Future<void> getUserData();
  Future<String> updateUserData({required String name, required String newEmail});
  Future<UserCredential> signInWithGoogle();
}
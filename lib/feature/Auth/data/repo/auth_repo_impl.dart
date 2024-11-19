// Implement the AuthService in AuthOperation

import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_track/feature/Auth/data/data_source/auth_data_source.dart';
import 'package:habit_track/feature/Auth/domian/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthDataSource authDataSource;
  AuthRepoImpl({required this.authDataSource});
  @override
  Future<String> forgetPassword(String emailAddress) {
    return authDataSource.forgetPassword(emailAddress);
  }

  @override
  Future<void> getUserData() {
    return authDataSource.getUserData();
  }

  @override
  Future<String> register(String emailAddress, String password) {
    return authDataSource.register(emailAddress, password);
  }

  @override
  Future<String> signIn(String emailAddress, String password) {
    return authDataSource.signIn(emailAddress, password);
  }

  @override
  Future<UserCredential> signInWithGoogle() {
    return authDataSource.signInWithGoogle();
  }

  @override
  Future<String> updateUserData(
      {required String name, required String newEmail}) {
    return authDataSource.updateUserData(name: name, newEmail: newEmail);
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_track/feature/Auth/data/auth_operation.dart';
import 'package:habit_track/service/cash_helper.dart';
import 'package:habit_track/service/const_varible.dart';
import 'package:habit_track/service/firebase_service.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthOperation auth = AuthOperation(); //register and login
  FirebaseService firebaseService = FirebaseService(); //set date in firebase

  //!register
  Future<void> register(
      {required String emial,
      required String password,
      required String name}) async {
    emit(AuthLoading());
    try {
      var result = await auth.register(emial, password);
      if (result == "succses") {
        String idUser = firebaseService.getFirebaseUserId();
        await setAuthUserData(email: emial, name: name, id: idUser);
        emit(AuthRegisterSucsses());
      } else {
        emit(AuthFaileRegister(errorMassage: result));
      }
    } on Exception catch (e) {
      emit(AuthFaileRegister(errorMassage: e.toString()));
    }
  }

  //!login
  Future<void> logIN({required String emial, required String password}) async {
    emit(AuthLoading());
    try {
      var result = await auth.signIn(emial, password);

      if (result == "success") {
        emit(AuthLogInSucsses());
      } else {
        emit(AuthFaileLogin(errorMassage: result));
      }
    } on Exception catch (e) {
      emit(AuthFaileLogin(errorMassage: e.toString()));
    }
  }

//!set user data
  Future<void> setAuthUserData(
      {required String email, required String name, required String id}) async {
    try {
      var userData = {
        'email': email,
        'name': name,
        "id": id,
      };
      await firebaseService.setData(
          collection: 'user_info', data: userData, documentId: id);
    } catch (e) {
      log('Error storing user data: $e');
    }
  }

//update user data
  void updateUserData({
    required String name,
    required String email,
  }) async {
    emit(UpdateUserDataLooding());
    if (name != userName || email != userEmial) {
      try {
        final result = await auth.updateUserData(
          name: name,
          newEmail: email,
        );
        if (result == "success") {
          userName = name;
          userEmial = email;
          emit(UpdateUserDataSuccsess());
        } else if (result == 'Verification') {
          emit(UpdateUserDataFail(errorMessage: "check Your emial"));
        } else {
          emit(UpdateUserDataFail(errorMessage: "error"));
        }
      } on Exception catch (e) {
        emit(UpdateUserDataFail(errorMessage: e.toString()));
      }
    } else {
      emit(UpdateUserDataFail(errorMessage: "Same Data Can't Update"));
    }
  }

  verficationEmailFun(
      {required String newEmail,
      required String password,
      required String name}) async {
    emit(UserVerificationLoad()); // Start loading
    User? user = FirebaseAuth.instance.currentUser;

    try {
      await user!.reload();
      user = FirebaseAuth.instance.currentUser;
      if (!user!.emailVerified) {
        final credential = EmailAuthProvider.credential(
          email: userEmial!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);

        await user.verifyBeforeUpdateEmail(newEmail);
        emit(UserVerificatiSuccses());
      } else {
        updateUserData(email: newEmail, name: name);
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: newEmail, password: password);
      verficationEmailFun(name: name, newEmail: newEmail, password: password);
    }
  }

//forget password
  Future<void> forgetPassword({required String emial}) async {
    emit(AuthForgetPasswordLoad());
    try {
      var result = await auth.forgetPassword(emial);

      if (result == "success") {
        emit(AuthForgetPasswordSucsses());
      } else {
        emit(AuthForgetPasswordFail(errorMassage: result));
      }
    } on Exception catch (e) {
      emit(AuthForgetPasswordFail(errorMassage: e.toString()));
    }
  }

//logout
  Future<void> logOut() async {
    try {
      await auth.signOut();
      emit(
          AuthLogOutSucsses()); // Emit an initial state or a logout success state
    } catch (e) {
      log('Error logging out: $e');
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    log(change.toString());
    super.onChange(change);
  }
}

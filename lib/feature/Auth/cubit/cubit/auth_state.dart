part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthRegisterSucsses extends AuthState {}

final class AuthLogInSucsses extends AuthState {}

final class AuthForgetPasswordSucsses extends AuthState {}

final class AuthFaileRegister extends AuthState {
  String errorMassage;
  AuthFaileRegister({required this.errorMassage});
}

final class AuthFaileLogin extends AuthState {
  String errorMassage;
  AuthFaileLogin({required this.errorMassage});
}

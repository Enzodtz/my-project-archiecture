part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLogged extends UserState {
  final User user;

  UserLogged(this.user);
}

class UserError extends UserState {
  final Map<String, dynamic> previousForm;
  final String message;

  UserError(this.message, this.previousForm);
}

part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserLogin extends UserEvent {
  final Map<String, dynamic> form;

  UserLogin(this.form);
}

class UserRead extends UserEvent {}

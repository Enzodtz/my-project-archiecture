import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/bloc/user_bloc.dart';
import 'package:frontend/screens/login.dart';

class LoginRoute {
  static const String PATH = '/';
  static MaterialPageRoute getRoute(UserBloc todoBloc) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<UserBloc>.value(
        value: todoBloc,
        child: LoginScreen(),
      ),
    );
  }
}

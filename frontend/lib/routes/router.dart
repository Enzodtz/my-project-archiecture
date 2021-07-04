import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/bloc/user_bloc.dart';
import 'package:frontend/routes/login.dart';

class AppRouter {
  late final UserBloc userBloc = UserBloc();

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginRoute.PATH:
        return LoginRoute.getRoute(userBloc);
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}

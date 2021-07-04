import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/user.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    add(UserRead());
  }

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserLogin) {
      yield UserLoading();
      try {
        User user = await UserRepository.login(event.form);
        yield UserLogged(user);
      } on Exception catch (e) {
        yield UserError(e.toString(), event.form);
      }
    } else if (event is UserRead) {
      yield UserLoading();
      try {
        User user = await UserRepository.read();
        yield UserLogged(user);
      } on Exception {
        yield UserInitial();
      }
    }
  }
}

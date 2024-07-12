import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_entries/models/userdetails.dart';
import 'package:user_entries/repository/user_repository.dart';

import 'users_event.dart';
import 'users_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  int currentPage = 1;
  static List<Userr> users = [];
  UserBloc() : super(UserLoading()) {
    on<FetchUsers>(
      (event, emit) async {
        if (users.isNotEmpty) {
          emit(UserChange());
          emit(UsersLoaded(users, true));
        }
        List<Userr> user = await UserRepository.getUserLists(event.page);
        users.addAll(user);
        if (event.page == 2) {
          currentPage = 2;
        }
        await Future.delayed(Duration(seconds: 2), () {});

        emit(UserChange());
        emit(UsersLoaded(users, false));
      },
    );
    on<FetchUser>(
      (event, emit) async {
        Userr user = await UserRepository.getUserDetails(event.userId);
        emit(UserDetailsLoaded(user));
      },
    );
  }
}

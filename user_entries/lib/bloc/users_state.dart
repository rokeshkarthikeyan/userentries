import 'package:equatable/equatable.dart';
import 'package:user_entries/models/userdetails.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserChange extends UserState {}

class UserLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<Userr> users;
  final bool isLoading;

  UsersLoaded(this.users, this.isLoading);

  @override
  List<Object> get props => [users];
}

class UserDetailsLoaded extends UserState {
  final Userr user;

  UserDetailsLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object> get props => [message];
}

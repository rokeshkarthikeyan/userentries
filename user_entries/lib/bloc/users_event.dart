import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {
  final int page;

  FetchUsers(this.page);

  @override
  List<Object> get props => [page];
}

class FetchUser extends UserEvent {
  final int userId;

  FetchUser(this.userId);

  @override
  List<Object> get props => [userId];
}
